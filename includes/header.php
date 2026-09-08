<?php require_once __DIR__.'/auth.php'; $user=current_user(); $flash=take_flash(); ?>
<!doctype html><html lang="en"><head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title><?= e($page_title ?? 'ZAIN STORE') ?> · ZAIN STORE</title>
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="assets/css/style.css">
</head><body class="<?=e($page_class ?? "")?>">
<div class="topbar">Free shipping on orders over $100 <span>·</span> Easy 30-day returns</div>
<header class="site-header"><a class="brand" href="index.php">ZAIN STORE<span>.</span></a>
<nav class="main-nav"><a href="index.php">Home</a><a href="shop.php">Shop</a><a href="shop.php?category=Fashion">Fashion</a><a href="about.php">About</a><a href="contact.php">Contact</a></nav>
<div class="header-actions">
<a class="header-icon" href="shop.php" aria-label="Search" title="Search"><svg viewBox="0 0 24 24" aria-hidden="true"><circle cx="11" cy="11" r="6.5"></circle><path d="m16 16 4 4"></path></svg></a>
<a class="header-icon" href="wishlist.php" aria-label="Wishlist" title="Wishlist"><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M20.8 8.6c0 5-8.8 10-8.8 10s-8.8-5-8.8-10A4.8 4.8 0 0 1 12 6.1a4.8 4.8 0 0 1 8.8 2.5Z"></path></svg></a>
<?php if($user): ?><a class="header-icon" href="account.php" aria-label="Account" title="Account"><svg viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="8" r="3.2"></circle><path d="M5.5 20c.7-3.2 3-5 6.5-5s5.8 1.8 6.5 5"></path></svg></a><?php else: ?><a class="header-icon" href="login.php" aria-label="Login" title="Login"><svg viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="8" r="3.2"></circle><path d="M5.5 20c.7-3.2 3-5 6.5-5s5.8 1.8 6.5 5"></path></svg></a><?php endif; ?>
<a class="cart-link" href="cart.php">Bag <b><?= cart_count() ?></b></a><button class="menu-btn" onclick="toggleMenu()">☰</button></div></header>
<?php if($flash): ?><div class="toast <?=e($flash[0])?>"><?=e($flash[1])?></div><?php endif; ?>
<main>
