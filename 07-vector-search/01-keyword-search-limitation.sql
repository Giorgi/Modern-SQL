-- The hook: keyword search matches words, not meaning -- it misses synonyms
-- like "notebook", "MacBook", "ultrabook".
-- Dialect: PostgreSQL
-- Source: Section 7 (Vector search)

SELECT * FROM products WHERE name ILIKE '%laptop%';
