-- Why JSON: heterogeneous attributes per product type. Let the flexible part
-- of the row be flexible -- one jsonb column.
-- Dialect: PostgreSQL
-- Source: Section 4 (JSON / JSONB)

ALTER TABLE products ADD COLUMN specs jsonb NOT NULL DEFAULT '{}';
