--Q12: Display salary credit time drift analysis with hour extraction,
--     lowercase employee name, floored salary, salary-hour difference,
--     and credit time classification.

SELECT 
       emp_id,
       LOWER(emp_name) AS lower_emp_name,
       HOUR(credit_ts) AS credit_hour,
       FLOOR(salary) AS floored_salary,
       (FLOOR(salary) - HOUR(credit_ts)) AS salary_hour_difference,
       CASE
            WHEN HOUR(credit_ts) BETWEEN 0 AND 3
                 THEN 'Midnight Drift'
            WHEN HOUR(credit_ts) > 3 AND HOUR(credit_ts) < 9
                 THEN 'After Hours'
            ELSE 'Business Hours'
       END AS time_classification
FROM salary_time_drift;
