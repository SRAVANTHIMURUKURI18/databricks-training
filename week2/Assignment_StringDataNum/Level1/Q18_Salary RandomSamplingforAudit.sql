--Q18: Salary Random Sampling for Audit
--     Generate random sampling flag, round salary,
--     extract weekday, first character of name,
--     and classify sampled records.

SELECT 
       emp_id,
       emp_name,
       ROUND(salary, 0) AS rounded_salary,
       DAYNAME(record_date) AS record_day,
       LEFT(emp_name, 1) AS first_character,
       RAND() AS random_value,
       CASE
            WHEN RAND() > 0.7
                 THEN 'Sampled'
            ELSE 'Skipped'
       END AS sampling_status
FROM salary_sampling;
