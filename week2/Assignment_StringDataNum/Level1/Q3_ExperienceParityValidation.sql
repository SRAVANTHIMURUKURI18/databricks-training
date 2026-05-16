--Q: Display employee experience parity validation with uppercase employee name,
--   actual experience calculation,
--   difference between declared and actual experience,
--   floored salary,
--   and experience validation status.

SELECT 
       emp_id,
       UPPER(emp_name) AS employee_name,
       TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) AS actual_experience,
       ABS(
            declared_experience -
            TIMESTAMPDIFF(YEAR, joining_date, CURDATE())
       ) AS experience_difference,
       FLOOR(salary) AS floored_salary,
       CASE
            WHEN declared_experience >
                 TIMESTAMPDIFF(YEAR, joining_date, CURDATE())
                 THEN 'Overstated'
            WHEN declared_experience <
                 TIMESTAMPDIFF(YEAR, joining_date, CURDATE())
                 THEN 'Understated'
            ELSE 'Matched'
       END AS experience_status
FROM employee_experience;
