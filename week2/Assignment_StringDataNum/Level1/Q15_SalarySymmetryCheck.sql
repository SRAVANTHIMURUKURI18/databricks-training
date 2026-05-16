--Q15: Display salary symmetry check with integer salary extraction,
--     reversed salary digits, weekday extraction, proper case name,
--     and symmetry classification.

SELECT 
       emp_id,
       CONCAT(
            UPPER(LEFT(emp_name, 1)),
            LOWER(SUBSTRING(emp_name, 2))
       ) AS proper_emp_name,
       FLOOR(salary) AS integer_salary,
       REVERSE(CAST(FLOOR(salary) AS CHAR)) AS reversed_salary,
       DAYNAME(processed_date) AS processed_day,
       CASE
            WHEN CAST(FLOOR(salary) AS CHAR) = REVERSE(CAST(FLOOR(salary) AS CHAR))
                 THEN 'Symmetric Pay'
            ELSE 'Asymmetric'
       END AS symmetry_status
FROM salary_symmetry;
