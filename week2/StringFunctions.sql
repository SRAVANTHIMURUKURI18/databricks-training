--Q1. Count number of characters in full_name
SELECT full_name,
       LENGTH(full_name) AS total_characters
FROM employees;

--Q2. Count characters using CHAR_LENGTH
SELECT full_name,
       CHAR_LENGTH(full_name) AS total_characters
FROM employees;

--Q3. Convert department to uppercase
SELECT department,
       UPPER(department) AS upper_department
FROM employees;

--Q4. Convert city to lowercase
SELECT city,
       LOWER(city) AS lower_city
FROM employees;

--Q5. Remove spaces from both sides of full_name
SELECT full_name,
       TRIM(full_name) AS trimmed_name
FROM employees;

--Q6. Remove left-side spaces from full_name
SELECT full_name,
       LTRIM(full_name) AS left_trimmed
FROM employees;

--Q7. Remove right-side spaces from full_name
SELECT full_name,
       RTRIM(full_name) AS right_trimmed
FROM employees;

--Q8. Join full_name and department
SELECT CONCAT(full_name, ' - ', department) AS emp_details
FROM employees;

--Q9. Join values using separator
SELECT CONCAT_WS(' | ', emp_id, full_name, city) AS details
FROM employees;

--Q10. Extract first 7 characters from email
SELECT email,
       SUBSTRING(email, 1, 7) AS extracted_text
FROM employees;

--Q11. Extract first 5 characters using SUBSTR
SELECT email,
       SUBSTR(email, 1, 5) AS extracted_text
FROM employees;

--Q12. Extract first 4 characters from full_name
SELECT full_name,
       LEFT(full_name, 4) AS left_text
FROM employees;

--Q13. Extract last 3 characters from city
SELECT city,
       RIGHT(city, 3) AS right_text
FROM employees;

--Q14. Find position of @ in email
SELECT email,
       INSTR(email, '@') AS position
FROM employees;

--Q15. Find position of . in email
SELECT email,
       LOCATE('.', email) AS position
FROM employees;

--Q16. Replace Data with Big Data
SELECT department,
       REPLACE(department, 'Data', 'Big Data') AS updated_department
FROM employees;

--Q17. Reverse full_name
SELECT full_name,
       REVERSE(full_name) AS reversed_name
FROM employees;

--Q18. Pad emp_id with zeros on left side
SELECT emp_id,
       LPAD(emp_id, 5, '0') AS padded_id
FROM employees;

--Q19. Pad city with * on right side
SELECT city,
       RPAD(city, 15, '*') AS padded_city
FROM employees;

--Q20. Remove spaces inside and outside city
SELECT city,
       TRIM(REPLACE(city, ' ', '')) AS cleaned_city
FROM employees;

--Q21. Replace NULL remarks with No remarks
SELECT full_name,
       IFNULL(remarks, 'No remarks') AS remarks
FROM employees;

--Q22. Return first non-null remarks value
SELECT full_name,
       COALESCE(remarks, 'N/A') AS remarks
FROM employees;

--Q23. Find Analytics inside CSV list
SELECT FIND_IN_SET('Analytics', 'Data,Analytics,AI') AS position;
