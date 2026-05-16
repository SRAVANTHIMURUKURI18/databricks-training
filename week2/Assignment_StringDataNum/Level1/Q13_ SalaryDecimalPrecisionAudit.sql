--Q13: Display salary decimal precision audit with truncated salary,
--     difference between rounded and truncated values,
--     day name extraction, employee name length,
--     and precision classification.

SELECT 
       emp_id,
       emp_name,
       TRUNCATE(salary, 2) AS truncated_salary,
       ROUND(salary, 2) AS rounded_salary,
       (ROUND(salary, 2) - TRUNCATE(salary, 2)) AS precision_difference,
       DAYNAME(record_date) AS record_day,
       LENGTH(emp_name) AS name_length,
       CASE
            WHEN (ROUND(salary, 2) - TRUNCATE(salary, 2)) > 0.01
                 THEN 'Precision Loss'
            ELSE 'Safe'
       END AS audit_status
FROM salary_precision;
