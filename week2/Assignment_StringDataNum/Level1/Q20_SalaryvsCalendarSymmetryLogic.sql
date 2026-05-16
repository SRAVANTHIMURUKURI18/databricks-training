--Q20: Salary vs Calendar Symmetry Logic
--     Extract day and month, last two digits of salary,
--     uppercase employee name, compute absolute difference,
--     and classify calendar symmetry.

SELECT 
       emp_id,
       UPPER(emp_name) AS upper_emp_name,
       DAY(credit_date) AS credit_day,
       MONTH(credit_date) AS credit_month,
       MOD(FLOOR(salary), 100) AS last_two_salary_digits,
       ABS(DAY(credit_date) - MONTH(credit_date)) AS day_month_difference,
       CASE
            WHEN (
                 DAY(credit_date) = MONTH(credit_date)
                 OR MOD(FLOOR(salary), 100) = DAY(credit_date)
                 )
                 THEN 'Calendar Match'
            ELSE 'Calendar Drift'
       END AS calendar_status
FROM salary_calendar;
