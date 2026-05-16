--Q19: Salary ASCII Integrity Check
--     Extract ASCII of first character,
--     calculate years since joining,
--     floor salary,
--     compare ASCII vs experience,
--     and classify dominance.

SELECT 
       emp_id,
       emp_name,
       ASCII(LEFT(emp_name, 1)) AS ascii_value,
       FLOOR(salary) AS floored_salary,
       FLOOR(DATEDIFF(CURDATE(), join_date) / 365) AS years_since_joining,
       CASE
            WHEN ASCII(LEFT(emp_name, 1)) >
                 FLOOR(DATEDIFF(CURDATE(), join_date) / 365)
                 THEN 'Name Dominates'
            ELSE 'Experience Dominates'
       END AS dominance_status
FROM salary_ascii;
