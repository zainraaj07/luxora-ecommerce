<?php
require_once 'includes/auth.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_check();
    $action = $_POST['action'] ?? '';
    $pid = (int)($_POST['product_id'] ?? 0);

    if ($action === 'add') {
        add_cart($pid, (int)($_POST['quantity'] ?? 1));
        flash('success', 'Added to your bag.');
        header('Location: cart.php');
        exit;
    }

    if ($action === 'remove') {
        if (!empty($_SESSION['user_id'])) {
            $pdo->prepare("DELETE FROM cart WHERE user_id=? AND product_id=?")->execute([$_SESSION['user_id'], $pid]);
        } else {
            unset($_SESSION['guest_cart'][$pid]);
        }
        flash('success', 'Item removed from your bag.');
        header('Location: cart.php');
        exit;
    }

    if ($action === 'update') {
        foreach (($_POST['qty'] ?? []) as $id => $qty) {
            $id = (int)$id;
            $qty = max(0, (int)$qty);
            $s = $pdo->prepare("SELECT stock FROM products WHERE id=? AND status='active'");
            $s->execute([$id]);
            $stock = (int)($s->fetchColumn() ?: 0);

            if (!empty($_SESSION['user_id'])) {
                if ($qty === 0) {
                    $pdo->prepare("DELETE FROM cart WHERE user_id=? AND product_id=?")->execute([$_SESSION['user_id'], $id]);
                } else {
                    $pdo->prepare("UPDATE cart SET quantity=? WHERE user_id=? AND product_id=?")
                        ->execute([min($qty, $stock), $_SESSION['user_id'], $id]);
                }
            } else {
                if ($qty === 0) {
                    unset($_SESSION['guest_cart'][$id]);
                } else {
                    $_SESSION['guest_cart'][$id] = min($qty, $stock);
                }
            }
        }
        flash('success', 'Your bag has been updated.');
        header('Location: cart.php');
        exit;
    }
}

$items = cart_items();
$subtotal = 0;
foreach ($items as $i) $subtotal += sale_price($i) * (int)$i['quantity'];
$shipping = $subtotal ? 8 : 0;
$tax = $subtotal * .05;
$total = $subtotal + $shipping + $tax;
$page_title = 'Shopping Bag';
require 'includes/header.php';
?>
<div class="container page-title"><span class="eyebrow">Your selection</span><h1>Shopping bag</h1></div>
<section class="section container" style="padding-top:10px">
<?php if (!$items): ?>
<div class="empty">Your bag is waiting for something special.<br><br><a class="btn" href="shop.php">Continue shopping</a></div>
<?php else: ?>
<div class="cart-layout">
  <div>
    <form method="post">
      <input type="hidden" name="csrf" value="<?=csrf_token()?>">
      <input type="hidden" name="action" value="update">
      <?php foreach ($items as $i): $itemId=(int)($i['product_id'] ?? $i['id']); ?>
      <div class="cart-item">
        <div class="cart-thumb"><?php if ($i['main_image']): ?><img src="<?=e($i['main_image'])?>" alt="<?=e($i['name'])?>"><?php endif; ?></div>
        <div>
          <a href="product.php?id=<?=$itemId?>"><strong><?=e($i['name'])?></strong></a>
          <div><?=money(sale_price($i))?></div>
          <input class="input" style="width:90px" type="number" min="0" max="<?=$i['stock']?>" name="qty[<?=$itemId?>]" value="<?=$i['quantity']?>">
        </div>
        <div class="price">
          <?=money(sale_price($i)*(int)$i['quantity'])?>
        </div>
      </div>
      <?php endforeach; ?>
      <button class="btn light" style="margin-top:15px">Update bag</button>
    </form>
    <?php foreach ($items as $i): $itemId=(int)($i['product_id'] ?? $i['id']); ?>
      <form method="post" style="margin-top:6px">
        <input type="hidden" name="csrf" value="<?=csrf_token()?>">
        <input type="hidden" name="action" value="remove">
        <input type="hidden" name="product_id" value="<?=$itemId?>">
        <button class="danger" style="border:0;background:none">Remove <?=e($i['name'])?></button>
      </form>
    <?php endforeach; ?>
  </div>
  <aside class="summary">
    <h2>Summary</h2>
    <div class="summary-row"><span>Subtotal</span><b><?=money($subtotal)?></b></div>
    <div class="summary-row"><span>Shipping</span><span><?=money($shipping)?></span></div>
    <div class="summary-row"><span>Tax</span><span><?=money($tax)?></span></div>
    <div class="summary-row summary-total"><span>Total</span><b><?=money($total)?></b></div>
    <a class="btn" style="width:100%;margin-top:18px" href="checkout.php">Checkout</a>
  </aside>
</div>
<?php endif; ?>
</section>
<?php require 'includes/footer.php'; ?>
