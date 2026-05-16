--Q8: Display name length vs salary correlation analysis with name length,
--    years of service,
--    rounded salary,
--    comparison between name length and years,
--    and bias classification.

SELECT 
       emp_id,
       emp_name,
       LENGTH(emp_name) AS name_length,
       TIMESTAMPDIFF(YEAR, join_date, CURDATE()) AS years_of_service,
       ROUND(salary) AS rounded_salary,
       LENGTH(emp_name) -
       TIMESTAMPDIFF(YEAR, join_date, CURDATE()) AS length_year_difference,
       CASE
            WHEN LENGTH(emp_name) >
                 TIMESTAMPDIFF(YEAR, join_date, CURDATE())
                 THEN 'Name Bias'
            ELSE 'Neutral'
       END AS bias_status
FROM name_salary;
