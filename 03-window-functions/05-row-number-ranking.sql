-- ROW_NUMBER: rank each customer's orders, biggest first.
-- Dialect: PostgreSQL
-- Source: Section 3 (Window functions)

SELECT customer_id, ordered_at, amount,
       ROW_NUMBER() OVER (PARTITION BY customer_id
                          ORDER BY amount DESC) AS rn
FROM orders;
