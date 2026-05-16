-- =========================================================
-- 1. CREATE TABLE
-- =========================================================

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    order_date DATE,
    order_timestamp TIMESTAMP,
    delivery_date DATE,
    order_amount DECIMAL(10,2)
);

-- =========================================================
-- 2. INSERT SAMPLE DATA
-- =========================================================

INSERT INTO orders VALUES
(1, 'Karthik', '2024-01-15', '2024-01-15 10:30:45', '2024-01-20', 2500.00),
(2, 'Veena', '2024-02-18', '2024-02-18 18:45:20', '2024-02-22', 3200.50),
(3, 'Ravi', '2024-03-02', '2024-03-02 09:15:10', '2024-03-08', 4100.75),
(4, 'Anil', '2024-03-09', '2024-03-09 14:05:55', '2024-03-15', 1800.00),
(5, 'Suresh', '2024-01-07', '2024-01-07 23:55:00', '2024-01-12', 2900.00);

-- =========================================================
-- 3. QUESTION:
-- Display current date
-- =========================================================

SELECT CURDATE();

-- =========================================================
-- 4. QUESTION:
-- Display current time
-- =========================================================

SELECT CURTIME();

-- =========================================================
-- 5. QUESTION:
-- Display current date and time
-- =========================================================

SELECT NOW();

-- =========================================================
-- 6. QUESTION:
-- Extract year from order_date
-- =========================================================

SELECT
    order_id,
    order_date,
    YEAR(order_date) AS year
FROM orders;

-- =========================================================
-- 7. QUESTION:
-- Extract month from order_date
-- =========================================================

SELECT
    order_id,
    MONTH(order_date) AS month
FROM orders;

-- =========================================================
-- 8. QUESTION:
-- Extract day from order_date
-- =========================================================

SELECT
    order_id,
    DAY(order_date) AS day
FROM orders;

-- =========================================================
-- 9. QUESTION:
-- Extract year, month and day using EXTRACT()
-- =========================================================

SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    EXTRACT(DAY FROM order_date) AS day
FROM orders;

-- =========================================================
-- 10. QUESTION:
-- Display month name and day name
-- =========================================================

SELECT
    order_id,
    MONTHNAME(order_date) AS month_name,
    DAYNAME(order_date) AS day_name
FROM orders;

-- =========================================================
-- 11. QUESTION:
-- Find weekday number using WEEKDAY()
-- Monday = 0
-- =========================================================

SELECT
    order_id,
    WEEKDAY(order_date) AS weekday_number
FROM orders;

-- =========================================================
-- 12. QUESTION:
-- Find day of week using DAYOFWEEK()
-- Sunday = 1
-- =========================================================

SELECT
    order_id,
    DAYOFWEEK(order_date) AS day_number
FROM orders;

-- =========================================================
-- 13. QUESTION:
-- Find all weekend orders
-- =========================================================

SELECT
    order_id,
    order_date
FROM orders
WHERE DAYNAME(order_date) IN ('Saturday', 'Sunday');

-- =========================================================
-- 14. QUESTION:
-- Find all weekday orders
-- =========================================================

SELECT
    order_id,
    order_date
FROM orders
WHERE DAYOFWEEK(order_date) BETWEEN 2 AND 6;

-- =========================================================
-- 15. QUESTION:
-- Add 5 days to order_date
-- =========================================================

SELECT
    order_id,
    order_date,
    DATE_ADD(order_date, INTERVAL 5 DAY) AS new_date
FROM orders;

-- =========================================================
-- 16. QUESTION:
-- Subtract 3 days from order_date
-- =========================================================

SELECT
    order_id,
    order_date,
    DATE_SUB(order_date, INTERVAL 3 DAY) AS previous_date
FROM orders;

-- =========================================================
-- 17. QUESTION:
-- Add 1 month to order_date
-- =========================================================

SELECT
    order_id,
    DATE_ADD(order_date, INTERVAL 1 MONTH) AS next_month
FROM orders;

-- =========================================================
-- 18. QUESTION:
-- Add 1 year to order_date
-- =========================================================

SELECT
    order_id,
    DATE_ADD(order_date, INTERVAL 1 YEAR) AS next_year
FROM orders;

-- =========================================================
-- 19. QUESTION:
-- Find delivery days using DATEDIFF()
-- =========================================================

SELECT
    order_id,
    DATEDIFF(delivery_date, order_date) AS delivery_days
FROM orders;

-- =========================================================
-- 20. QUESTION:
-- Find difference using TIMESTAMPDIFF()
-- =========================================================

SELECT
    order_id,
    TIMESTAMPDIFF(DAY, order_date, delivery_date) AS days_diff,
    TIMESTAMPDIFF(MONTH, order_date, delivery_date) AS months_diff
FROM orders;

-- =========================================================
-- 21. QUESTION:
-- Find last day of month
-- =========================================================

SELECT
    order_id,
    LAST_DAY(order_date) AS last_day
FROM orders;

-- =========================================================
-- 22. QUESTION:
-- Find first day of month
-- =========================================================

SELECT
    order_id,
    DATE_SUB(order_date, INTERVAL DAY(order_date)-1 DAY) AS first_day
FROM orders;

-- =========================================================
-- 23. QUESTION:
-- Format date as DD-MM-YYYY
-- =========================================================

SELECT
    order_id,
    DATE_FORMAT(order_date, '%d-%m-%Y') AS formatted_date
FROM orders;

-- =========================================================
-- 24. QUESTION:
-- Format date with month name
-- =========================================================

SELECT
    order_id,
    DATE_FORMAT(order_date, '%M %d, %Y') AS formatted_date
FROM orders;

-- =========================================================
-- 25. QUESTION:
-- Convert string to date
-- =========================================================

SELECT STR_TO_DATE('15-01-2024', '%d-%m-%Y');

-- =========================================================
-- 26. QUESTION:
-- Format timestamp
-- =========================================================

SELECT
    order_id,
    DATE_FORMAT(order_timestamp, '%d-%m-%Y %H:%i:%s') AS formatted_timestamp
FROM orders;

-- =========================================================
-- 27. QUESTION:
-- Find January orders
-- =========================================================

SELECT *
FROM orders
WHERE MONTH(order_date) = 1;

-- =========================================================
-- 28. QUESTION:
-- Find February orders
-- =========================================================

SELECT *
FROM orders
WHERE MONTHNAME(order_date) = 'February';

-- =========================================================
-- 29. QUESTION:
-- Find financial year using CASE
-- =========================================================

SELECT
    order_id,
    order_date,
    CASE
        WHEN MONTH(order_date) >= 4
        THEN CONCAT(YEAR(order_date), '-', YEAR(order_date)+1)

        ELSE CONCAT(YEAR(order_date)-1, '-', YEAR(order_date))
    END AS financial_year
FROM orders;

-- =========================================================
-- 30. QUESTION:
-- Find orders placed in last 7 days
-- =========================================================

SELECT *
FROM orders
WHERE order_date >= CURDATE() - INTERVAL 7 DAY;

-- =========================================================
-- 31. QUESTION:
-- Find orders placed today
-- =========================================================

SELECT *
FROM orders
WHERE order_date = CURDATE();
