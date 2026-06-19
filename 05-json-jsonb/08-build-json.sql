-- The other direction: build JSON out of rows with jsonb_build_object and
-- jsonb_agg -- your API payload, from SQL.
-- Dialect: PostgreSQL
-- Source: Section 5 (JSON / JSONB)

-- relational -> document: assemble a clean API payload
SELECT jsonb_build_object(
         'id',    p.id,
         'name',  p.name,
         'price', p.base_price,
         'specs', p.specs
       ) AS product_json
FROM products p;

-- collapse a category's products into one JSON array
SELECT cat.name, jsonb_agg(p.name ORDER BY p.name) AS products
FROM products p JOIN categories cat ON cat.id = p.category_id
GROUP BY cat.name;
