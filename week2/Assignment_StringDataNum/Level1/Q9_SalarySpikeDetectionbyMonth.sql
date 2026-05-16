--Q9: Display salary spike detection by month with month name,
--    CEIL salary,
--    last day of month validation,
--    and salary spike classification.

SELECT 
       emp_id,
       emp_name,
       MONTHNAME(paid_date) AS month_name,
       CEIL(salary) AS ceil_salary,
       LAST_DAY(paid_date) AS last_day_of_month,
       CASE
            WHEN paid_date = LAST_DAY(paid_date)
                 THEN 'End Month Spike'
            ELSE 'Regular'
       END AS spike_status
FROM salary_monthly;
