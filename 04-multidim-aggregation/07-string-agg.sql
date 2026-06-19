-- string_agg (LISTAGG in the SQL standard / Oracle): collapse a group into
-- one ordered, delimited value -- the inverse of string_to_table.
-- Dialect: PostgreSQL
-- Source: Section 3 (Multi-dimensional aggregation)

SELECT cat.name AS category,
       string_agg(p.name, ', ' ORDER BY p.name) AS products
FROM products p
JOIN categories cat ON cat.id = p.category_id
GROUP BY cat.name;
