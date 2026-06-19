-- For scale: an approximate nearest-neighbour (HNSW) index. Exact kNN scans
-- every row; HNSW trades a little recall for big speed.
-- Dialect: PostgreSQL + pgvector
-- Source: Section 6 (Vector search)

CREATE INDEX ON products
  USING hnsw
  (embedding vector_cosine_ops);
