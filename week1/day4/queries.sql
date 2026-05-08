--------------------------------------------------
-- Q1: Use ROW_NUMBER() to assign a row number
-- to employees ordered by salary descending
--------------------------------------------------

SELECT *,
       ROW_NUMBER() OVER (
           ORDER BY salary DESC
       ) AS row_num
FROM employees;

--------------------------------------------------
-- Q2: Use RANK() to rank employees by salary
--------------------------------------------------

SELECT *,
       RANK() OVER (
           ORDER BY salary DESC
       ) AS salary_rank
FROM employees;

--------------------------------------------------
-- Q3: Use DENSE_RANK() to rank employees by salary
--------------------------------------------------

SELECT *,
       DENSE_RANK() OVER (
           ORDER BY salary DESC
       ) AS dense_salary_rank
FROM employees;

--------------------------------------------------
-- Q4: Find the top 3 highest-paid employees
-- using a window function
--------------------------------------------------

SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               ORDER BY salary DESC
           ) AS row_num
    FROM employees
) ranked_employees
WHERE row_num <= 3;

--------------------------------------------------
-- Q5: Rank employees within each department
-- using PARTITION BY
--------------------------------------------------

SELECT *,
       RANK() OVER (
           PARTITION BY department
           ORDER BY salary DESC
       ) AS dept_rank
FROM employees;

--------------------------------------------------
-- Q6: Display the highest salary in each department
-- using a window function
--------------------------------------------------

SELECT *,
       MAX(salary) OVER (
           PARTITION BY department
       ) AS highest_department_salary
FROM employees;

--------------------------------------------------
-- Q7: Calculate the running total of order amounts
-- ordered by order_date
--------------------------------------------------

SELECT *,
       SUM(total_amount) OVER (
           ORDER BY order_date
       ) AS running_total
FROM orders;

--------------------------------------------------
-- Q8: Calculate the cumulative sales amount
-- for each employee
--------------------------------------------------

SELECT *,
       SUM(total_amount) OVER (
           PARTITION BY employee_id
           ORDER BY order_date
       ) AS cumulative_sales
FROM orders;

--------------------------------------------------
-- Q9: Use LAG() to show the previous order amount
-- for each customer
--------------------------------------------------

SELECT *,
       LAG(total_amount) OVER (
           PARTITION BY customer_id
           ORDER BY order_date
       ) AS previous_order_amount
FROM orders;

--------------------------------------------------
-- Q10: Use LEAD() to show the next order amount
-- for each customer
--------------------------------------------------

SELECT *,
       LEAD(total_amount) OVER (
           PARTITION BY customer_id
           ORDER BY order_date
       ) AS next_order_amount
FROM orders;

--------------------------------------------------
-- Q11: Find the difference between current order amount
-- and previous order amount
--------------------------------------------------

SELECT *,
       total_amount -
       LAG(total_amount) OVER (
           PARTITION BY customer_id
           ORDER BY order_date
       ) AS amount_difference
FROM orders;

--------------------------------------------------
-- Q12: Calculate a moving average of the last 3 orders
--------------------------------------------------

SELECT *,
       AVG(total_amount) OVER (
           ORDER BY order_date
           ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ) AS moving_average
FROM orders;

--------------------------------------------------
-- Q13: Use NTILE(4) to divide employees
-- into salary quartiles
--------------------------------------------------

SELECT *,
       NTILE(4) OVER (
           ORDER BY salary DESC
       ) AS salary_quartile
FROM employees;

--------------------------------------------------
-- Q14: Find the first order placed by each customer
-- using ROW_NUMBER()
--------------------------------------------------

SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id
               ORDER BY order_date
           ) AS row_num
    FROM orders
) first_orders
WHERE row_num = 1;

--------------------------------------------------
-- Q15: Find the latest order placed by each customer
--------------------------------------------------

SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id
               ORDER BY order_date DESC
           ) AS row_num
    FROM orders
) latest_orders
WHERE row_num = 1;
