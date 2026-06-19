-- SQL/JSON path (SQL:2016): a mini-query inside the value.
--   $ root · .field key · [*] every element · ?( ... ) filter · @ the element
-- Dialect: PostgreSQL
-- Source: Section 4 (JSON / JSONB)

-- @? : does the path match ANY element? -> filter rows
SELECT name FROM products
WHERE specs @? '$.variants[*] ? (@.stock > 0)';

-- jsonb_path_query : return each match as a row
SELECT name, jsonb_path_query(specs, '$.ports[*]')
FROM products;
