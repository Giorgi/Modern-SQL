-- Top-N per group: a window can't go in WHERE (it's computed after WHERE),
-- so wrap it in a subquery and filter outside.
-- Dialect: PostgreSQL
-- Source: Section 3 (Window functions)

SELECT customer_id, ordered_at, amount, rn
FROM (
  SELECT customer_id, ordered_at, amount,
         ROW_NUMBER() OVER (PARTITION BY customer_id
                            ORDER BY amount DESC) AS rn
  FROM orders
) ranked
WHERE rn <= 2;
