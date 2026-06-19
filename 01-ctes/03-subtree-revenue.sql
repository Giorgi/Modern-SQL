-- Recursive CTE: revenue across a whole subtree (Electronics + all descendants)
-- Dialect: PostgreSQL
-- Source: Section 1 (CTEs & LATERAL)

WITH RECURSIVE category_tree AS (
    SELECT id FROM categories WHERE name = 'Electronics'
  UNION ALL
    SELECT c.id FROM categories c
    JOIN category_tree ct ON c.parent_id = ct.id
)
SELECT COUNT(*) AS orders, SUM(o.amount) AS revenue
FROM orders o
JOIN products p ON p.id = o.product_id
WHERE p.category_id IN (SELECT id FROM category_tree);
