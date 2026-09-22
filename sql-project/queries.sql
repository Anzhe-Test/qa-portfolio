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


  SELECT
    customer_id,
    COUNT (order_id) AS total_orders
  FROM orders
  GROUP by customer_id
  HAVING COUNT (order_id)>1;


  SELECT
    c.first_name,
    c.last_name,
    o.order_id,
    o.order_date,
    o.status
  FROM customers c    
  INNER JOIN orders o ON c.customer_id=o.customer_id
  WHERE o.status= 'completed';


  SELECT
    c.customer_id,
    c.first_name,
    c.last_name
  FROM customers c  
  LEFT JOIN orders o ON c.customer_id=o.customer_id
  WHERE o.order_id IS NULL;


  SELECT
    category,
    COUNT (product_id) as total_products,
    ROUND (AVG(price), 2) as avg_price,
    SUM (stock_quantity) as total_stock
  FROM products
  GROUP BY category;  


 SELECT 
    o.order_id,
    o.order_date,
    p.product_id,
    p.name AS product_name,
    p.stock_quantity,
    p.is_available
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE p.stock_quantity = 0 OR p.is_available = 0;


-- 7. QA-проверка 2: Поиск расхождений в итоговой сумме заказа
SELECT 
    o.order_id,
    o.total_amount,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS calculated_total,
    ROUND(o.total_amount - SUM(oi.quantity * oi.unit_price), 2) AS difference
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, o.total_amount
HAVING o.total_amount != calculated_total;
