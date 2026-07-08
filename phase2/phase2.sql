-- ==========================================
-- Phase 2 - SQL Queries
-- ==========================================

-- 1. Total order amount for each customer

SELECT
    customer_id,
    SUM(total_amount) AS total_order_amount
FROM sales
GROUP BY customer_id;

--------------------------------------------------

-- 2. Top 3 customers by total spend

SELECT
    customer_id,
    SUM(total_amount) AS total_spend
FROM sales
GROUP BY customer_id
ORDER BY total_spend DESC
LIMIT 3;

--------------------------------------------------

-- 3. Customers with no orders

SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM customers c
LEFT JOIN sales s
ON c.customer_id = s.customer_id
WHERE s.customer_id IS NULL;

--------------------------------------------------

-- 4. City-wise total revenue

SELECT
    c.city,
    SUM(s.total_amount) AS revenue
FROM customers c
JOIN sales s
ON c.customer_id = s.customer_id
GROUP BY c.city
ORDER BY revenue DESC;

--------------------------------------------------

-- 5. Average order amount per customer

SELECT
    customer_id,
    AVG(total_amount) AS average_order_amount
FROM sales
GROUP BY customer_id;

--------------------------------------------------

-- 6. Customers with more than one order

SELECT
    customer_id,
    COUNT(sale_id) AS total_orders
FROM sales
GROUP BY customer_id
HAVING COUNT(sale_id) > 1;

--------------------------------------------------

-- 7. Sort customers by total spend descending

SELECT
    customer_id,
    SUM(total_amount) AS total_spend
FROM sales
GROUP BY customer_id
ORDER BY total_spend DESC;
