<?php
require_once __DIR__.'/includes/auth.php';
header('Content-Type: text/plain; charset=utf-8');
echo "LUXORA database connection: OK\n";
echo "PHP version: ".PHP_VERSION."\n";
echo "Products: ".$pdo->query("SELECT COUNT(*) FROM products")->fetchColumn()."\n";
echo "Categories: ".$pdo->query("SELECT COUNT(*) FROM categories")->fetchColumn()."\n";
echo "Admin users: ".$pdo->query("SELECT COUNT(*) FROM users WHERE role='admin'")->fetchColumn()."\n";
