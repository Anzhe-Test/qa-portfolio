-- SQL QA Project: E-commerce database validation
-- SQLite
-- The dataset intentionally includes edge cases and anomalies.

-- 1. Data-quality audit: active customers with missing contact details.
-- Treat these as potential issues only if the business rules require contact details.
SELECT
    customer_id,
    first_name,
    last_name,
    email,
    phone,
    status
FROM customers
WHERE status = 'active'
  AND (email IS NULL OR phone IS NULL);


-- 2. Informational analysis: customers with more than one order.
-- Multiple orders are not a defect by themselves.
SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1;


-- 3. Integrity check: completed orders that have no order items.
-- A completed order should contain at least one line item.
SELECT
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status
FROM orders AS o
LEFT JOIN order_items AS oi ON o.order_id = oi.order_id
WHERE o.status = 'completed'
  AND oi.item_id IS NULL;


-- 4. Informational audit: customers who have never placed an order.
-- This is not automatically a defect; it may be normal customer behavior.
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM customers AS c
LEFT JOIN orders AS o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- 5. Informational report: product counts, average prices, and stock by category.
SELECT
    category,
    COUNT(product_id) AS total_products,
    ROUND(AVG(price), 2) AS avg_price,
    SUM(stock_quantity) AS total_stock
FROM products
GROUP BY category;


-- 6. Business-rule audit: completed orders reference products currently out of stock
-- or marked unavailable. The dataset does not store inventory history, so this
-- checks current product state, not stock state at the time of purchase.
SELECT DISTINCT
    o.order_id,
    o.status,
    p.product_id,
    p.name AS product_name,
    p.stock_quantity,
    p.is_available
FROM orders AS o
JOIN order_items AS oi ON o.order_id = oi.order_id
JOIN products AS p ON oi.product_id = p.product_id
WHERE o.status = 'completed'
  AND (p.stock_quantity = 0 OR p.is_available = 0);


-- 7. Business-rule audit: order totals do not match the sum of their line items.
-- Compare rounded monetary values to cents to avoid direct floating-point comparison.
SELECT
    o.order_id,
    o.total_amount,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS calculated_total,
    ROUND(o.total_amount - SUM(oi.quantity * oi.unit_price), 2) AS difference
FROM orders AS o
JOIN order_items AS oi ON o.order_id = oi.order_id
GROUP BY o.order_id, o.total_amount
HAVING ROUND(o.total_amount, 2) <> ROUND(SUM(oi.quantity * oi.unit_price), 2);
