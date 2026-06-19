-- Filter by an accessed value: use ->> (text) and cast for numbers.
-- Comparing raw -> jsonb to text is the classic footgun.
-- Dialect: PostgreSQL
-- Source: Section 4 (JSON / JSONB)

SELECT name FROM products
WHERE specs ->> 'cpu' = 'M3 Pro'        -- text = text
  AND (specs ->> 'ram_gb')::int >= 16;  -- cast, compare

-- the trap, every time:
--   specs ->  'cpu' = 'M3 Pro'   -- wrong: jsonb = text
--   specs ->> 'cpu' = 'M3 Pro'   -- right: text = text
