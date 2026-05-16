--Q16: Leap Year Salary Adjustment Audit
--     Extract year, check leap year condition,
--     apply CEIL on salary, find day of year,
--     and classify credit type.

SELECT 
       emp_id,
       emp_name,
       salary,
       YEAR(credit_date) AS credit_year,
       CASE
            WHEN (
                 (YEAR(credit_date) % 4 = 0 AND YEAR(credit_date) % 100 <> 0)
                 OR (YEAR(credit_date) % 400 = 0)
                 )
                 THEN 'Leap Year'
            ELSE 'Non-Leap Year'
       END AS year_type,
       CEIL(salary) AS ceiled_salary,
       DAYOFYEAR(credit_date) AS day_of_year,
       CASE
            WHEN (
                 (YEAR(credit_date) % 4 = 0 AND YEAR(credit_date) % 100 <> 0)
                 OR (YEAR(credit_date) % 400 = 0)
                 )
                 THEN 'Leap Credit'
            ELSE 'Non-Leap Credit'
       END AS credit_classification
FROM leap_salary;
