--Q: Display salary digit pattern analysis with last two characters of employee name,
--   day of month from credit date,
--   truncated salary,
--   MOD calculation on salary,
--   and pattern match classification.

SELECT 
       emp_id,
       RIGHT(emp_name, 2) AS last_two_characters,
       DAY(credit_date) AS credit_day,
       TRUNCATE(salary, 0) AS truncated_salary,
       MOD(TRUNCATE(salary, 0), 10) AS salary_mod_value,
       CASE
            WHEN MOD(TRUNCATE(salary, 0), 10) = DAY(credit_date)
                 THEN 'Pattern Match'
            ELSE 'No Match'
       END AS pattern_status
FROM salary_digits;
