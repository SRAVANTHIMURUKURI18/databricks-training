--Q5: Absenteeism vs Performance Correlation
--     Last 7 days check, weekday/weekend, floor hours,
--     performance classification.

SELECT 
       emp_id,
       emp_name,
       work_date,
       CASE 
            WHEN work_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
                 THEN 'Last 7 Days'
            ELSE 'Old Record'
       END AS recency_status,
       CASE 
            WHEN DAYNAME(work_date) IN ('Saturday','Sunday')
                 THEN 'Weekend'
            ELSE 'Weekday'
       END AS day_type,
       FLOOR(TIMESTAMPDIFF(MINUTE, login_time, logout_time)/60) AS working_hours,
       CASE
            WHEN work_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
                 AND DAYNAME(work_date) NOT IN ('Saturday','Sunday')
                 AND TIMESTAMPDIFF(MINUTE, login_time, logout_time)/60 >= 8
                 THEN 'Consistent Performer'
            WHEN TIMESTAMPDIFF(MINUTE, login_time, logout_time)/60 < 6
                 THEN 'Irregular Performer'
            ELSE 'Absent / Old Record'
       END AS performance_status
FROM performance_tracker;
