-- ROWS counts physical rows; RANGE counts values (e.g. days).
-- Dialect: PostgreSQL
-- Source: Section 3 (Window functions)

-- ROWS: always at most 3 rows, whatever the date gaps
SELECT ordered_at, amount,
       AVG(amount) OVER (PARTITION BY customer_id ORDER BY ordered_at
                         ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS avg_rows
FROM orders;

-- RANGE: a value window -- "the last 3 days", not "the last 3 rows"
-- (note: with RANGE, tied ORDER BY values share one frame)
SELECT ordered_at, amount,
       AVG(amount) OVER (PARTITION BY customer_id ORDER BY ordered_at
                         RANGE BETWEEN INTERVAL '3 days' PRECEDING AND CURRENT ROW) AS avg_range
FROM orders;
