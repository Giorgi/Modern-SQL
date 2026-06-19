-- Read a value: -> (jsonb), ->> (text), #> / #>> (path), [ ] (subscript).
-- Dialect: PostgreSQL
-- Source: Section 5 (JSON / JSONB)

SELECT
  specs ->  'cpu'            AS cpu,      -- jsonb
  specs ->> 'cpu'            AS cpu_text, -- text
  specs['cpu']               AS cpu_sub,  -- [] = ->  (jsonb only)
  (specs ->> 'ram_gb')::int  AS ram_gb,   -- cast to number
  specs #>  '{display,hz}'   AS hz,       -- nested path
  specs #>> '{display,hz}'   AS hz_text,  -- nested, text
  specs['display']['hz']     AS hz_sub    -- nested subscript
FROM products;
