-- GROUPING SETS: name exactly the groupings you want -- detail, subtotal and
-- grand total in one scan.
-- Dialect: PostgreSQL
-- Source: Section 4 (Multi-dimensional aggregation)

WITH sales AS (
  SELECT cu.region, cat.name AS category,
         o.amount, o.status
  FROM orders o
  JOIN customers  cu  ON cu.id  = o.customer_id
  JOIN products   p   ON p.id   = o.product_id
  JOIN categories cat ON cat.id = p.category_id
)
SELECT region, category, SUM(amount) AS revenue
FROM sales
GROUP BY GROUPING SETS (
  (region, category),   -- detail
  (region),             -- subtotal
  ()                    -- grand total
);
