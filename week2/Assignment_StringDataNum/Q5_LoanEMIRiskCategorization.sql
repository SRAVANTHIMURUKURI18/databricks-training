--Q: Display loan EMI and risk categorization details with uppercase customer name,
--   monthly interest calculation using POWER function,
--   years since loan start,
--   rounded EMI,
--   and risk classification.

SELECT 
       loan_id,

       UPPER(customer_name) AS customer_name,

       ROUND(
              (loan_amount * (interest_rate/1200) * 
              POWER(1 + (interest_rate/1200), 12))
              /
              (POWER(1 + (interest_rate/1200), 12) - 1)
       ) AS emi,

       POWER(1 + (interest_rate/1200), 12) AS monthly_interest_factor,

       TIMESTAMPDIFF(YEAR, loan_start, CURDATE()) AS loan_years,

       CASE
            WHEN interest_rate > 9
                 THEN 'High Risk'

            WHEN interest_rate BETWEEN 8 AND 9
                 THEN 'Medium Risk'

            ELSE 'Low Risk'
       END AS risk_category

FROM loan_details;
