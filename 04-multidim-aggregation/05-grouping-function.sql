-- GROUPING(): tell real NULLs apart from subtotal rows so you can label totals.
-- Dialect: PostgreSQL
-- Source: Section 4 (Multi-dimensional aggregation)

SELECT
  CASE WHEN GROUPING(region) = 1
       THEN 'All regions' ELSE region
  END AS region,
  CASE WHEN GROUPING(category) = 1
       THEN 'All' ELSE category
  END AS category,
  SUM(amount) AS revenue
FROM sales
GROUP BY ROLLUP (region, category)
ORDER BY GROUPING(region), GROUPING(category);
