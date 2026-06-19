-- Moving average: ROWS BETWEEN bounds the window to a sliding 3-row span.
-- Dialect: PostgreSQL
-- Source: Section 2 (Window functions)

SELECT ordered_at, customer_id, amount,
       AVG(amount) OVER (PARTITION BY customer_id ORDER BY ordered_at
                         ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg
FROM orders;
