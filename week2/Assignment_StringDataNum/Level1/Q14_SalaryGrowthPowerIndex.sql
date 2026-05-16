--Q14: Display salary growth power index with years since last hike,
--     exponential growth calculation using POWER(),
--     projected salary rounding, uppercase employee name,
--     and growth classification.

SELECT 
       emp_id,
       UPPER(emp_name) AS upper_emp_name,
       base_salary,
       growth_rate,
       FLOOR(DATEDIFF(CURDATE(), last_hike) / 365) AS years_since_hike,
       ROUND(
            base_salary * POWER(growth_rate, FLOOR(DATEDIFF(CURDATE(), last_hike) / 365)),
            0
       ) AS projected_salary,

       CASE
            WHEN (
                 base_salary * POWER(growth_rate, FLOOR(DATEDIFF(CURDATE(), last_hike) / 365))
                 ) > 150000
                 THEN 'Explosive Growth'
            WHEN (
                 base_salary * POWER(growth_rate, FLOOR(DATEDIFF(CURDATE(), last_hike) / 365))
                 ) BETWEEN 100000 AND 150000
                 THEN 'Controlled'
            ELSE 'Stagnant'
       END AS growth_status

FROM salary_growth;
