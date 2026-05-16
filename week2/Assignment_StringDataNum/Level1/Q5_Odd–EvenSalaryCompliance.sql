--Q: Display odd-even salary compliance analysis with lowercase employee name,
--    weekday extraction,
--    rounded salary,
--    MOD calculation on salary,
--    and compliance status.

SELECT 
       emp_id,
       LOWER(emp_name) AS employee_name,
       DAYNAME(payment_date) AS weekday_name,
       ROUND(salary) AS rounded_salary,
       MOD(ROUND(salary), 2) AS salary_mod_value,
       CASE
            WHEN MOD(ROUND(salary), 2) = 0
                 AND MOD(DAY(payment_date), 2) = 1
                 THEN 'Violation'
            ELSE 'Compliant'
       END AS compliance_status
FROM payroll_control;
