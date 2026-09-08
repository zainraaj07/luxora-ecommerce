<?php $page_title='Shop'; $page_class='reference-page shop-page'; require_once 'includes/auth.php';
$q=trim($_GET['q']??'');$cat=trim($_GET['category']??'');$sort=$_GET['sort']??'newest';
$minPrice=max(0,(float)($_GET['min_price']??0));$maxPrice=max($minPrice,(float)($_GET['max_price']??200));
$ratingMin=max(0,min(5,(float)($_GET['rating_min']??0)));$inStock=!empty($_GET['in_stock']);$onSale=!empty($_GET['on_sale']);
$where=["p.status='active'"]; $params=[];
if($q){$where[]="(p.name LIKE ? OR p.description LIKE ?)";$params[]="%$q%";$params[]="%$q%";}
if($cat){$where[]="c.name=?";$params[]=$cat;}
if(isset($_GET['min_price']) || isset($_GET['max_price'])){$where[]="(p.price*(1-p.discount/100)) BETWEEN ? AND ?";$params[]=$minPrice;$params[]=$maxPrice;}
if($ratingMin>0){$where[]="p.rating>=?";$params[]=$ratingMin;}
if($inStock){$where[]="p.stock>0";}
if($onSale){$where[]="p.discount>0";}
$order=['newest'=>'p.created_at DESC','price_low'=>'(p.price*(1-p.discount/100)) ASC','price_high'=>'(p.price*(1-p.discount/100)) DESC','rating'=>'p.rating DESC'][$sort]??'p.created_at DESC';
$sql="SELECT p.*,c.name category_name FROM products p LEFT JOIN categories c ON c.id=p.category_id WHERE ".implode(' AND ',$where)." ORDER BY $order";
$s=$pdo->prepare($sql);$s->execute($params);$products=$s->fetchAll();$cats=$pdo->query("SELECT name FROM categories ORDER BY name")->fetchAll();
require 'includes/header.php'; ?>
<div class="container shop-heading">
    <div class="breadcrumbs"><a href="index.php">Home</a><span>›</span><strong>Shop</strong></div>
    <div class="shop-title-row"><h1>Shop</h1><div class="shop-mobile-filter"><button type="button" id="mobileFilterBtn">Filters</button></div><form method="get" class="shop-sort-form">
        <input type="hidden" name="q" value="<?=e($q)?>"><input type="hidden" name="category" value="<?=e($cat)?>">
        <input type="hidden" name="min_price" value="<?=e($minPrice)?>"><input type="hidden" name="max_price" value="<?=e($maxPrice)?>">
        <input type="hidden" name="rating_min" value="<?=e($ratingMin)?>"><input type="hidden" name="in_stock" value="<?=e($inStock?'1':'')?>"><input type="hidden" name="on_sale" value="<?=e($onSale?'1':'')?>">
        <label>Sort by <select name="sort" onchange="this.form.submit()"><option value="newest" <?=$sort==='newest'?'selected':''?>>Featured</option><option value="price_low" <?=$sort==='price_low'?'selected':''?>>Price low</option><option value="price_high" <?=$sort==='price_high'?'selected':''?>>Price high</option><option value="rating" <?=$sort==='rating'?'selected':''?>>Top rated</option></select></label>
        <button class="view-control active" type="button" aria-label="Grid view">▦</button><button class="view-control" type="button" aria-label="List view">☷</button>
    </form></div>
</div>
<section class="section container shop-section"><div class="shop-layout">
<aside class="shop-sidebar">
<form method="get">
<input type="hidden" name="q" value="<?=e($q)?>"><input type="hidden" name="sort" value="<?=e($sort)?>">
<div class="filter-group"><h4>Categories <span>⌄</span></h4>
<label><input type="radio" name="category" value="" <?=!$cat?'checked':''?>> <span>All Products</span></label>
<?php foreach($cats as $c): $label=$c['name']==='Caps & Accessories'?'Accessories':$c['name']; ?><label><input type="radio" name="category" value="<?=e($c['name'])?>" <?=($cat==$c['name']?'checked':'')?>> <span><?=e($label)?></span></label><?php endforeach; ?>
</div>
<div class="filter-group"><h4>Price Range <span>⌄</span></h4><div class="price-inputs"><input class="input" type="number" name="min_price" min="0" max="300" value="<?=e($minPrice)?>"><input class="input" type="number" name="max_price" min="0" max="300" value="<?=e($maxPrice)?>"></div><input class="price-range" type="range" min="0" max="300" value="<?=e($maxPrice)?>" oninput="this.form.max_price.value=this.value"><div class="range-labels"><span>$0</span><span>$300</span></div></div>
<div class="filter-group"><h4>Rating <span>⌄</span></h4><?php foreach([5,4,3,2,1] as $r): ?><label><input type="radio" name="rating_min" value="<?=$r?>" <?=((float)$ratingMin===$r?'checked':'')?>><span class="stars">★★★★★</span> <em>&amp; Up</em></label><?php endforeach; ?></div>
<div class="filter-group"><h4>Availability <span>⌄</span></h4><label><input type="checkbox" name="in_stock" value="1" <?=$inStock?'checked':''?>><span>In Stock</span></label><label><input type="checkbox" name="on_sale" value="1" <?=$onSale?'checked':''?>><span>On Sale</span></label></div>
<button class="reset-filters" type="reset" onclick="location.href='shop.php';return false;">Reset Filters</button>
<button class="apply-mobile" type="submit">Apply Filters</button>
</form></aside>
<div class="shop-results">
<div class="mobile-search"><form method="get"><input class="input" name="q" placeholder="Search products…" value="<?=e($q)?>"><button class="btn small">Search</button></form></div>
<div class="grid shop-grid">
<?php foreach($products as $p): $displayCategory=($p['category_name']??'Collection')==='Caps & Accessories'?'Accessories':($p['category_name']??'Collection'); ?>
<article class="product-card">
<div class="product-image"><a class="product-media-link" href="product.php?id=<?=$p['id']?>"><img class="product-main-image" src="<?=e($p['main_image'])?>" alt="<?=e($p['name'])?>"><?php if(!empty($p['secondary_image'])):?><img class="product-secondary-image" src="<?=e($p['secondary_image'])?>" alt="<?=e($p['name'])?> alternate view"><?php endif;?></a>
<?php if(current_user()): ?><form method="post" action="wishlist.php"><input type="hidden" name="csrf" value="<?=csrf_token()?>"><input type="hidden" name="product_id" value="<?=$p['id']?>"><button class="product-wishlist" type="submit" aria-label="Add to wishlist">♡</button></form><?php else: ?><a class="product-wishlist" href="login.php" aria-label="Login to use wishlist">♡</a><?php endif;?>
<?php if($p['discount']>0):?><span class="pill">Sale</span><?php endif;?></div>
<a href="product.php?id=<?=$p['id']?>" class="product-info"><small><?=e($displayCategory)?></small><h3><?=e($p['name'])?></h3><span class="price"><?=money(sale_price($p))?></span><?php if((float)$p['rating']>0): ?><div class="rating">★ <?=number_format((float)$p['rating'],1)?> <span style="color:#999">(<?=number_format((int)$p['review_count'])?>)</span></div><?php endif;?><?php if($p['discount']>0):?><span class="old"><?=money((float)$p['price'])?></span><?php endif;?></a>
<div class="quick"><form method="post" action="cart.php"><input type="hidden" name="csrf" value="<?=csrf_token()?>"><input type="hidden" name="action" value="add"><input type="hidden" name="product_id" value="<?=$p['id']?>"><button class="btn small">Add to bag</button></form></div>
</article>
<?php endforeach; ?></div><?php if(!$products):?><div class="empty">No products matched your search.</div><?php endif;?></div>
</div></section>
<?php require 'includes/footer.php'; ?>
