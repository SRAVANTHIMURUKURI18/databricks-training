--Q:For each employee:Convert emp_name to proper case ---upper /lower ---Initcap (CamelCase),Calculate total income = base_salary + bonus (NULL safe) +,Round total income to nearest integer,Extract joining year, Use CASE to classify:,Senior if experience > 7 years,Mid if between 4 and 7,Junior otherwise
Query:
      SELECT 
             emp_id,
      
             UPPER(emp_name) AS upper_name,
      
             LOWER(emp_name) AS lower_name,
      
             INITCAP(emp_name) AS camel_case_name,
      
             ROUND(base_salary + IFNULL(bonus,0)) AS total_income,
      
             YEAR(joining_date) AS joining_year,
      
             TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) AS experience_years,
      
             CASE
                  WHEN TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) > 7
                       THEN 'Senior'
      
                  WHEN TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) BETWEEN 4 AND 7
                       THEN 'Mid'
      
                  ELSE 'Junior'
             END AS employee_level
      
      FROM employee_payments;
