-- LAG: each order's change vs the customer's previous order.
-- Dialect: PostgreSQL
-- Source: Section 2 (Window functions)

SELECT customer_id, ordered_at, amount,
       LAG(amount) OVER (PARTITION BY customer_id ORDER BY ordered_at) AS prev_amount,
       amount - LAG(amount) OVER (PARTITION BY customer_id ORDER BY ordered_at) AS change
FROM orders;
