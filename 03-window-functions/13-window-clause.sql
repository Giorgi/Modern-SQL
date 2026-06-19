-- The WINDOW clause: name a window spec once, reference it many times --
-- one sort, not three.
-- Dialect: PostgreSQL
-- Source: Section 3 (Window functions)

SELECT customer_id, ordered_at,
       SUM(amount)  OVER w,
       AVG(amount)  OVER w,
       ROW_NUMBER() OVER w
FROM orders
WINDOW w AS (PARTITION BY customer_id ORDER BY ordered_at);
