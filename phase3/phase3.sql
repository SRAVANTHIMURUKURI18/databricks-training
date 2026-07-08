-- ==========================================
-- Phase 3 - SQL ETL Practice
-- ==========================================

-- 1. Daily Sales

SELECT
    sale_date,
    SUM(total_amount) AS daily_sales
FROM sales
GROUP BY sale_date
ORDER BY sale_date;

--------------------------------------------------

-- 2. City-wise Revenue

SELECT
    c.city,
    SUM(s.total_amount) AS revenue
FROM customers c
JOIN sales s
ON c.customer_id = s.customer_id
GROUP BY c.city
ORDER BY revenue DESC;

--------------------------------------------------

-- 3. Repeat Customers (>2 Orders)

SELECT
    customer_id,
    COUNT(sale_id) AS order_count
FROM sales
GROUP BY customer_id
HAVING COUNT(sale_id) > 2;

--------------------------------------------------

-- 4. Highest Spending Customer in Each City

SELECT
    c.city,
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(s.total_amount) AS total_spend
FROM customers c
JOIN sales s
ON c.customer_id = s.customer_id
GROUP BY
    c.city,
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY
    c.city,
    total_spend DESC;

--------------------------------------------------

-- 5. Final Reporting Table

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    SUM(s.total_amount) AS total_spend,
    COUNT(s.sale_id) AS order_count
FROM customers c
JOIN sales s
ON c.customer_id = s.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city
ORDER BY total_spend DESC;
