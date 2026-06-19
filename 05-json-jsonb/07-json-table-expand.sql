-- JSON_TABLE: expand an array of objects into queryable rows -- one row per
-- element, filtered like any table.
-- Dialect: PostgreSQL
-- Source: Section 4 (JSON / JSONB)

SELECT p.name, v.sku, v.color, v.stock
FROM products p,
     JSON_TABLE(p.specs, '$.variants[*]'
       COLUMNS (
         sku   text PATH '$.sku',
         color text PATH '$.color',
         stock int  PATH '$.stock'
       )) AS v
WHERE v.stock > 0;
