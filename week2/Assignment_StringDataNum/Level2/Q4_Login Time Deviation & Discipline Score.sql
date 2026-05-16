--Q4: Login Time Deviation & Discipline Score
--     Extract login hour, working hours, truncate,
--     weekday check, discipline classification.

SELECT 
       emp_id,
       emp_name,
       HOUR(login_datetime) AS login_hour,
       ROUND(TIMESTAMPDIFF(MINUTE, login_datetime, logout_datetime)/60, 1) AS working_hours,
       DAYNAME(login_datetime) AS login_day,
       CASE
            WHEN DAYNAME(login_datetime) NOT IN ('Saturday','Sunday')
                 AND HOUR(login_datetime) < 9
                 AND (TIMESTAMPDIFF(MINUTE, login_datetime, logout_datetime)/60) >= 8
                 THEN 'Disciplined'
            WHEN DAYNAME(login_datetime) NOT IN ('Saturday','Sunday')
                 AND HOUR(login_datetime) > 10
                 THEN 'Late Comer'
            ELSE 'Poor Discipline'
       END AS discipline_status
FROM login_discipline;
