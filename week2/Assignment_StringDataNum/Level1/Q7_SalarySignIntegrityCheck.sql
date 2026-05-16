--Q7: Display salary sign integrity check with uppercase employee name,
--    extracted year,
--    SIGN value of salary,
--    absolute salary,
--    and salary validation status.

SELECT 
       emp_id,
       UPPER(emp_name) AS employee_name,
       YEAR(record_date) AS record_year,
       SIGN(salary) AS salary_sign,
       ABS(salary) AS absolute_salary,
       CASE
            WHEN SIGN(salary) = -1
                 THEN 'Negative Error'
            WHEN SIGN(salary) = 0
                 THEN 'Zero Salary'
            ELSE 'Valid'
       END AS salary_status
FROM salary_integrity;
