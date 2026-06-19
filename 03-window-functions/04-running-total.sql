-- Running total: PARTITION BY + ORDER BY makes the window grow row by row.
-- Dialect: PostgreSQL
-- Source: Section 3 (Window functions)

SELECT ordered_at, customer_id, amount,
       SUM(amount) OVER (PARTITION BY customer_id ORDER BY ordered_at) AS running_total
FROM orders;
