--Q: Display bonus monitoring analysis with proper case employee name,
--   bonus percentage,
--   bonus day name,
--   absolute salary-bonus difference,
--   and bonus status classification.

SELECT 
       emp_code,
       INITCAP(emp_name) AS employee_name,
       ROUND((bonus / base_salary) * 100, 2) AS bonus_percentage,
       DAYNAME(bonus_date) AS bonus_day,
       ABS(base_salary - bonus) AS salary_bonus_difference,
       CASE
            WHEN ((bonus / base_salary) * 100) > 30
                 AND DAYNAME(bonus_date) IN ('Saturday', 'Sunday')
                 THEN 'Suspicious'
            WHEN ((bonus / base_salary) * 100) <= 20
                 THEN 'Normal'
            ELSE 'Audit'
       END AS bonus_status
FROM bonus_monitor;
