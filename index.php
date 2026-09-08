<?php $page_title='Home'; $page_class='reference-page home-page'; require_once 'includes/auth.php';
$settings=[];$s=$pdo->query("SELECT setting_key,setting_value FROM site_settings");foreach($s as $r)$settings[$r['setting_key']]=$r['setting_value'];
$products=$pdo->query("SELECT p.*,c.name category_name FROM products p LEFT JOIN categories c ON c.id=p.category_id WHERE p.status='active' ORDER BY p.created_at DESC LIMIT 8")->fetchAll();
$categoryImages = [
 'Fashion' => ['url'=>'https://images.unsplash.com/photo-1610502778270-c5c6f4c7d575?auto=format&fit=crop&fm=jpg&ixlib=rb-4.1.0&q=85&w=1400','local'=>'assets/images/categories/fashion.jpg'],
 'Watches' => ['url'=>'https://images.unsplash.com/photo-1716978502767-1d8244462f3c?fm=jpg&ixlib=rb-4.1.0&q=85&w=1400','local'=>'assets/images/categories/watches.jpg'],
 'Caps & Accessories' => ['url'=>'https://images.unsplash.com/photo-1645266729222-17cd32e06fd0?auto=format&fit=crop&fm=jpg&ixlib=rb-4.1.0&q=85&w=1400','local'=>'assets/images/categories/caps-accessories.jpg'],
 'Shoes' => ['url'=>'https://images.unsplash.com/photo-1778521157912-620fd0d3c6e1?auto=format&fit=crop&fm=jpg&ixlib=rb-4.1.0&q=85&w=1400','local'=>'assets/images/categories/shoes.jpg'],
 'Sports' => ['url'=>'assets/images/categories/sports.jpg','local'=>'assets/images/categories/sports.jpg'],
 'Electronics' => ['url'=>'https://images.unsplash.com/photo-1780642209914-c61dfe2afe11?auto=format&fit=crop&fm=jpg&ixlib=rb-4.1.0&q=85&w=1400','local'=>'assets/images/categories/electronics.jpg'],
 'Beauty' => ['url'=>'assets/images/categories/beauty.jpg','local'=>'assets/images/categories/beauty.jpg'],
 'Home & Lifestyle' => ['url'=>'https://images.unsplash.com/photo-1604160526046-937cf7465b83?auto=format&fit=crop&fm=jpg&ixlib=rb-4.1.0&q=85&w=1400','local'=>'assets/images/categories/home-lifestyle.jpg'],
];
require 'includes/header.php'; ?>
<section class="hero hero-premium"><div class="hero-copy"><span class="eyebrow">ZAIN STORE / THE NEW EDIT</span><h1>Elevate your everyday.</h1><p>Discover premium fashion, watches, caps, sports essentials and lifestyle pieces curated for modern living.</p><div class="hero-cta"><a class="btn" href="shop.php">Shop Now →</a><a class="btn light" href="shop.php">Explore Collection</a></div><div class="hero-proof"><span>✦ Curated essentials</span><span>✦ Premium quality</span><span>✦ Easy returns</span></div></div><div class="hero-art hero-collage"><div class="hero-orbit orbit-a"></div><div class="hero-orbit orbit-b"></div><div class="hero-card hero-card-main"><img src="assets/images/products/classic-leather-watch.jpg" alt="Classic Leather Watch"></div><div class="hero-card hero-card-cap"><img src="assets/images/products/classic-black-cap.jpg" alt="Classic Black Cap"></div><div class="hero-card hero-card-shoe"><img src="assets/images/products/running-shoes.jpg" alt="Running Shoes"></div><div class="hero-label">ZAIN STORE<br><small>MODERN / CURATED</small></div></div></section>
<section class="section container"><div class="section-head"><div><span class="eyebrow">Curated for you</span><h2>New arrivals</h2></div><a href="shop.php">View all →</a></div><div class="grid">
<?php foreach($products as $p): ?>
<article class="product-card">
    <div class="product-image">
        <a class="product-media-link" href="product.php?id=<?=$p['id']?>">
            <?php if($p['main_image']): ?>
                <img class="product-main-image" src="<?=e($p['main_image'])?>" alt="<?=e($p['name'])?>">
                <?php if(!empty($p['secondary_image'])): ?><img class="product-secondary-image" src="<?=e($p['secondary_image'])?>" alt="<?=e($p['name'])?> alternate view"><?php endif; ?>
            <?php else: ?><span class="placeholder">Z</span><?php endif; ?>
        </a>
        <?php if($p['discount']>0): ?><span class="pill">Sale</span><?php endif; ?>
        <?php if(current_user()): ?>
        <form method="post" action="wishlist.php"><input type="hidden" name="csrf" value="<?=csrf_token()?>"><input type="hidden" name="product_id" value="<?=$p['id']?>"><button class="product-wishlist" type="submit" aria-label="Add to wishlist">♡</button></form>
        <?php else: ?><a class="product-wishlist" href="login.php" aria-label="Login to use wishlist">♡</a><?php endif; ?>
    </div>
    <a href="product.php?id=<?=$p['id']?>" class="product-info">
        <small><?=e(($p['category_name']??'Collection')==='Caps & Accessories'?'Accessories':($p['category_name']??'Collection'))?></small>
        <h3><?=e($p['name'])?></h3>
        <span class="price"><?=money(sale_price($p))?></span>
        <?php if((float)$p['rating']>0): ?><div class="rating">★ <?=number_format((float)$p['rating'],1)?> <span style="color:#999">(<?=number_format((int)$p['review_count'])?>)</span></div><?php endif;?>
        <?php if($p['discount']>0): ?><span class="old"><?=money((float)$p['price'])?></span><?php endif;?>
    </a>
    <div class="quick"><form method="post" action="cart.php"><input type="hidden" name="csrf" value="<?=csrf_token()?>"><input type="hidden" name="action" value="add"><input type="hidden" name="product_id" value="<?=$p['id']?>"><button class="btn small" style="width:100%">Add to bag</button></form></div>
</article>
<?php endforeach; ?>
</div></section>
<section class="section container"><div class="section-head"><div><span class="eyebrow">Shop by mood</span><h2>Explore categories</h2></div></div><div class="categories"><?php $cats=$pdo->query("SELECT * FROM categories ORDER BY id")->fetchAll(); foreach($cats as $c): $ci=$categoryImages[$c['name']]??['url'=>'assets/images/categories/home-lifestyle.jpg','local'=>'assets/images/categories/home-lifestyle.jpg']; ?><a class="category-card" href="shop.php?category=<?=urlencode($c['name'])?>"><img src="<?=e($ci['url'])?>" data-local-fallback="<?=e($ci['local'])?>" alt="<?=e($c['name'])?>" onerror="this.onerror=null;this.src=this.dataset.localFallback;"><span><?=e($c['name'])?></span><i>↗</i></a><?php endforeach;?></div></section>
<section class="container banner"><span class="eyebrow">Limited edit</span><h2><?=e($settings['promo_text']??'Special seasonal offers')?></h2><p>Discover selected pieces while the edit lasts.</p><a class="btn light" href="shop.php">Explore sale</a></section>
<?php require 'includes/footer.php'; ?>
