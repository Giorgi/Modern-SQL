-- The "before": subtotals the way most of us do it -- three queries, three
-- scans, stapled with UNION ALL.
-- Dialect: PostgreSQL
-- Source: Section 3 (Multi-dimensional aggregation) -- anti-pattern
-- (sales = orders JOIN customers JOIN products; see grouping_sets.sql for the CTE)

SELECT region, category, SUM(amount) AS revenue
FROM sales
GROUP BY region, category                 -- the detail rows
UNION ALL
SELECT region, NULL, SUM(amount)
FROM sales GROUP BY region                 -- per-region subtotal
UNION ALL
SELECT NULL, NULL, SUM(amount)
FROM sales;                                -- grand total
