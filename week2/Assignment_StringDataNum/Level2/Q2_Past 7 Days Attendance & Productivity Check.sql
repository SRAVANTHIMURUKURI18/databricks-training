--Q2: Attendance & Productivity Check (Last 7 Days Analysis)
--     Uppercase name, last 7 days filter, weekday/weekend,
--     working hours, productivity classification.

SELECT 
       emp_id,
       UPPER(emp_name) AS upper_emp_name,
       login_date,
       CASE 
            WHEN login_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
                 THEN 'Last 7 Days'
            ELSE 'Older'
       END AS recency_status,
       CASE 
            WHEN DAYNAME(login_date) IN ('Saturday','Sunday')
                 THEN 'Weekend'
            ELSE 'Weekday'
       END AS day_type,
       TIMESTAMPDIFF(HOUR, login_time, logout_time) AS working_hours,
       CASE
            WHEN login_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
                 AND TIMESTAMPDIFF(HOUR, login_time, logout_time) >= 8
                 THEN 'Active & Productive'
            WHEN login_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
                 AND TIMESTAMPDIFF(HOUR, login_time, logout_time) < 8
                 THEN 'Active but Low Hours'
            ELSE 'Absent from Last 7 Days'
       END AS attendance_status
FROM attendance_log;
