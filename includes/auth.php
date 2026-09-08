<?php
declare(strict_types=1);
if (session_status() !== PHP_SESSION_ACTIVE) {
    session_start();
}
require_once __DIR__ . '/../config/database.php';

function e(?string $value): string {
    return htmlspecialchars($value ?? '', ENT_QUOTES, 'UTF-8');
}
function csrf_token(): string {
    if (empty($_SESSION['csrf'])) $_SESSION['csrf'] = bin2hex(random_bytes(32));
    return $_SESSION['csrf'];
}
function csrf_check(): void {
    $sessionToken = (string)($_SESSION['csrf'] ?? '');
    $requestToken = (string)($_POST['csrf'] ?? ($_SERVER['HTTP_X_CSRF_TOKEN'] ?? ''));
    if ($sessionToken === '' || $requestToken === '' || !hash_equals($sessionToken, $requestToken)) {
        http_response_code(419);
        exit('Invalid security token.');
    }
}
function current_user(): ?array {
    global $pdo;
    if (empty($_SESSION['user_id'])) return null;
    static $u = false;
    if ($u !== false) return $u;
    $s = $pdo->prepare("SELECT * FROM users WHERE id=? LIMIT 1");
    $s->execute([$_SESSION['user_id']]);
    $u = $s->fetch() ?: null;
    return $u;
}
function require_login(): void {
    if (!current_user()) { header('Location: login.php'); exit; }
}
function require_admin(): void {
    $u = current_user();
    if (!$u || $u['role'] !== 'admin' || $u['status'] !== 'active') {
        header('Location: login.php');
        exit;
    }
}
function money(float $n): string { return '$' . number_format($n, 2); }
function flash(string $type, string $message): void { $_SESSION['flash'] = [$type, $message]; }
function take_flash(): ?array { $x = $_SESSION['flash'] ?? null; unset($_SESSION['flash']); return $x; }

function cart_count(): int {
    global $pdo;
    if (!empty($_SESSION['user_id'])) {
        $s = $pdo->prepare("SELECT COALESCE(SUM(quantity),0) c FROM cart WHERE user_id=?");
        $s->execute([$_SESSION['user_id']]);
        return (int)$s->fetch()['c'];
    }
    return (int)array_sum($_SESSION['guest_cart'] ?? []);
}
function add_cart(int $productId, int $qty=1): void {
    global $pdo;
    $qty = max(1, $qty);
    $s = $pdo->prepare("SELECT id,stock,status FROM products WHERE id=?");
    $s->execute([$productId]); $p=$s->fetch();
    if (!$p || $p['status'] !== 'active' || $p['stock'] < 1) return;
    $qty = min($qty, (int)$p['stock']);
    if (!empty($_SESSION['user_id'])) {
        $s=$pdo->prepare("SELECT id,quantity FROM cart WHERE user_id=? AND product_id=?");
        $s->execute([$_SESSION['user_id'],$productId]); $row=$s->fetch();
        if ($row) {
            $new=min((int)$p['stock'], (int)$row['quantity']+$qty);
            $pdo->prepare("UPDATE cart SET quantity=? WHERE id=?")->execute([$new,$row['id']]);
        } else $pdo->prepare("INSERT INTO cart(user_id,product_id,quantity) VALUES(?,?,?)")->execute([$_SESSION['user_id'],$productId,$qty]);
    } else {
        $_SESSION['guest_cart'][$productId] = min((int)$p['stock'], ($_SESSION['guest_cart'][$productId] ?? 0)+$qty);
    }
}
function cart_items(): array {
    global $pdo;
    $items=[];
    if (!empty($_SESSION['user_id'])) {
        $s=$pdo->prepare("SELECT c.*,p.name,p.price,p.discount,p.stock,p.main_image,p.status FROM cart c JOIN products p ON p.id=c.product_id WHERE c.user_id=? ORDER BY c.created_at DESC");
        $s->execute([$_SESSION['user_id']]); $items=$s->fetchAll();
    } else {
        $ids=array_keys($_SESSION['guest_cart'] ?? []);
        if ($ids) {
            $in=implode(',',array_fill(0,count($ids),'?'));
            $s=$pdo->prepare("SELECT id,name,price,discount,stock,main_image,status FROM products WHERE id IN ($in)");
            $s->execute($ids);
            foreach($s->fetchAll() as $p){$p['quantity']=$_SESSION['guest_cart'][$p['id']];$items[]=$p;}
        }
    }
    return $items;
}
function sale_price(array $p): float {
    $d=max(0,min(100,(float)($p['discount'] ?? 0)));
    return (float)$p['price']*(1-$d/100);
}
