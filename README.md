# Superstore SQL Data Analysis

A MySQL project that analyzes Superstore customers, products, orders, sales, discounts, and profitability using a relational database.

## Project objective
Design a relational database for a Superstore and answer business questions using SQL. The analysis covers customer activity, category performance, top-selling products, discount patterns, loss-making transactions, and shipping modes.

## Dataset
This project is designed for the Sample Superstore dataset (commonly distributed with 9,994 rows and 21 columns). **The dataset is not included in this repository.** Obtain the dataset from a source whose terms permit your use, then import it before running the analysis. The source data contains order, customer, product, geography, sales, quantity, discount, and profit fields.

## Database design
Database: `superstore_db`

The flat source data is organized into four tables:
- `customers` — customer details and geography
- `products` — product category, sub-category, and name
- `orders` — order date, ship date, ship mode, and customer
- `order_details` — product-level sales, quantity, discount, and profit

## Tools
- MySQL / MySQL Workbench
- CSV Import Wizard
- Microsoft Excel for data review and cleaning

## How to run
1. Obtain the Sample Superstore CSV dataset and review its usage terms.
2. Open MySQL Workbench and create/select the `superstore_db` database.
3. Open and run [SQL/Superstore_Analysis.sql](SQL/Superstore_Analysis.sql).
4. Import the source CSV data into the corresponding tables. The source is a flat file, while the SQL schema is split into four tables; map fields carefully.
5. Execute the analysis queries in the SQL script.

## Analysis questions
The SQL script includes queries covering:
1. Customers from Kentucky.
2. Ten highest-sales line items.
3. Unique product names.
4. Order-record counts.
5. Orders shipped by Second Class.
6. Sales and profit by category.
7. Orders per customer.
8. Average discount by sub-category.
9. Customers whose total purchases exceed 10,000.
10. Loss-making order line items.
11. Five most profitable products.
12. Category with the highest sales.
13. Customers and their cities.
14. Record counts in each table.
15. Furniture products.

## Key observations
The original project report highlights Technology as the highest-sales category and identifies negative-profit transactions as an area for reviewing discounting and pricing. Re-run the queries against your imported dataset before presenting these as verified findings.

## Repository contents
- `SQL/Superstore_Analysis.sql` — database setup and analysis queries.
- `README.md` — project guide.

## Limitation
The dataset is not currently included, so the project is not immediately reproducible from a fresh clone. Add a permitted dataset copy or provide a reliable source link and import instructions to improve reproducibility.

## Author
Jeet Patil
