--Q: Display salary increment simulation with lowercase employee name,
--   years since last hike,
--   increment percentage based on rating,
--   rounded new salary,
--   and increment classification.

SELECT 
       emp_id,
       LOWER(emp_name) AS employee_name,
       TIMESTAMPDIFF(YEAR, last_hike, CURDATE()) AS years_since_hike,
       CASE
            WHEN rating = 5 THEN 20
            WHEN rating = 4 THEN 10
            WHEN rating = 3 THEN 5
            ELSE 0
       END AS increment_percent,
       ROUND(
              current_salary +
              (current_salary *
              (CASE
                    WHEN rating = 5 THEN 20
                    WHEN rating = 4 THEN 10
                    WHEN rating = 3 THEN 5
                    ELSE 0
               END) / 100)
       ) AS new_salary,
       CASE
            WHEN rating = 5
                 THEN 'High Increment'
            WHEN rating IN (3,4)
                 THEN 'Moderate'
            ELSE 'No Increment'
       END AS increment_status
FROM salary_revision;
