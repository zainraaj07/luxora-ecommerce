# LUXORA — Complete PHP/MySQL E-commerce

Premium commercial-style e-commerce website + full-access Admin Panel for **Zain**.

## Stack
- HTML5 / CSS3
- Vanilla JavaScript
- PHP 8+
- MySQL / PDO
- PHP Sessions

## Included
- Customer storefront: Home, Shop, Product Details, Categories, About, Contact, Login, Signup, Cart, Checkout, Order Confirmation, Account, Order History, Wishlist
- Admin `/admin/`: dashboard, orders, order details/status control, products CRUD, categories, customers, inventory, analytics, wishlist, messages, newsletter, promotions, website content, admins, settings
- Local bundled product artwork under `assets/images/products/` so products render without external image hosting
- `database.sql` for a fresh installation
- `admin_upgrade.sql` to add/update the bundled product images on an existing database
- Responsive premium UI/UX for desktop, tablet and mobile

## Fresh XAMPP/WAMP Setup
1. Copy the `luxora_ecommerce` folder into `htdocs` (XAMPP) or the equivalent web root.
2. Start Apache and MySQL.
3. Open phpMyAdmin and import `database.sql`.
4. Check `config/database.php` and set the MySQL username/password if your local setup differs.
5. Open `http://localhost/luxora_ecommerce/`.
6. Admin: `http://localhost/luxora_ecommerce/admin/`

### Admin login
- Email: `admin@luxora.test`
- Password: `Admin@123`

## Existing database
If you already installed an earlier LUXORA version, import `admin_upgrade.sql` after the main database setup. It updates the six seeded products to use the bundled local artwork.

## Important
For production, change the seeded admin password, configure HTTPS, set secure cookie/session options, and use a real payment gateway rather than demo payment UI.


## Expanded catalog
This version includes a larger seeded catalog with bundled local SVG product artwork under `assets/images/products/`. Import `database.sql` for a fresh install or `admin_upgrade.sql` for an existing database.

## Existing Database Image Migration

If you already have an existing LUXORA database, do **not** import `database.sql` because it is intended for a fresh installation.

1. Copy the included `assets/images/products/*.jpg` files into your existing project.
2. Import `realistic_images_update.sql` into the existing LUXORA database.
3. The migration only updates product image paths; it does not drop tables, delete products, or remove customers, orders, wishlist records, or admin records.

For a fresh installation, import `database.sql` as usual.

## ZAIN STORE image and branding update

- Visible store branding is now **ZAIN STORE**.
- Homepage Explore Categories now uses dedicated category photography with local fallback files under `assets/images/categories/`.
- Product image paths remain under `assets/images/products/`.
- For a fresh database import `database.sql`.
- For an existing database import `realistic_images_update.sql`; do not import `database.sql` into an existing production database.
