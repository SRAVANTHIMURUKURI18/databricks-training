--Q: Display employee attendance evaluation with lowercase employee name,
--   attendance percentage,
--   month name,
--   absent days calculation,
--   and attendance performance classification.

SELECT 
       emp_id,

       LOWER(emp_name) AS employee_name,

       MONTHNAME(record_date) AS month_name,

       ROUND((present_days / total_days) * 100, 2) AS attendance_percentage,

       (total_days - present_days) AS absent_days,

       CASE
            WHEN ((present_days / total_days) * 100) >= 90
                 THEN 'Excellent'

            WHEN ((present_days / total_days) * 100) BETWEEN 75 AND 89
                 THEN 'Average'

            ELSE 'Poor'
       END AS attendance_status

FROM attendance;
