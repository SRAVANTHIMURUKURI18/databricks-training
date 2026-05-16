--Q11: Display salary credit fraud audit with bank prefix extraction,
--     weekday identification, rounded salary, MOD check on salary,
--     and fraud classification.

SELECT 
       emp_id,
       emp_name,
       LEFT(bank_code, 4) AS bank_prefix,
       DAYNAME(credit_date) AS credit_day,
       ROUND(salary, 0) AS rounded_salary,
       MOD(ROUND(salary, 0), 5) AS salary_mod_5,
       CASE
            WHEN (
                 DAYNAME(credit_date) IN ('Saturday', 'Sunday')
                 AND MOD(ROUND(salary, 0), 5) = 0
                 )
                 THEN 'Weekend Fraud'
            WHEN LEFT(bank_code, 4) = 'HDFC'
                 THEN 'Bank Review'
            ELSE 'Normal'
       END AS audit_classification
FROM salary_credit_audit;
