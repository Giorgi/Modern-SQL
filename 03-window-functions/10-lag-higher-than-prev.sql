-- LAG inside a comparison: flag orders higher than the previous one
-- (the building block of the gaps-and-islands trick).
-- Dialect: PostgreSQL
-- Source: Section 3 (Window functions)

SELECT customer_id, ordered_at, amount,
       amount > LAG(amount) OVER (PARTITION BY customer_id ORDER BY ordered_at)
         AS higher_than_prev
FROM orders;
