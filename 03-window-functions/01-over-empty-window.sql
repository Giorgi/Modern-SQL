-- Empty OVER(): a plain aggregate folds rows; OVER() keeps every row and
-- stamps the total on each.
-- Dialect: PostgreSQL
-- Source: Section 3 (Window functions)

-- Plain aggregate: 10 rows -> 1 row, detail gone
SELECT SUM(amount) FROM orders;

-- Window: 10 rows -> 10 rows, total attached to each
SELECT ordered_at, customer_id, amount,
       SUM(amount) OVER () AS total
FROM orders;
