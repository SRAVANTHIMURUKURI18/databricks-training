--Q10: Display salary digit sum audit with first character of employee name,
--     truncated salary,
--     logical digit sum,
--     extracted audit day,
--     and audit classification.

SELECT 
       emp_id,
       LEFT(emp_name, 1) AS first_character,
       TRUNCATE(salary, 0) AS truncated_salary,
       (
         MOD(TRUNCATE(salary,0),10) +
         MOD(FLOOR(TRUNCATE(salary,0)/10),10) +
         MOD(FLOOR(TRUNCATE(salary,0)/100),10) +
         MOD(FLOOR(TRUNCATE(salary,0)/1000),10) +
         MOD(FLOOR(TRUNCATE(salary,0)/10000),10)
       ) AS digit_sum,
       DAY(audit_date) AS audit_day,
       CASE
            WHEN (
                 MOD(TRUNCATE(salary,0),10) +
                 MOD(FLOOR(TRUNCATE(salary,0)/10),10) +
                 MOD(FLOOR(TRUNCATE(salary,0)/100),10) +
                 MOD(FLOOR(TRUNCATE(salary,0)/1000),10) +
                 MOD(FLOOR(TRUNCATE(salary,0)/10000),10)
                 ) > 20
                 THEN 'Digit Alert'
            ELSE 'Normal'
       END AS audit_status
FROM digit_audit;
