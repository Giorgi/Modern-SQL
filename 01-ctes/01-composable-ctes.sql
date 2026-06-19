-- CTEs: name your steps, read top to bottom
-- Dialect: PostgreSQL
-- Source: Section 1 (CTEs)

WITH completed AS (
    SELECT * FROM orders WHERE status = 'completed'
),
customer_totals AS (
    SELECT customer_id, SUM(amount) AS total_spend, COUNT(*) AS order_count
    FROM completed
    GROUP BY customer_id
)
SELECT c.name, c.region, t.total_spend, t.order_count
FROM customer_totals t
JOIN customers c ON c.id = t.customer_id
ORDER BY t.total_spend DESC
LIMIT 10;
