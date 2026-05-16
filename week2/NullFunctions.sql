-- =====================================================
-- LEVEL 1 (BASIC)
-- =====================================================

-- 1. Show all employees whose salary is NULL

SELECT *
FROM Employees
WHERE salary IS NULL;


-- =====================================================

-- 2. Show all orders where discount is NOT NULL

SELECT *
FROM Orders
WHERE discount IS NOT NULL;


-- =====================================================

-- 3. Get products where category is NULL

SELECT *
FROM Products
WHERE category IS NULL;


-- =====================================================

-- 4. Count number of employees with NULL manager_id

SELECT COUNT(*) AS total_null_managers
FROM Employees
WHERE manager_id IS NULL;


-- =====================================================
-- LEVEL 2 (ISNULL)
-- =====================================================

-- 5. Replace NULL salary with 0

SELECT name,
       ISNULL(salary, 0) AS final_salary
FROM Employees;


-- =====================================================

-- 6. Replace NULL bonus with 1000

SELECT name,
       ISNULL(bonus, 1000) AS final_bonus
FROM Employees;


-- =====================================================

-- 7. Show order amount, if NULL replace with 500

SELECT customer_name,
       ISNULL(amount, 500) AS final_amount
FROM Orders;


-- =====================================================

-- 8. Replace NULL stock with 0

SELECT product_name,
       ISNULL(stock, 0) AS available_stock
FROM Products;


-- =====================================================
-- LEVEL 3 (COALESCE)
-- =====================================================

-- 9. Show employee earnings using salary, if NULL use bonus

SELECT name,
       COALESCE(salary, bonus) AS earnings
FROM Employees;


-- =====================================================

-- 10. Show first available value: salary → bonus → 0

SELECT name,
       COALESCE(salary, bonus, 0) AS income
FROM Employees;


-- =====================================================

-- 11. Show product price: price → 1000

SELECT product_name,
       COALESCE(price, 1000) AS final_price
FROM Products;


-- =====================================================

-- 12. Get customer payment: amount → discount → 0

SELECT customer_name,
       COALESCE(amount, discount, 0) AS payment
FROM Orders;


-- =====================================================
-- LEVEL 4 (NULLIF)
-- =====================================================

-- 13. Convert salary to NULL if salary = 0

SELECT name,
       NULLIF(salary, 0) AS updated_salary
FROM Employees;


-- =====================================================

-- 14. Convert discount to NULL if discount = 0

SELECT customer_name,
       NULLIF(discount, 0) AS updated_discount
FROM Orders;


-- =====================================================

-- 15. Use NULLIF to avoid divide by zero

SELECT amount / NULLIF(discount, 0) AS result
FROM Orders;


-- =====================================================

-- 16. Replace coupon_code with NULL if it is 'DISC10'

SELECT customer_name,
       NULLIF(coupon_code, 'DISC10') AS coupon
FROM Orders;


-- =====================================================
-- LEVEL 5 (REAL-TIME SCENARIOS)
-- =====================================================

-- 17. Calculate total earnings: salary + bonus

SELECT name,
       ISNULL(salary, 0) + ISNULL(bonus, 0) AS total_earnings
FROM Employees;


-- =====================================================

-- 18. Show employees where both salary AND bonus are NULL

SELECT *
FROM Employees
WHERE salary IS NULL
AND bonus IS NULL;


-- =====================================================

-- 19. Show products where price is NULL
-- but category is NOT NULL

SELECT *
FROM Products
WHERE price IS NULL
AND category IS NOT NULL;


-- =====================================================

-- 20. Show orders where both amount and discount are NULL

SELECT *
FROM Orders
WHERE amount IS NULL
AND discount IS NULL;


-- =====================================================
-- LEVEL 6 (ADVANCED)
-- =====================================================

-- 21. Show employee income:
-- COALESCE(salary, bonus, 1000)

SELECT name,
       COALESCE(salary, bonus, 1000) AS employee_income
FROM Employees;


-- =====================================================

-- 22. Replace empty discount with NULL using NULLIF

SELECT customer_name,
       NULLIF(discount, 0) AS final_discount
FROM Orders;


-- =====================================================

-- 23. Show final payable amount:
-- amount - discount (handle NULL)

SELECT customer_name,
       ISNULL(amount, 0) - ISNULL(discount, 0) AS final_payable
FROM Orders;


-- =====================================================

-- 24. Find employees where salary is NULL
-- but manager exists

SELECT *
FROM Employees
WHERE salary IS NULL
AND manager_id IS NOT NULL;
