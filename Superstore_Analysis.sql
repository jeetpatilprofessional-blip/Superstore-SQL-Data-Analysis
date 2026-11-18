CREATE DATABASE IF NOT EXISTS superstore_db;
USE superstore_db;

CREATE TABLE IF NOT EXISTS customers (
 id INT AUTO_INCREMENT PRIMARY KEY,
 customer_id VARCHAR(50) NOT NULL UNIQUE,
 customer_name VARCHAR(100), segment VARCHAR(50), country VARCHAR(50),
 city VARCHAR(100), state VARCHAR(100), postal_code VARCHAR(20), region VARCHAR(50)
);
CREATE TABLE IF NOT EXISTS products (
 id INT AUTO_INCREMENT PRIMARY KEY,
 product_id VARCHAR(50) NOT NULL UNIQUE,
 category VARCHAR(50), sub_category VARCHAR(100), product_name VARCHAR(300)
);
CREATE TABLE IF NOT EXISTS orders (
 id INT AUTO_INCREMENT PRIMARY KEY,
 order_id VARCHAR(50) NOT NULL UNIQUE,
 order_date DATE, ship_date DATE, ship_mode VARCHAR(50),
 customer_id VARCHAR(50) NOT NULL,
 FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
CREATE TABLE IF NOT EXISTS order_details (
 id INT AUTO_INCREMENT PRIMARY KEY,
 row_id INT NOT NULL UNIQUE, order_id VARCHAR(50) NOT NULL,
 product_id VARCHAR(50) NOT NULL, sales DECIMAL(12,2),
 quantity INT, discount DECIMAL(5,4), profit DECIMAL(12,2),
 FOREIGN KEY (order_id) REFERENCES orders(order_id),
 FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Import CSV data using MySQL Workbench's Table Data Import Wizard.
-- Import customers and products first, then orders, then order_details.
-- Parse Order Date and Ship Date as DATE values (source format MM-DD-YYYY).

-- 1. Customers from Kentucky
SELECT customer_name, city FROM customers WHERE state = 'Kentucky';

-- 2. Top 10 highest-sales order lines
SELECT order_id, sales, profit FROM order_details ORDER BY sales DESC LIMIT 10;

-- 3. Unique products
SELECT DISTINCT product_name FROM products;

-- 4. Total orders
SELECT COUNT(*) AS total_orders FROM orders;

-- 5. Second Class shipments
SELECT * FROM orders WHERE ship_mode = 'Second Class';

-- 6. Sales and profit by category
SELECT p.category, SUM(od.sales) AS total_sales, SUM(od.profit) AS total_profit
FROM products p JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.category;

-- 7. Number of orders per customer
SELECT c.customer_id, c.customer_name, COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name ORDER BY total_orders DESC;

-- 8. Average discount by sub-category
SELECT p.sub_category, AVG(od.discount) AS average_discount
FROM products p JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.sub_category ORDER BY average_discount ASC;

-- 9. Customers with purchases above 10,000 (corrected customer_id join)
SELECT c.customer_id, c.customer_name, SUM(od.sales) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(od.sales) > 10000 ORDER BY total_spent DESC;

-- 10. Negative-profit order lines
SELECT o.order_id, od.product_id, od.sales, od.profit
FROM orders o JOIN order_details od ON o.order_id = od.order_id
WHERE od.profit < 0 ORDER BY od.profit ASC;

-- 11. Top 5 most profitable products
SELECT p.product_id, p.product_name, SUM(od.profit) AS total_profit
FROM products p JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name ORDER BY total_profit DESC LIMIT 5;

-- 12. Category with highest sales
SELECT p.category, SUM(od.sales) AS total_sales
FROM products p JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.category ORDER BY total_sales DESC LIMIT 1;

-- 13. Customers and cities
SELECT customer_name, city FROM customers;

-- 14. Record counts by table
SELECT (SELECT COUNT(*) FROM customers) AS total_customers,
       (SELECT COUNT(*) FROM orders) AS total_orders,
       (SELECT COUNT(*) FROM products) AS total_products,
       (SELECT COUNT(*) FROM order_details) AS total_order_details;

-- 15. Furniture products
SELECT product_name FROM products WHERE category = 'Furniture';

-- Additional corrected examples from the original SQL:
-- Use WHERE rather than HAVING for row-level filtering.
SELECT * FROM orders WHERE id = 1;

-- Extract year from a DATE column.
SELECT YEAR(order_date) AS order_year FROM orders;

-- Row-level sales filter; MAX() cannot be used directly in WHERE.
SELECT * FROM order_details WHERE sales > 5000;

-- Aggregate filter belongs in HAVING.
SELECT p.category, MAX(od.sales) AS max_line_sale
FROM products p JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.category HAVING MAX(od.sales) > 5000;
