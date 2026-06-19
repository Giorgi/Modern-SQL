-- pgvector: an embedding is just a column on your existing table -- no
-- separate datastore. Adds the vector type, distance operators, ANN indexes.
-- Dialect: PostgreSQL + pgvector
-- Source: Section 6 (Vector search)

CREATE EXTENSION IF NOT EXISTS vector;

-- add one column to your EXISTING table (size = your model's output)
ALTER TABLE products ADD COLUMN IF NOT EXISTS embedding vector(1536);

-- pgvector adds: the vector type, distance operators (<=> <-> <#>),
-- and ANN indexes (hnsw, ivfflat)
