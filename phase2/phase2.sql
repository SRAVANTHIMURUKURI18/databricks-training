-- 1. Total order amount for each customer
SELECT
    customer_id,
    SUM(amount) AS total_amount
FROM orders
GROUP BY customer_id;

----------------------------------------------------

-- 2. Top 3 customers by total spend
SELECT
    customer_id,
    SUM(amount) AS total_spend
FROM orders
GROUP BY customer_id
ORDER BY total_spend DESC
LIMIT 3;

----------------------------------------------------

-- 3. Customers with no orders
SELECT
    c.customer_id,
    c.customer_name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

----------------------------------------------------

-- 4. City-wise total revenue
SELECT
    c.city,
    SUM(o.amount) AS revenue
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.city;

----------------------------------------------------

-- 5. Average order amount per customer
SELECT
    customer_id,
    AVG(amount) AS average_amount
FROM orders
GROUP BY customer_id;

----------------------------------------------------

-- 6. Customers with more than one order
SELECT
    customer_id,
    COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1;

----------------------------------------------------

-- 7. Sort customers by total spend descending
SELECT
    customer_id,
    SUM(amount) AS total_spend
FROM orders
GROUP BY customer_id
ORDER BY total_spend DESC;
