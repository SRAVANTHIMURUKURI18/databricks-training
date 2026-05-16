--Q3: Weekend Work Abuse Detection
--     Day extraction, lowercase name, CEIL hours,
--     weekend overtime / suspicious detection.

SELECT 
       emp_id,
       LOWER(emp_name) AS lower_emp_name,
       DAYNAME(work_date) AS work_day,
       CEIL(TIMESTAMPDIFF(MINUTE, login_time, logout_time)/60) AS working_hours,
       CASE
            WHEN DAYNAME(work_date) IN ('Saturday','Sunday')
                 AND TIMESTAMPDIFF(MINUTE, login_time, logout_time)/60 >= 8
                 THEN 'Weekend Overtime'
            WHEN DAYNAME(work_date) IN ('Saturday','Sunday')
                 AND TIMESTAMPDIFF(MINUTE, login_time, logout_time)/60 < 4
                 THEN 'Suspicious Login'
            ELSE 'Normal Working Day'
       END AS work_status
FROM weekend_monitor;
