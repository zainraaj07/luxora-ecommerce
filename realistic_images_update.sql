-- LUXORA realistic local product image migration
-- Image-only update for an existing database. No DROP, DELETE, table recreation, or product insertion.
-- Copy assets/images/products/*.jpg into the project before importing this file.

START TRANSACTION;
UPDATE products SET main_image='assets/images/products/linen-shirt.jpg', secondary_image='assets/images/products/linen-shirt-2.jpg' WHERE name='Linen Tailored Shirt';
UPDATE products SET main_image='assets/images/products/headphones.jpg', secondary_image='assets/images/products/headphones-2.jpg' WHERE name='Premium Wireless Headphones';
UPDATE products SET main_image='assets/images/products/sneakers.jpg', secondary_image='assets/images/products/sneakers-2.jpg' WHERE name='Minimal Leather Sneakers';
UPDATE products SET main_image='assets/images/products/mini-bag.jpg', secondary_image='assets/images/products/mini-bag-2.jpg' WHERE name='Structured Mini Bag';
UPDATE products SET main_image='assets/images/products/skin-set.jpg', secondary_image='assets/images/products/skin-set-2.jpg' WHERE name='Signature Skin Set';
UPDATE products SET main_image='assets/images/products/table-lamp.jpg', secondary_image='assets/images/products/table-lamp-2.jpg' WHERE name='Ceramic Table Lamp';
UPDATE products SET main_image='assets/images/products/premium-oversized-t-shirt.jpg', secondary_image='assets/images/products/premium-oversized-t-shirt-2.jpg' WHERE name='Premium Oversized T-Shirt';
UPDATE products SET main_image='assets/images/products/classic-cotton-shirt.jpg', secondary_image='assets/images/products/classic-cotton-shirt-2.jpg' WHERE name='Classic Cotton Shirt';
UPDATE products SET main_image='assets/images/products/casual-hoodie.jpg', secondary_image='assets/images/products/casual-hoodie-2.jpg' WHERE name='Casual Hoodie';
UPDATE products SET main_image='assets/images/products/premium-polo-shirt.jpg', secondary_image='assets/images/products/premium-polo-shirt-2.jpg' WHERE name='Premium Polo Shirt';
UPDATE products SET main_image='assets/images/products/relaxed-fit-jeans.jpg', secondary_image='assets/images/products/relaxed-fit-jeans-2.jpg' WHERE name='Relaxed Fit Jeans';
UPDATE products SET main_image='assets/images/products/cargo-pants.jpg', secondary_image='assets/images/products/cargo-pants-2.jpg' WHERE name='Cargo Pants';
UPDATE products SET main_image='assets/images/products/denim-jacket.jpg', secondary_image='assets/images/products/denim-jacket-2.jpg' WHERE name='Denim Jacket';
UPDATE products SET main_image='assets/images/products/sports-tracksuit.jpg', secondary_image='assets/images/products/sports-tracksuit-2.jpg' WHERE name='Sports Tracksuit';
UPDATE products SET main_image='assets/images/products/casual-shorts.jpg', secondary_image='assets/images/products/casual-shorts-2.jpg' WHERE name='Casual Shorts';
UPDATE products SET main_image='assets/images/products/classic-leather-watch.jpg', secondary_image='assets/images/products/classic-leather-watch-2.jpg' WHERE name='Classic Leather Watch';
UPDATE products SET main_image='assets/images/products/premium-steel-watch.jpg', secondary_image='assets/images/products/premium-steel-watch-2.jpg' WHERE name='Premium Steel Watch';
UPDATE products SET main_image='assets/images/products/minimal-black-watch.jpg', secondary_image='assets/images/products/minimal-black-watch-2.jpg' WHERE name='Minimal Black Watch';
UPDATE products SET main_image='assets/images/products/chronograph-watch.jpg', secondary_image='assets/images/products/chronograph-watch-2.jpg' WHERE name='Chronograph Watch';
UPDATE products SET main_image='assets/images/products/sport-digital-watch.jpg', secondary_image='assets/images/products/sport-digital-watch-2.jpg' WHERE name='Sport Digital Watch';
UPDATE products SET main_image='assets/images/products/luxury-style-watch.jpg', secondary_image='assets/images/products/luxury-style-watch-2.jpg' WHERE name='Luxury Style Watch';
UPDATE products SET main_image='assets/images/products/classic-black-cap.jpg', secondary_image='assets/images/products/classic-black-cap-2.jpg' WHERE name='Classic Black Cap';
UPDATE products SET main_image='assets/images/products/premium-baseball-cap.jpg', secondary_image='assets/images/products/premium-baseball-cap-2.jpg' WHERE name='Premium Baseball Cap';
UPDATE products SET main_image='assets/images/products/minimal-logo-cap.jpg', secondary_image='assets/images/products/minimal-logo-cap-2.jpg' WHERE name='Minimal Logo Cap';
UPDATE products SET main_image='assets/images/products/vintage-sports-cap.jpg', secondary_image='assets/images/products/vintage-sports-cap-2.jpg' WHERE name='Vintage Sports Cap';
UPDATE products SET main_image='assets/images/products/cotton-snapback.jpg', secondary_image='assets/images/products/cotton-snapback-2.jpg' WHERE name='Cotton Snapback';
UPDATE products SET main_image='assets/images/products/premium-sunglasses.jpg', secondary_image='assets/images/products/premium-sunglasses-2.jpg' WHERE name='Premium Sunglasses';
UPDATE products SET main_image='assets/images/products/leather-wallet.jpg', secondary_image='assets/images/products/leather-wallet-2.jpg' WHERE name='Leather Wallet';
UPDATE products SET main_image='assets/images/products/minimal-belt.jpg', secondary_image='assets/images/products/minimal-belt-2.jpg' WHERE name='Minimal Belt';
UPDATE products SET main_image='assets/images/products/professional-cricket-bat.jpg', secondary_image='assets/images/products/professional-cricket-bat-2.jpg' WHERE name='Professional Cricket Bat';
UPDATE products SET main_image='assets/images/products/tennis-ball-set.jpg', secondary_image='assets/images/products/tennis-ball-set-2.jpg' WHERE name='Tennis Ball Set';
UPDATE products SET main_image='assets/images/products/premium-cricket-ball.jpg', secondary_image='assets/images/products/premium-cricket-ball-2.jpg' WHERE name='Premium Cricket Ball';
UPDATE products SET main_image='assets/images/products/match-football.jpg', secondary_image='assets/images/products/match-football-2.jpg' WHERE name='Match Football';
UPDATE products SET main_image='assets/images/products/pro-basketball.jpg', secondary_image='assets/images/products/pro-basketball-2.jpg' WHERE name='Pro Basketball';
UPDATE products SET main_image='assets/images/products/training-football.jpg', secondary_image='assets/images/products/training-football-2.jpg' WHERE name='Training Football';
UPDATE products SET main_image='assets/images/products/sports-water-bottle.jpg', secondary_image='assets/images/products/sports-water-bottle-2.jpg' WHERE name='Sports Water Bottle';
UPDATE products SET main_image='assets/images/products/gym-gloves.jpg', secondary_image='assets/images/products/gym-gloves-2.jpg' WHERE name='Gym Gloves';
UPDATE products SET main_image='assets/images/products/running-shoes.jpg', secondary_image='assets/images/products/running-shoes-2.jpg' WHERE name='Running Shoes';
UPDATE products SET main_image='assets/images/products/casual-sneakers.jpg', secondary_image='assets/images/products/casual-sneakers-2.jpg' WHERE name='Casual Sneakers';
UPDATE products SET main_image='assets/images/products/sports-trainers.jpg', secondary_image='assets/images/products/sports-trainers-2.jpg' WHERE name='Sports Trainers';
UPDATE products SET main_image='assets/images/products/classic-white-sneakers.jpg', secondary_image='assets/images/products/classic-white-sneakers-2.jpg' WHERE name='Classic White Sneakers';
UPDATE products SET main_image='assets/images/products/bluetooth-earbuds.jpg', secondary_image='assets/images/products/bluetooth-earbuds-2.jpg' WHERE name='Bluetooth Earbuds';
UPDATE products SET main_image='assets/images/products/portable-speaker.jpg', secondary_image='assets/images/products/portable-speaker-2.jpg' WHERE name='Portable Speaker';
UPDATE products SET main_image='assets/images/products/wireless-charger.jpg', secondary_image='assets/images/products/wireless-charger-2.jpg' WHERE name='Wireless Charger';
UPDATE products SET main_image='assets/images/products/premium-body-care-set.jpg', secondary_image='assets/images/products/premium-body-care-set-2.jpg' WHERE name='Premium Body Care Set';
UPDATE products SET main_image='assets/images/products/fragrance-gift-set.jpg', secondary_image='assets/images/products/fragrance-gift-set-2.jpg' WHERE name='Fragrance Gift Set';
UPDATE products SET main_image='assets/images/products/premium-coffee-mug.jpg', secondary_image='assets/images/products/premium-coffee-mug-2.jpg' WHERE name='Premium Coffee Mug';
UPDATE products SET main_image='assets/images/products/scented-candle.jpg', secondary_image='assets/images/products/scented-candle-2.jpg' WHERE name='Scented Candle';
UPDATE products SET main_image='assets/images/products/desk-organizer.jpg', secondary_image='assets/images/products/desk-organizer-2.jpg' WHERE name='Desk Organizer';
COMMIT;

-- Homepage category photography is code-based (not stored in the database).
-- Local fallback files are included under assets/images/categories/.
