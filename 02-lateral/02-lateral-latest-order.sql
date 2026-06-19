-- LATERAL: one subquery, many columns -- find the latest order once,
-- return all its columns.
-- Dialect: PostgreSQL
-- Source: Section 2 (LATERAL)

SELECT c.name AS customer,
       latest.ordered_at, latest.amount, latest.status
FROM customers c,
     LATERAL (SELECT o.ordered_at, o.amount, o.status
              FROM orders o
              WHERE o.customer_id = c.id
              ORDER BY o.ordered_at DESC
              LIMIT 1) AS latest;
