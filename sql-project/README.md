# SQL Database Testing

## Project Overview
SQL testing of an e-commerce database using SQLite, focusing on data quality, data integrity, and business-rule validation.

## Database
- Customers
- Products
- Orders
- Order Items

## QA Checks
- Missing customer contact information
- Customers with multiple or no orders
- Completed orders without order items
- Inventory availability issues
- Order total discrepancies
- Product statistics by category

## Files
- `schema.sql` — database schema and sample data
- `queries.sql` — SQL queries for QA checks and data analysis

## Notes
Synthetic data was created with AI assistance. Inventory checks use current stock data and cannot verify stock availability at the time of purchase.
