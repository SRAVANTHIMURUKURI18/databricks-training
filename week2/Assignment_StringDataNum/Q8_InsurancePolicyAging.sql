--Q: Display insurance policy aging details with uppercase holder name,
--   policy duration in years,
--   remaining days,
--   rounded premium amount,
--   and policy classification.

SELECT 
       policy_id,
       UPPER(holder_name) AS holder_name,
       TIMESTAMPDIFF(YEAR, policy_start, policy_end) AS policy_duration_years,
       DATEDIFF(policy_end, CURDATE()) AS remaining_days,
       ROUND(premium_amount) AS rounded_premium,
       CASE
            WHEN policy_end < CURDATE()
                 THEN 'Expired'

            WHEN TIMESTAMPDIFF(YEAR, policy_start, policy_end) >= 3
                 THEN 'Long Term'

            ELSE 'Mid Term'
       END AS policy_status
FROM insurance_policies;
