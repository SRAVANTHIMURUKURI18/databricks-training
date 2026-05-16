--Q17: Fiscal Year Boundary Salary Check
--     Determine fiscal year classification, extract month,
--     format salary, convert name to lowercase,
--     and classify credit timing.

SELECT 
       emp_id,
       LOWER(emp_name) AS lower_emp_name,
       FORMAT(salary, 2) AS formatted_salary,
       MONTH(credit_date) AS credit_month,
       CASE
            WHEN MONTH(credit_date) = 3 AND DAY(credit_date) = 31
                 THEN 'Year End Credit'
            WHEN MONTH(credit_date) = 4 AND DAY(credit_date) = 1
                 THEN 'Year Start Credit'
            ELSE 'Mid Year'
       END AS fiscal_classification,
       CASE
            WHEN MONTH(credit_date) >= 4
                 THEN YEAR(credit_date)
            ELSE YEAR(credit_date) - 1
       END AS fiscal_year
FROM fiscal_salary;
