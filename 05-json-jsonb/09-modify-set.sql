-- Modify: subscript assignment sets & replaces (and auto-creates missing
-- nested objects). jsonb_set is only needed for a path computed at runtime.
-- Dialect: PostgreSQL
-- Source: Section 4 (JSON / JSONB)

-- subscript assigns like a dict key
UPDATE products
SET specs['wireless'] = 'true'
WHERE id = 42;

-- nested -- auto-creates missing objects
UPDATE products
SET specs['display']['hz'] = '144'
WHERE id = 42;
