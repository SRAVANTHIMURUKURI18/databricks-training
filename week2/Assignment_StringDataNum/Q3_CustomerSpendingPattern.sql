--Q: Display customer spending analysis with formatted customer name,
--   purchase month name, rounded amount, absolute purchase value,
--   and spending category classification.

SELECT 
       cust_id,

       INITCAP(cust_name) AS customer_name,

       MONTHNAME(purchase_date) AS purchase_month,

       ROUND(purchase_amount) AS rounded_amount,

       ABS(purchase_amount) AS absolute_amount,

       CASE
            WHEN purchase_amount > 15000
                 THEN 'High Spender'

            WHEN purchase_amount BETWEEN 8000 AND 15000
                 THEN 'Medium Spender'

            ELSE 'Low Spender'
       END AS spending_category

FROM customer_spending;
