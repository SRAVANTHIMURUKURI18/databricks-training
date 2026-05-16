--Q: Analyze order delivery details with customer name in uppercase,
--   calculate delivery days, replace NULL delivery date with today,
--   truncate order amount to 1 decimal,
--   and classify delivery status.

SELECT 
       order_id,

       UPPER(customer_name) AS customer_name,

       order_date,

       IFNULL(delivery_date, CURDATE()) AS final_delivery_date,

       DATEDIFF(IFNULL(delivery_date, CURDATE()), order_date) AS delivery_days,

       TRUNCATE(order_amount, 1) AS truncated_amount,

       CASE
            WHEN delivery_date IS NULL
                 THEN 'Pending'

            WHEN DATEDIFF(delivery_date, order_date) = 0
                 THEN 'Same-day'

            WHEN DATEDIFF(delivery_date, order_date) > 3
                 THEN 'Delayed'

            ELSE 'Normal'
       END AS delivery_status

FROM orders_delivery;
