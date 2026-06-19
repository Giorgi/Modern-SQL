-- The superpower: it's still SQL -- semantic ranking + a structured filter +
-- a JOIN in one query. A vector-only DB needs a second system for this.
-- Dialect: PostgreSQL + pgvector
-- Source: Section 6 (Vector search)

SELECT p.name, p.base_price, c.name AS category,
       p.embedding <=> :q AS distance
FROM   products p
JOIN   categories c ON c.id = p.category_id
WHERE  p.base_price < 1000      -- structured filter
ORDER  BY p.embedding <=> :q    -- semantic rank
LIMIT  5;
