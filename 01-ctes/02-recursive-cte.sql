-- Recursive CTE: walk a category tree to any depth in one query
-- Dialect: PostgreSQL
-- Source: Section 1 (CTEs)

WITH RECURSIVE category_tree AS (
    SELECT id, name, parent_id, 1 AS depth   -- anchor: where we start
    FROM categories
    WHERE name = 'Electronics'
  UNION ALL
    SELECT c.id, c.name, c.parent_id, ct.depth + 1   -- recursive step
    FROM categories c
    JOIN category_tree ct ON c.parent_id = ct.id
)
SELECT id, name, depth FROM category_tree ORDER BY depth;
