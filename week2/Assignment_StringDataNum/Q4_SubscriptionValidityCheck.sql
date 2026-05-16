--Q: Display subscription validity details with email domain,
--   subscription duration in months, formatted fee,
--   remaining days from today,
--   and subscription status classification.

SELECT 
       user_id,

       user_email,

       SUBSTRING_INDEX(user_email, '@', -1) AS email_domain,

       TIMESTAMPDIFF(MONTH, start_date, end_date) AS subscription_months,

       FORMAT(subscription_fee, 2) AS formatted_fee,

       DATEDIFF(end_date, CURDATE()) AS remaining_days,

       CASE
            WHEN end_date < CURDATE()
                 THEN 'Expired'

            WHEN DATEDIFF(end_date, CURDATE()) <= 30
                 THEN 'Expiring Soon'

            ELSE 'Active'
       END AS subscription_status

FROM subscriptions;
