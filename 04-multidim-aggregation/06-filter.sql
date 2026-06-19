-- FILTER: conditional aggregates without CASE gymnastics -- a WHERE clause
-- per aggregate, many conditional totals in one pass.
-- Dialect: PostgreSQL
-- Source: Section 3 (Multi-dimensional aggregation)

SELECT region,
  SUM(amount)                                     AS total,
  SUM(amount) FILTER (WHERE status = 'refunded')  AS refunded,
  COUNT(*)    FILTER (WHERE status = 'completed') AS completed
FROM sales
GROUP BY region;

-- the old way -- one CASE wrapped in every aggregate:
-- SUM(CASE WHEN status = 'refunded'  THEN amount ELSE 0 END) AS refunded,
-- COUNT(CASE WHEN status = 'completed' THEN 1 END)           AS completed
