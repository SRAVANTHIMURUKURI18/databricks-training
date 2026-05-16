(Assumed contacts, salary, and employee_department (ed) tables)
-- =========================================================
-- 1. Retrieve employees and their managers
-- =========================================================

SELECT e.emp_name AS employee,
       m.emp_name AS manager
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.emp_id;


-- =========================================================
-- 2. Display all employees and departments
-- =========================================================

SELECT e.emp_name,
       d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;


-- =========================================================
-- 3. Employees who report to a manager
-- =========================================================

SELECT e.emp_name AS employee,
       m.emp_name AS manager
FROM employees e
INNER JOIN employees m
ON e.manager_id = m.emp_id;


-- =========================================================
-- 4. Total salary paid to each employee and department
-- (Assuming salary table exists)
-- =========================================================

SELECT e.emp_name,
       d.dept_name,
       s.salary
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id
LEFT JOIN salary s
ON e.emp_id = s.emp_id;


-- =========================================================
-- 5. Employees without departments
-- =========================================================

SELECT emp_name
FROM employees
WHERE dept_id IS NULL;


-- =========================================================
-- 6. Employees and their projects
-- =========================================================

SELECT e.emp_name,
       p.project_name
FROM employees e
LEFT JOIN projects p
ON e.emp_id = p.emp_id;


-- =========================================================
-- 7. Employees who completed at least one project
-- =========================================================

SELECT e.emp_name,
       p.project_name
FROM employees e
INNER JOIN projects p
ON e.emp_id = p.emp_id;


-- =========================================================
-- 8. Employees and projects including all projects
-- =========================================================

SELECT e.emp_name,
       p.project_name
FROM employees e
RIGHT JOIN projects p
ON e.emp_id = p.emp_id;


-- =========================================================
-- 9. Employees and salaries
-- =========================================================

SELECT e.emp_name,
       s.salary
FROM employees e
LEFT JOIN salary s
ON e.emp_id = s.emp_id;


-- =========================================================
-- 10. Employees and department names
-- =========================================================

SELECT e.emp_name,
       d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;


-- =========================================================
-- 11. Departments and employees including empty departments
-- =========================================================

SELECT d.dept_name,
       e.emp_name
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id;


-- =========================================================
-- 12. Employees with contact information
-- =========================================================

SELECT e.emp_name,
       c.phone_number
FROM employees e
LEFT JOIN contacts c
ON e.emp_id = c.emp_id;


-- =========================================================
-- 13. Employees and departments including unmatched rows
-- =========================================================

SELECT e.emp_name,
       d.dept_name
FROM employees e
FULL OUTER JOIN departments d
ON e.dept_id = d.dept_id;


-- =========================================================
-- 14. Employees without projects
-- =========================================================

SELECT e.emp_name,
       p.project_name
FROM employees e
LEFT JOIN projects p
ON e.emp_id = p.emp_id
WHERE p.project_name IS NULL;


-- =========================================================
-- 15. Employees and project names
-- =========================================================

SELECT e.emp_name,
       p.project_name
FROM employees e
LEFT JOIN projects p
ON e.emp_id = p.emp_id;


-- =========================================================
-- 16. Projects and assigned employees
-- =========================================================

SELECT p.project_name,
       e.emp_name
FROM projects p
LEFT JOIN employees e
ON p.emp_id = e.emp_id;


-- =========================================================
-- 17. Employees with managers and projects
-- =========================================================

SELECT e.emp_name,
       m.emp_name AS manager,
       p.project_name
FROM employees e
INNER JOIN employees m
ON e.manager_id = m.emp_id
INNER JOIN projects p
ON e.emp_id = p.emp_id;


-- =========================================================
-- 18. Employees with valid departments only
-- =========================================================

SELECT e.emp_name,
       d.dept_name
FROM employees e
INNER JOIN departments d
ON e.dept_id = d.dept_id;


-- =========================================================
-- 19. Employees belonging to multiple departments
-- (Assuming employee_department table exists)
-- =========================================================

SELECT e.emp_name,
       d.dept_name
FROM employee_department ed
INNER JOIN employees e
ON ed.emp_id = e.emp_id
INNER JOIN departments d
ON ed.dept_id = d.dept_id;


-- =========================================================
-- 20. Departments and employees including empty departments
-- =========================================================

SELECT d.dept_name,
       e.emp_name
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id;


-- =========================================================
-- 21. Employees with projects but no department
-- =========================================================

SELECT e.emp_name,
       p.project_name
FROM employees e
INNER JOIN projects p
ON e.emp_id = p.emp_id
WHERE e.dept_id IS NULL;


-- =========================================================
-- 22. Count employees in each department
-- =========================================================

SELECT d.dept_name,
       COUNT(e.emp_id) AS total_employees
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name;


-- =========================================================
-- 23. Employees reporting to managers only
-- =========================================================

SELECT e.emp_name AS employee,
       m.emp_name AS manager
FROM employees e
INNER JOIN employees m
ON e.manager_id = m.emp_id;


-- =========================================================
-- 24. All employees with managers including NULL managers
-- =========================================================

SELECT e.emp_name AS employee,
       m.emp_name AS manager
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.emp_id;


-- =========================================================
-- 25. Departments and employee count
-- =========================================================

SELECT d.dept_name,
       COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name;


-- =========================================================
-- 26. Employees and departments including empty departments
-- =========================================================

SELECT e.emp_name,
       d.dept_name
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id;


-- =========================================================
-- 27. Employees without salary records
-- =========================================================

SELECT e.emp_name
FROM employees e
LEFT JOIN salary s
ON e.emp_id = s.emp_id
WHERE s.salary IS NULL;


-- =========================================================
-- 28. Employees and project assignments
-- =========================================================

SELECT e.emp_name,
       p.project_name
FROM employees e
LEFT JOIN projects p
ON e.emp_id = p.emp_id;


-- =========================================================
-- 29. Employees with department and project details
-- =========================================================

SELECT e.emp_name,
       d.dept_name,
       p.project_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id
LEFT JOIN projects p
ON e.emp_id = p.emp_id;


-- =========================================================
-- 30. Employees with departments including NULL departments
-- =========================================================

SELECT e.emp_name,
       d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;
