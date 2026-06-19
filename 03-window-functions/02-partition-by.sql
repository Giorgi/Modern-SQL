-- PARTITION BY: the window resets per customer.
-- Dialect: PostgreSQL
-- Source: Section 2 (Window functions)

SELECT ordered_at, customer_id, amount,
       SUM(amount) OVER (PARTITION BY customer_id) AS customer_total
FROM orders;
