# Superstore SQL Data Analysis

A MySQL project using a relational database to analyze Superstore customers, products, orders, sales, discounts, and profitability.

## Project objective
Design a relational database for a Superstore and answer business questions using SQL. The original project report covers customer activity, category performance, top-selling products, discount patterns, loss-making transactions, and shipping modes.

## Dataset
The analysis is designed for the Sample Superstore dataset (commonly 9,994 rows and 21 columns). **The dataset file is not currently present in this repository**, so obtain the source CSV separately before following the import steps. The flat data includes order, customer, product, geography, sales, quantity, discount, and profit.

## Database design
Database: superstore_db

The flat source data is separated into four tables:
- customers: customer details and geography
- products: product category, sub-category, and name
- orders: order date, ship date, ship mode, and customer
- order_details: product-level sales, quantity, discount, and profit

## Tools
- MySQL / MySQL Workbench
- CSV Import Wizard
- Microsoft Excel for data review and cleaning

## How to run
1. Open MySQL Workbench.
2. Run `Superstore_Analysis.sql` (currently stored in the repository root) to create the four tables.
3. Import the CSV data into the corresponding tables using the Table Data Import Wizard. Map columns carefully: the CSV is a flat file, while the SQL schema is split into four tables.
4. Execute the analysis queries in the SQL script.

## Analysis questions
1. List customers from Kentucky.
2. Find the 10 highest-sales line items.
3. Display unique product names.
4. Count order records.
5. Filter orders shipped by Second Class.
6. Calculate sales and profit by category.
7. Count orders per customer.
8. Calculate average discount by sub-category.
9. Find customers whose total purchases exceed 10,000.
10. List loss-making order line items.
11. Find the five most profitable products.
12. Identify the category with the highest sales.
13. List customers and their cities.
14. Count records in each table.
15. List Furniture products.

## Key observations in the original report
- The category summary shows Technology with the highest sales among the three categories.
- The report highlights negative-profit transactions as a reason to review discounting and pricing.
- Customer purchase and order-frequency analysis can help identify high-value customers.
- Shipping-mode analysis is discussed as an area for understanding order handling and profitability.

## Repository structure
- `Superstore_Analysis.sql` — SQL script in repository root.
- `README.md` — project guide.

Dataset and report files referenced in earlier documentation are not currently verified as present.

## Note
The SQL script contains the analysis questions and corrected examples. The dataset and report should be added to the repository to make the project reproducible and fully reviewable.
