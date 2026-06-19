-- Two windows in one query: each row's share of the grand total and of its
-- customer's total -- no joins.
-- Dialect: PostgreSQL
-- Source: Section 2 (Window functions)

SELECT customer_id, amount,
       SUM(amount) OVER (PARTITION BY customer_id) AS customer_total,
       ROUND(100.0 * amount / SUM(amount) OVER (), 1) AS pct_of_all,
       ROUND(100.0 * amount / SUM(amount) OVER (PARTITION BY customer_id), 1) AS pct_of_customer
FROM orders;
