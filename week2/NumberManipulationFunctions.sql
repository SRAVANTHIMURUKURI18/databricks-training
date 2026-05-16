1. Question: Convert negative number into positive number
      SELECT ABS(-100) AS absolute_value;

2. Question: Round base_salary to 2 decimal places
      SELECT emp_name,
             base_salary,
             ROUND(base_salary, 2) AS rounded_salary
      FROM employee_salary;

3. Question: Round salary upward to nearest integer
      SELECT emp_name,
             base_salary,
             CEIL(base_salary) AS ceil_salary
      FROM employee_salary;

4. Question: Round salary downward to nearest integer
      SELECT emp_name,
             base_salary,
             FLOOR(base_salary) AS floor_salary
      FROM employee_salary;

5. Question: Remove decimals after 1 digit without rounding
      SELECT emp_name,
             base_salary,
             TRUNCATE(base_salary, 1) AS truncated_salary
      FROM employee_salary;

6. Question: Find remainder when experience_years divided by 2
      SELECT emp_name,
             experience_years,
             MOD(experience_years, 2) AS remainder
      FROM employee_salary;

7. Question: Find 2 power 3
      SELECT POWER(2, 3) AS power_value;

8. Question: Find square root of 64
      SELECT SQRT(64) AS square_root;

9. Question: Check sign of salary
      SELECT emp_name,
             base_salary,
             SIGN(base_salary) AS sign_value
      FROM employee_salary;

10. Question: Generate random number
      SELECT RAND() AS random_number;

11. Question: Format salary with commas and 2 decimals
      SELECT emp_name,
             FORMAT(base_salary, 2) AS formatted_salary
      FROM employee_salary;

12. Question: Find highest value between salary and bonus
      SELECT emp_name,
             GREATEST(base_salary, IFNULL(bonus, 0)) AS highest_value
      FROM employee_salary;

13. Question: Find lowest value between salary and bonus
      SELECT emp_name,
             LEAST(base_salary, IFNULL(bonus, 0)) AS lowest_value
      FROM employee_salary;
