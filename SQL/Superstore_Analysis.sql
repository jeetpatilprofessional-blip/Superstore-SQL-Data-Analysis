CREATE DATABASE IF NOT EXISTS superstore_db;
USE superstore_db;

-- Table 1: Customer information
CREATE TABLE IF NOT EXISTS customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(50),
    region VARCHAR(50)
);

-- Table 2: Product information
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(300)
);

-- Table 3: Order header information
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(50),
    order_date VARCHAR(50),
    ship_date VARCHAR(50),
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50)
);

-- Table 4: Product-level order details
CREATE TABLE IF NOT EXISTS order_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    row_id INT,
    order_id VARCHAR(50),
    product_id VARCHAR(50),
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(4,2),
    profit DECIMAL(10,2)
);

-- 1. List all customers from Kentucky
SELECT customer_name, city
FROM customers
WHERE state = 'Kentucky';

-- 2. Find the 10 highest-sales transactions / line items
SELECT order_id, sales, profit
FROM order_details
ORDER BY sales DESC
LIMIT 10;

-- 3. Display all unique products
SELECT DISTINCT product_name
FROM products;

-- 4. Count order records
SELECT COUNT(order_id) AS total_count
FROM orders;

-- 5. Find all orders shipped with Second Class mode
SELECT *
FROM orders
WHERE ship_mode = 'Second Class';

-- 6. Calculate total sales and profit by category
SELECT p.category,
       SUM(od.sales) AS total_sales,
       SUM(od.profit) AS total_profit
FROM products AS p
JOIN order_details AS od
    ON p.product_id = od.product_id
GROUP BY p.category;

-- 7. Find the number of orders per customer
SELECT c.customer_name,
       COUNT(DISTINCT o.order_id) AS total_orders
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC;

-- 8. Get average discount by sub-category
SELECT p.sub_category,
       AVG(od.discount) AS average_discount
FROM products AS p
JOIN order_details AS od
    ON p.product_id = od.product_id
GROUP BY p.sub_category
ORDER BY average_discount ASC;

-- 9. List customers whose total purchases exceed 10,000
-- Correct join: customers.customer_id = orders.customer_id
SELECT c.customer_name,
       SUM(od.sales) AS total_spent
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_details AS od
    ON o.order_id = od.order_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(od.sales) > 10000
ORDER BY total_spent DESC;

-- 10. List order line items where profit is negative
SELECT o.order_id,
       od.product_id,
       od.sales,
       od.profit
FROM orders AS o
JOIN order_details AS od
    ON o.order_id = od.order_id
WHERE od.profit < 0
ORDER BY od.profit ASC;

-- 11. Find the five most profitable products
SELECT p.product_name,
       SUM(od.profit) AS total_profit
FROM products AS p
JOIN order_details AS od
    ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_profit DESC
LIMIT 5;

-- 12. Show the product category with the highest total sales
SELECT p.category,
       SUM(od.sales) AS total_sales
FROM products AS p
JOIN order_details AS od
    ON p.product_id = od.product_id
GROUP BY p.category
ORDER BY total_sales DESC
LIMIT 1;

-- 13. List all customers and their cities
SELECT customer_name, city
FROM customers;

-- 14. Find total number of records in each table
SELECT
    (SELECT COUNT(*) FROM customers) AS total_customers,
    (SELECT COUNT(*) FROM orders) AS total_orders,
    (SELECT COUNT(*) FROM products) AS total_products,
    (SELECT COUNT(*) FROM order_details) AS total_order_details;

-- 15. Find all products in the Furniture category
SELECT product_name
FROM products
WHERE category = 'Furniture';

-- Additional valid practice queries

-- Extract the year from order_date (stored as DD-MM-YYYY in the source dataset)
SELECT
    STR_TO_DATE(order_date, '%d-%m-%Y') AS parsed_order_date,
    YEAR(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_year
FROM orders;

-- Find line items with sales greater than 5,000
SELECT *
FROM order_details
WHERE sales > 5000;

-- Find orders whose total line-item sales exceed 5,000
SELECT order_id, SUM(sales) AS order_sales
FROM order_details
GROUP BY order_id
HAVING SUM(sales) > 5000;

-- Find one order record by its auto-increment primary key
SELECT *
FROM orders
WHERE id = 1;
