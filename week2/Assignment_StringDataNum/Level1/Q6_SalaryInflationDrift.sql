--Q6: Display salary inflation drift analysis with proper case employee name,
--    years since last hike,
--    POWER calculation on years,
--    rounded salary impact,
--    and inflation risk classification.

SELECT 
       emp_id,
       INITCAP(emp_name) AS employee_name,
       TIMESTAMPDIFF(YEAR, last_hike, CURDATE()) AS years_since_hike,
       POWER(
             TIMESTAMPDIFF(YEAR, last_hike, CURDATE()),
             2
       ) AS power_value,
       ROUND(
              salary *
              POWER(
                    1.05,
                    TIMESTAMPDIFF(YEAR, last_hike, CURDATE())
              )
       ) AS salary_impact,
       CASE
            WHEN TIMESTAMPDIFF(YEAR, last_hike, CURDATE()) > 5
                 THEN 'High Inflation Risk'
            WHEN TIMESTAMPDIFF(YEAR, last_hike, CURDATE()) BETWEEN 3 AND 5
                 THEN 'Moderate'
            ELSE 'Low'
       END AS inflation_status
FROM inflation_watch;
