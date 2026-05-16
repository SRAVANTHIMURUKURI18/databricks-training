--Q: Display salary risk flagging analysis with lowercase employee name,
--   net salary after tax,
--   revision year,
--   months since revision,
--   and salary risk classification.

SELECT 
       emp_id,
       LOWER(emp_name) AS employee_name,
       ROUND(salary - (salary * tax_percent / 100)) AS net_salary,
       YEAR(last_revision) AS revision_year,
       TIMESTAMPDIFF(MONTH, last_revision, CURDATE()) AS months_since_revision,
       CASE
            WHEN tax_percent > 20
                 AND TIMESTAMPDIFF(MONTH, last_revision, CURDATE()) > 24
                 THEN 'Tax Shock'
            WHEN tax_percent BETWEEN 15 AND 20
                 THEN 'Review Needed'
            ELSE 'Stable'
       END AS salary_status
FROM salary_audit;
