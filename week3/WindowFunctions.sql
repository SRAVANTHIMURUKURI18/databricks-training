/* =========================================================
                     ROW_NUMBER() FUNCTIONS
========================================================= */

--Q1. Assign a unique row number to all employees based on salary (highest first)

SELECT 
       emp_id,
       emp_name,
       department,
       salary,
       ROW_NUMBER() OVER(ORDER BY salary DESC) AS row_num
FROM employees;


--Q2. Assign row numbers to employees within each department based on salary descending

SELECT 
       emp_id,
       emp_name,
       department,
       salary,
       ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) AS row_num
FROM employees;


--Q3. Assign row numbers based on employee joining date (latest first)

SELECT 
       emp_id,
       emp_name,
       join_date,
       ROW_NUMBER() OVER(ORDER BY join_date DESC) AS row_num
FROM employees;


--Q4. Assign row numbers within each department based on earliest joining date

SELECT 
       emp_id,
       emp_name,
       department,
       join_date,
       ROW_NUMBER() OVER(PARTITION BY department ORDER BY join_date ASC) AS row_num
FROM employees;


--Q5. Assign row numbers to orders based on order date

SELECT 
       order_id,
       customer_name,
       city,
       order_amount,
       order_date,
       ROW_NUMBER() OVER(ORDER BY order_date) AS row_num
FROM orders;


--Q6. Assign row numbers to orders within each city based on order amount (highest first)

SELECT 
       order_id,
       customer_name,
       city,
       order_amount,
       ROW_NUMBER() OVER(PARTITION BY city ORDER BY order_amount DESC) AS row_num
FROM orders;


--Q7. Assign row numbers to employees based on salary (lowest first)

SELECT 
       emp_id,
       emp_name,
       salary,
       ROW_NUMBER() OVER(ORDER BY salary ASC) AS row_num
FROM employees;


--Q8. Assign row numbers within department for employees based on name alphabetically

SELECT 
       emp_id,
       emp_name,
       department,
       ROW_NUMBER() OVER(PARTITION BY department ORDER BY emp_name ASC) AS row_num
FROM employees;



/* =========================================================
                         RANK() FUNCTIONS
========================================================= */

--Q9. Rank all employees based on salary (highest first)

SELECT 
       emp_id,
       emp_name,
       salary,
       RANK() OVER(ORDER BY salary DESC) AS emp_rank
FROM employees;


--Q10. Rank employees within each department based on salary

SELECT 
       emp_id,
       emp_name,
       department,
       salary,
       RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS emp_rank
FROM employees;


--Q11. Rank employees based on joining date (latest gets rank 1)

SELECT 
       emp_id,
       emp_name,
       join_date,
       RANK() OVER(ORDER BY join_date DESC) AS emp_rank
FROM employees;


--Q12. Rank orders based on order amount (highest first)

SELECT 
       order_id,
       customer_name,
       city,
       order_amount,
       RANK() OVER(ORDER BY order_amount DESC) AS order_rank
FROM orders;


--Q13. Rank orders within each city based on order amount

SELECT 
       order_id,
       customer_name,
       city,
       order_amount,
       RANK() OVER(PARTITION BY city ORDER BY order_amount DESC) AS order_rank
FROM orders;


--Q14. Rank employees within department based on salary (lowest first)

SELECT 
       emp_id,
       emp_name,
       department,
       salary,
       RANK() OVER(PARTITION BY department ORDER BY salary ASC) AS emp_rank
FROM employees;


--Q15. Rank employees based on name alphabetically

SELECT 
       emp_id,
       emp_name,
       RANK() OVER(ORDER BY emp_name ASC) AS emp_rank
FROM employees;


--Q16. Rank orders within each city based on order date

SELECT 
       order_id,
       customer_name,
       city,
       order_date,
       RANK() OVER(PARTITION BY city ORDER BY order_date ASC) AS order_rank
FROM orders;



/* =========================================================
                    DENSE_RANK() FUNCTIONS
========================================================= */

--Q17. Assign dense rank to employees based on salary (highest first)

SELECT 
       emp_id,
       emp_name,
       salary,
       DENSE_RANK() OVER(ORDER BY salary DESC) AS dense_rank_num
FROM employees;


--Q18. Assign dense rank within each department based on salary

SELECT 
       emp_id,
       emp_name,
       department,
       salary,
       DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dense_rank_num
FROM employees;


--Q19. Assign dense rank to employees based on joining date

SELECT 
       emp_id,
       emp_name,
       join_date,
       DENSE_RANK() OVER(ORDER BY join_date DESC) AS dense_rank_num
FROM employees;


--Q20. Assign dense rank to orders based on order amount

SELECT 
       order_id,
       customer_name,
       city,
       order_amount,
       DENSE_RANK() OVER(ORDER BY order_amount DESC) AS dense_rank_num
FROM orders;


--Q21. Assign dense rank within each city based on order amount

SELECT 
       order_id,
       customer_name,
       city,
       order_amount,
       DENSE_RANK() OVER(PARTITION BY city ORDER BY order_amount DESC) AS dense_rank_num
FROM orders;


--Q22. Assign dense rank to employees based on salary (lowest first)

SELECT 
       emp_id,
       emp_name,
       salary,
       DENSE_RANK() OVER(ORDER BY salary ASC) AS dense_rank_num
FROM employees;


--Q23. Assign dense rank within department based on joining date

SELECT 
       emp_id,
       emp_name,
       department,
       join_date,
       DENSE_RANK() OVER(PARTITION BY department ORDER BY join_date ASC) AS dense_rank_num
FROM employees;


--Q24. Assign dense rank to orders based on order date

SELECT 
       order_id,
       customer_name,
       city,
       order_date,
       DENSE_RANK() OVER(ORDER BY order_date ASC) AS dense_rank_num
FROM orders;
