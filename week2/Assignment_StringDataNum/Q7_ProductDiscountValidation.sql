--Q: Display product discount validation with proper case product name,
--   discount amount,
--   discount percentage,
--   sale day name,
--   and discount status classification.

SELECT 
       product_id,

       INITCAP(product_name) AS product_name,

       ABS(mrp - selling_price) AS discount_amount,

       ROUND(((mrp - selling_price) / mrp) * 100, 2) AS discount_percentage,

       DAYNAME(sale_date) AS sale_day,

       CASE
            WHEN selling_price < mrp
                 THEN 'Valid Discount'

            WHEN selling_price > mrp
                 THEN 'Overpriced'

            ELSE 'No Discount'
       END AS discount_status

FROM product_sales;
