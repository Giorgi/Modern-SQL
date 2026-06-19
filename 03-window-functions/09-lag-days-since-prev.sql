-- LAG on a timestamp: days since each customer's previous order.
-- Dialect: PostgreSQL
-- Source: Section 3 (Window functions)

SELECT customer_id, ordered_at,
       ordered_at - LAG(ordered_at)
                    OVER (PARTITION BY customer_id ORDER BY ordered_at) AS days_since_prev
FROM orders;
