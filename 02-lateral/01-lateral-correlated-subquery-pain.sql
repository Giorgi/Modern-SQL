-- The "before": a correlated subquery returns one column, so you copy-paste
-- it once per field -- three scans of orders for the same latest row.
-- Dialect: PostgreSQL
-- Source: Section 1 (CTEs & LATERAL) -- anti-pattern, contrast for LATERAL

SELECT c.name,
  (SELECT o.ordered_at FROM orders o
     WHERE o.customer_id = c.id
     ORDER BY o.ordered_at DESC LIMIT 1) AS last_ordered,
  (SELECT o.amount FROM orders o
     WHERE o.customer_id = c.id
     ORDER BY o.ordered_at DESC LIMIT 1) AS last_amount,
  (SELECT o.status FROM orders o
     WHERE o.customer_id = c.id
     ORDER BY o.ordered_at DESC LIMIT 1) AS last_status
FROM customers c;
