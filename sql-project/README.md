Note: The SQLite schema and synthetic test data (including intentional edge cases and bugs) were generated with AI assistance to simulate real-world e-commerce data corruption.

🎯 Overview
A practical QA project focused on **relational database testing, data integrity verification, and business logic validation** using SQLite.

🧰 Key QA Skills
SQL Proficiency:** `INNER JOIN`, `LEFT JOIN`, `GROUP BY`, `HAVING`, aggregations (`SUM`, `COUNT`, `AVG`), and `NULL` handling.
Data Integrity Auditing:** Writing validation scripts to catch backend calculation errors and rule violations.
Edge Case Testing:** Uncovering unlinked records, missing attributes, and inventory anomalies.

🐞 Tested Bugs & Anomalies
The 4-table database (`customers`, `products`, `orders`, `order_items`) contains 4 simulated defects:
1. **Incomplete Profiles:** Active users missing `email` or `phone` (`NULL` check).
2. **Non-Purchasing Users:** Registered accounts with zero orders (`LEFT JOIN` audit).
3. **Inventory Logic Violation:** Orders completed with out-of-stock (`stock_quantity = 0`) or disabled items.
4. **Price Mismatch Bug:** Discrepancies between `orders.total_amount` and the calculated sum of items in `order_items`.

📄 Repository Files
schema.sql — Table definitions and mock dataset with embedded defects.
queries.sql — 7 production-like SQL queries verifying the data and detecting the bugs above.
