-- ROLLUP: shorthand that peels right-to-left -- (a,b) -> (a) -> ().
-- Dialect: PostgreSQL
-- Source: Section 3 (Multi-dimensional aggregation)

SELECT region, category,
       SUM(amount) AS revenue
FROM sales
GROUP BY ROLLUP (region, category);

-- expands to exactly:
-- GROUPING SETS (
--   (region, category),
--   (region),
--   ()
-- )
