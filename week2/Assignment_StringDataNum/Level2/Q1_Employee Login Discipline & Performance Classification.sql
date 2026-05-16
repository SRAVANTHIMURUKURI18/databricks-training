--Q1: Employee Login Discipline & Performance Classification
--     Proper case name, weekday/weekend check,
--     working hours calculation, rounding, and performance classification.

SELECT 
       emp_id,
       CONCAT(
            UPPER(LEFT(emp_name,1)),
            LOWER(SUBSTRING(emp_name,2))
       ) AS proper_emp_name,
       CASE 
            WHEN DAYNAME(login_time) IN ('Saturday','Sunday')
                 THEN 'Weekend'
            ELSE 'Weekday'
       END AS day_type,
       ROUND(TIMESTAMPDIFF(MINUTE, login_time, logout_time)/60, 2) AS working_hours,
       CASE
            WHEN DAYNAME(login_time) NOT IN ('Saturday','Sunday')
                 AND (TIMESTAMPDIFF(MINUTE, login_time, logout_time)/60) >= 8
                 THEN 'Good Performer'

            WHEN DAYNAME(login_time) NOT IN ('Saturday','Sunday')
                 AND (TIMESTAMPDIFF(MINUTE, login_time, logout_time)/60) < 6
                 THEN 'Bad Performer'
            ELSE 'Weekend Login'
       END AS performance_status
FROM employee_login;
