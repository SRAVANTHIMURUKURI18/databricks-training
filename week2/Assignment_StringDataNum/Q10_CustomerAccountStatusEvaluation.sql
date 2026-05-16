--Q: Display customer account status evaluation with absolute balance,
--   days since last transaction,
--   proper case branch name,
--   sign of balance,
--   and account status classification.

SELECT 
       account_id,
       customer_name,
       ABS(balance) AS absolute_balance,
       DATEDIFF(CURDATE(), last_transaction) AS days_since_transaction,
       INITCAP(branch) AS branch_name,
       SIGN(balance) AS balance_sign,
       CASE
            WHEN balance < 0
                 THEN 'Overdrawn'
            WHEN DATEDIFF(CURDATE(), last_transaction) > 180
                 THEN 'Dormant'
            ELSE 'Active'
       END AS account_status
FROM bank_accounts;
