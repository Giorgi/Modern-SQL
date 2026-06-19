-- CROSS JOIN LATERAL with a set-returning function: split a CSV tag string
-- into rows, then count purchases per tag.
-- Dialect: PostgreSQL
-- Source: Section 1 (CTEs & LATERAL)

SELECT t.tag, COUNT(*) AS purchase_count
FROM orders o
JOIN products p ON p.id = o.product_id
CROSS JOIN LATERAL string_to_table(p.tags, ',') AS t(tag)
GROUP BY t.tag
ORDER BY purchase_count DESC;
