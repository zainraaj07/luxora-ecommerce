CREATE DATABASE IF NOT EXISTS premium_store CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE premium_store;

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS wishlist, cart, order_items, orders, products, categories, contact_messages, newsletter_subscribers, site_settings, users;
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE users(
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(120) NOT NULL,
 email VARCHAR(190) NOT NULL UNIQUE,
 password VARCHAR(255) NOT NULL,
 phone VARCHAR(40) NULL,
 role ENUM('admin','customer') NOT NULL DEFAULT 'customer',
 status ENUM('active','blocked') NOT NULL DEFAULT 'active',
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 INDEX(role), INDEX(status)
) ENGINE=InnoDB;

CREATE TABLE categories(
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(100) NOT NULL UNIQUE,
 description TEXT NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE products(
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 category_id INT UNSIGNED NULL,
 name VARCHAR(180) NOT NULL,
 description TEXT NOT NULL,
 price DECIMAL(12,2) NOT NULL,
 discount DECIMAL(5,2) NOT NULL DEFAULT 0,
 stock INT NOT NULL DEFAULT 0,
 rating DECIMAL(3,2) NOT NULL DEFAULT 0,
 review_count INT NOT NULL DEFAULT 0,
 main_image VARCHAR(255) NULL,
 secondary_image VARCHAR(255) NULL,
 status ENUM('active','inactive') NOT NULL DEFAULT 'active',
 views INT UNSIGNED NOT NULL DEFAULT 0,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 CONSTRAINT fk_product_category FOREIGN KEY(category_id) REFERENCES categories(id) ON DELETE SET NULL,
 INDEX(category_id), INDEX(status), INDEX(stock), INDEX(created_at)
) ENGINE=InnoDB;

CREATE TABLE orders(
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 user_id INT UNSIGNED NULL,
 customer_name VARCHAR(120) NOT NULL,
 customer_email VARCHAR(190) NOT NULL,
 phone VARCHAR(40) NOT NULL,
 shipping_address VARCHAR(255) NOT NULL,
 city VARCHAR(100) NOT NULL,
 country VARCHAR(100) NOT NULL,
 postal_code VARCHAR(30) NOT NULL,
 subtotal DECIMAL(12,2) NOT NULL,
 discount DECIMAL(12,2) NOT NULL DEFAULT 0,
 shipping DECIMAL(12,2) NOT NULL DEFAULT 0,
 tax DECIMAL(12,2) NOT NULL DEFAULT 0,
 total DECIMAL(12,2) NOT NULL,
 payment_method ENUM('cod','card','paypal') NOT NULL DEFAULT 'cod',
 payment_status ENUM('pending','paid','failed','refunded') NOT NULL DEFAULT 'pending',
 order_status ENUM('pending','processing','shipped','delivered','cancelled') NOT NULL DEFAULT 'pending',
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT fk_order_user FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE SET NULL,
 INDEX(user_id), INDEX(order_status), INDEX(payment_method), INDEX(created_at)
) ENGINE=InnoDB;

CREATE TABLE order_items(
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 order_id INT UNSIGNED NOT NULL,
 product_id INT UNSIGNED NULL,
 product_name VARCHAR(180) NOT NULL,
 category_name VARCHAR(100) NULL,
 product_image VARCHAR(255) NULL,
 unit_price DECIMAL(12,2) NOT NULL,
 quantity INT NOT NULL,
 discount DECIMAL(12,2) NOT NULL DEFAULT 0,
 subtotal DECIMAL(12,2) NOT NULL,
 CONSTRAINT fk_item_order FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE CASCADE,
 CONSTRAINT fk_item_product FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE SET NULL,
 INDEX(order_id), INDEX(product_id)
) ENGINE=InnoDB;

CREATE TABLE wishlist(
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 user_id INT UNSIGNED NOT NULL,
 product_id INT UNSIGNED NOT NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 UNIQUE KEY uq_wishlist(user_id,product_id),
 CONSTRAINT fk_wish_user FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
 CONSTRAINT fk_wish_product FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE cart(
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 user_id INT UNSIGNED NOT NULL,
 product_id INT UNSIGNED NOT NULL,
 quantity INT NOT NULL DEFAULT 1,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 UNIQUE KEY uq_cart(user_id,product_id),
 CONSTRAINT fk_cart_user FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
 CONSTRAINT fk_cart_product FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE contact_messages(
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(120) NOT NULL,
 email VARCHAR(190) NOT NULL,
 subject VARCHAR(190) NOT NULL,
 message TEXT NOT NULL,
 is_read TINYINT(1) NOT NULL DEFAULT 0,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 INDEX(is_read), INDEX(created_at)
) ENGINE=InnoDB;

CREATE TABLE newsletter_subscribers(
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 email VARCHAR(190) NOT NULL UNIQUE,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE site_settings(
 setting_key VARCHAR(100) PRIMARY KEY,
 setting_value TEXT NOT NULL
) ENGINE=InnoDB;

INSERT INTO categories(name,description) VALUES
('Fashion','Refined wardrobe essentials'),('Watches','Premium timepieces for every occasion'),('Caps & Accessories','Finishing touches and everyday accessories'),('Shoes','Modern footwear'),('Sports','Performance and recreation essentials'),('Electronics','Smart everyday technology'),('Beauty','Personal care and beauty'),('Home & Lifestyle','Elevated everyday living');

INSERT INTO products(category_id,name,description,price,discount,stock,rating,review_count,main_image,secondary_image,status) VALUES
(1,'Linen Tailored Shirt','Relaxed premium linen shirt with a clean tailored silhouette.',89.99,10,24,4.8,126,'assets/images/products/linen-shirt.jpg','assets/images/products/linen-shirt-2.jpg','active'),
(6,'Premium Wireless Headphones','Immersive wireless audio with all-day comfort.',99.99,20,15,4.7,89,'assets/images/products/headphones.jpg','assets/images/products/headphones-2.jpg','active'),
(4,'Minimal Leather Sneakers','Low-profile leather sneakers designed for everyday wear.',119.00,0,7,4.6,72,'assets/images/products/sneakers.jpg','assets/images/products/sneakers-2.jpg','active'),
(3,'Structured Mini Bag','A compact structured bag with refined hardware.',74.50,15,4,4.9,54,'assets/images/products/mini-bag.jpg','assets/images/products/mini-bag-2.jpg','active'),
(7,'Signature Skin Set','A simple three-step routine for a fresh finish.',64.00,5,18,4.5,41,'assets/images/products/skin-set.jpg','assets/images/products/skin-set-2.jpg','active'),
(8,'Ceramic Table Lamp','Warm ambient lighting with a sculptural ceramic base.',82.00,0,9,4.8,33,'assets/images/products/table-lamp.jpg','assets/images/products/table-lamp-2.jpg','active'),
(1,'Premium Oversized T-Shirt','Premium Oversized T-Shirt crafted for modern everyday use with a premium LUXORA finish.',49.00,10,35,4.7,92,'assets/images/products/premium-oversized-t-shirt.jpg','assets/images/products/premium-oversized-t-shirt-2.jpg','active'),
(1,'Classic Cotton Shirt','Classic Cotton Shirt crafted for modern everyday use with a premium LUXORA finish.',59.00,0,28,4.6,74,'assets/images/products/classic-cotton-shirt.jpg','assets/images/products/classic-cotton-shirt-2.jpg','active'),
(1,'Casual Hoodie','Casual Hoodie crafted for modern everyday use with a premium LUXORA finish.',69.00,15,22,4.8,108,'assets/images/products/casual-hoodie.jpg','assets/images/products/casual-hoodie-2.jpg','active'),
(1,'Premium Polo Shirt','Premium Polo Shirt crafted for modern everyday use with a premium LUXORA finish.',54.00,10,31,4.7,81,'assets/images/products/premium-polo-shirt.jpg','assets/images/products/premium-polo-shirt-2.jpg','active'),
(1,'Relaxed Fit Jeans','Relaxed Fit Jeans crafted for modern everyday use with a premium LUXORA finish.',79.00,12,19,4.6,67,'assets/images/products/relaxed-fit-jeans.jpg','assets/images/products/relaxed-fit-jeans-2.jpg','active'),
(1,'Cargo Pants','Cargo Pants crafted for modern everyday use with a premium LUXORA finish.',72.00,0,17,4.5,53,'assets/images/products/cargo-pants.jpg','assets/images/products/cargo-pants-2.jpg','active'),
(1,'Denim Jacket','Denim Jacket crafted for modern everyday use with a premium LUXORA finish.',99.00,15,12,4.8,46,'assets/images/products/denim-jacket.jpg','assets/images/products/denim-jacket-2.jpg','active'),
(1,'Sports Tracksuit','Sports Tracksuit crafted for modern everyday use with a premium LUXORA finish.',89.00,10,16,4.6,39,'assets/images/products/sports-tracksuit.jpg','assets/images/products/sports-tracksuit-2.jpg','active'),
(1,'Casual Shorts','Casual Shorts crafted for modern everyday use with a premium LUXORA finish.',42.00,0,30,4.5,51,'assets/images/products/casual-shorts.jpg','assets/images/products/casual-shorts-2.jpg','active'),
(2,'Classic Leather Watch','Classic Leather Watch crafted for modern everyday use with a premium LUXORA finish.',129.00,10,14,4.9,132,'assets/images/products/classic-leather-watch.jpg','assets/images/products/classic-leather-watch-2.jpg','active'),
(2,'Premium Steel Watch','Premium Steel Watch crafted for modern everyday use with a premium LUXORA finish.',159.00,15,11,4.8,94,'assets/images/products/premium-steel-watch.jpg','assets/images/products/premium-steel-watch-2.jpg','active'),
(2,'Minimal Black Watch','Minimal Black Watch crafted for modern everyday use with a premium LUXORA finish.',119.00,0,20,4.7,77,'assets/images/products/minimal-black-watch.jpg','assets/images/products/minimal-black-watch-2.jpg','active'),
(2,'Chronograph Watch','Chronograph Watch crafted for modern everyday use with a premium LUXORA finish.',189.00,20,8,4.9,61,'assets/images/products/chronograph-watch.jpg','assets/images/products/chronograph-watch-2.jpg','active'),
(2,'Sport Digital Watch','Sport Digital Watch crafted for modern everyday use with a premium LUXORA finish.',89.00,5,24,4.6,58,'assets/images/products/sport-digital-watch.jpg','assets/images/products/sport-digital-watch-2.jpg','active'),
(2,'Luxury Style Watch','Luxury Style Watch crafted for modern everyday use with a premium LUXORA finish.',219.00,18,6,4.9,43,'assets/images/products/luxury-style-watch.jpg','assets/images/products/luxury-style-watch-2.jpg','active'),
(3,'Classic Black Cap','Classic Black Cap crafted for modern everyday use with a premium LUXORA finish.',29.00,0,40,4.7,119,'assets/images/products/classic-black-cap.jpg','assets/images/products/classic-black-cap-2.jpg','active'),
(3,'Premium Baseball Cap','Premium Baseball Cap crafted for modern everyday use with a premium LUXORA finish.',34.00,10,26,4.8,86,'assets/images/products/premium-baseball-cap.jpg','assets/images/products/premium-baseball-cap-2.jpg','active'),
(3,'Minimal Logo Cap','Minimal Logo Cap crafted for modern everyday use with a premium LUXORA finish.',31.00,5,32,4.6,62,'assets/images/products/minimal-logo-cap.jpg','assets/images/products/minimal-logo-cap-2.jpg','active'),
(3,'Vintage Sports Cap','Vintage Sports Cap crafted for modern everyday use with a premium LUXORA finish.',36.00,12,18,4.7,48,'assets/images/products/vintage-sports-cap.jpg','assets/images/products/vintage-sports-cap-2.jpg','active'),
(3,'Cotton Snapback','Cotton Snapback crafted for modern everyday use with a premium LUXORA finish.',39.00,0,21,4.8,57,'assets/images/products/cotton-snapback.jpg','assets/images/products/cotton-snapback-2.jpg','active'),
(3,'Premium Sunglasses','Premium Sunglasses crafted for modern everyday use with a premium LUXORA finish.',69.00,15,15,4.6,72,'assets/images/products/premium-sunglasses.jpg','assets/images/products/premium-sunglasses-2.jpg','active'),
(3,'Leather Wallet','Leather Wallet crafted for modern everyday use with a premium LUXORA finish.',45.00,0,25,4.8,88,'assets/images/products/leather-wallet.jpg','assets/images/products/leather-wallet-2.jpg','active'),
(3,'Minimal Belt','Minimal Belt crafted for modern everyday use with a premium LUXORA finish.',38.00,5,27,4.6,49,'assets/images/products/minimal-belt.jpg','assets/images/products/minimal-belt-2.jpg','active'),
(5,'Professional Cricket Bat','Professional Cricket Bat crafted for modern everyday use with a premium LUXORA finish.',139.00,10,9,4.9,73,'assets/images/products/professional-cricket-bat.jpg','assets/images/products/professional-cricket-bat-2.jpg','active'),
(5,'Tennis Ball Set','Tennis Ball Set crafted for modern everyday use with a premium LUXORA finish.',24.00,0,45,4.6,34,'assets/images/products/tennis-ball-set.jpg','assets/images/products/tennis-ball-set-2.jpg','active'),
(5,'Premium Cricket Ball','Premium Cricket Ball crafted for modern everyday use with a premium LUXORA finish.',19.00,0,50,4.7,41,'assets/images/products/premium-cricket-ball.jpg','assets/images/products/premium-cricket-ball-2.jpg','active'),
(5,'Match Football','Match Football crafted for modern everyday use with a premium LUXORA finish.',49.00,12,20,4.8,64,'assets/images/products/match-football.jpg','assets/images/products/match-football-2.jpg','active'),
(5,'Pro Basketball','Pro Basketball crafted for modern everyday use with a premium LUXORA finish.',44.00,5,18,4.7,38,'assets/images/products/pro-basketball.jpg','assets/images/products/pro-basketball-2.jpg','active'),
(5,'Training Football','Training Football crafted for modern everyday use with a premium LUXORA finish.',35.00,0,26,4.5,29,'assets/images/products/training-football.jpg','assets/images/products/training-football-2.jpg','active'),
(5,'Sports Water Bottle','Sports Water Bottle crafted for modern everyday use with a premium LUXORA finish.',27.00,10,34,4.8,91,'assets/images/products/sports-water-bottle.jpg','assets/images/products/sports-water-bottle-2.jpg','active'),
(5,'Gym Gloves','Gym Gloves crafted for modern everyday use with a premium LUXORA finish.',22.00,0,29,4.6,47,'assets/images/products/gym-gloves.jpg','assets/images/products/gym-gloves-2.jpg','active'),
(4,'Running Shoes','Running Shoes crafted for modern everyday use with a premium LUXORA finish.',109.00,15,13,4.8,112,'assets/images/products/running-shoes.jpg','assets/images/products/running-shoes-2.jpg','active'),
(4,'Casual Sneakers','Casual Sneakers crafted for modern everyday use with a premium LUXORA finish.',99.00,10,16,4.7,83,'assets/images/products/casual-sneakers.jpg','assets/images/products/casual-sneakers-2.jpg','active'),
(4,'Sports Trainers','Sports Trainers crafted for modern everyday use with a premium LUXORA finish.',119.00,20,10,4.8,69,'assets/images/products/sports-trainers.jpg','assets/images/products/sports-trainers-2.jpg','active'),
(4,'Classic White Sneakers','Classic White Sneakers crafted for modern everyday use with a premium LUXORA finish.',89.00,0,23,4.7,105,'assets/images/products/classic-white-sneakers.jpg','assets/images/products/classic-white-sneakers-2.jpg','active'),
(6,'Bluetooth Earbuds','Bluetooth Earbuds crafted for modern everyday use with a premium LUXORA finish.',79.00,15,18,4.7,98,'assets/images/products/bluetooth-earbuds.jpg','assets/images/products/bluetooth-earbuds-2.jpg','active'),
(6,'Portable Speaker','Portable Speaker crafted for modern everyday use with a premium LUXORA finish.',69.00,10,14,4.6,76,'assets/images/products/portable-speaker.jpg','assets/images/products/portable-speaker-2.jpg','active'),
(6,'Wireless Charger','Wireless Charger crafted for modern everyday use with a premium LUXORA finish.',35.00,0,33,4.5,51,'assets/images/products/wireless-charger.jpg','assets/images/products/wireless-charger-2.jpg','active'),
(7,'Premium Body Care Set','Premium Body Care Set crafted for modern everyday use with a premium LUXORA finish.',58.00,10,20,4.7,44,'assets/images/products/premium-body-care-set.jpg','assets/images/products/premium-body-care-set-2.jpg','active'),
(7,'Fragrance Gift Set','Fragrance Gift Set crafted for modern everyday use with a premium LUXORA finish.',75.00,15,12,4.8,63,'assets/images/products/fragrance-gift-set.jpg','assets/images/products/fragrance-gift-set-2.jpg','active'),
(8,'Premium Coffee Mug','Premium Coffee Mug crafted for modern everyday use with a premium LUXORA finish.',24.00,0,38,4.7,55,'assets/images/products/premium-coffee-mug.jpg','assets/images/products/premium-coffee-mug-2.jpg','active'),
(8,'Scented Candle','Scented Candle crafted for modern everyday use with a premium LUXORA finish.',29.00,5,31,4.8,71,'assets/images/products/scented-candle.jpg','assets/images/products/scented-candle-2.jpg','active'),
(8,'Desk Organizer','Desk Organizer crafted for modern everyday use with a premium LUXORA finish.',32.00,0,24,4.5,33,'assets/images/products/desk-organizer.jpg','assets/images/products/desk-organizer-2.jpg','active');

INSERT INTO site_settings(setting_key,setting_value) VALUES
('store_name','LUXORA'),('store_email','hello@luxora.test'),('store_phone','+1 555 010 2040'),
('store_address','45 Market Avenue'),('business_hours','Mon–Sat · 10:00–19:00'),
('hero_heading','Elevated essentials, thoughtfully curated.'),('hero_description','Discover modern pieces across fashion, technology, beauty and home — selected for quality, utility and timeless style.'),
('promo_text','Seasonal edit · Up to 20% off selected pieces'),('currency','USD'),('tax_rate','5'),('shipping_cost','8'),
('low_stock_threshold','5'),('footer_copyright','© LUXORA. All rights reserved.');

-- Demo admin: password is Admin@123
INSERT INTO users(name,email,password,role,status) VALUES
('Zain','admin@luxora.test','$2y$12$P4O/lOWEgcJQ1H8yISDjYesBVa9aZ644e9Ge0nj3zSMf7/r33iC36','admin','active');
