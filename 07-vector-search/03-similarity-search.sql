-- Similarity search is just ORDER BY distance ... LIMIT. Embed the query with
-- the SAME model, then sort by distance.
--   <=> cosine  ·  <-> Euclidean (L2)  ·  <#> inner product
-- Dialect: PostgreSQL + pgvector
-- Source: Section 7 (Vector search)

SELECT name,
       embedding <=> '[0.88, 0.22, 0.12]' AS distance
FROM   products
ORDER  BY embedding <=> '[0.88, 0.22, 0.12]'
LIMIT  3;
