-- Search: containment @> (deep, GIN-indexable) and existence ? / ?| / ?&.
-- Dialect: PostgreSQL
-- Source: Section 4 (JSON / JSONB)

-- @>  : does specs CONTAIN this fragment?
SELECT name FROM products
WHERE specs @> '{"wireless": false}';

-- ? exists  ·  ?| any  ·  ?& all  (top-level keys, or array elements)
SELECT name FROM products
WHERE specs -> 'ports' ? 'HDMI'        -- array has 'HDMI'
  AND specs ?& array['cpu','ram_gb'];  -- has BOTH keys
