-- Modify: append with || , delete a key by path with #- .
-- Dialect: PostgreSQL
-- Source: Section 4 (JSON / JSONB)

-- append -- || does the appending
UPDATE products
SET specs['ports'] = specs['ports'] || '"USB-A"'
WHERE id = 42;

-- delete a key -- subscript can't; use #-
UPDATE products
SET specs = specs #- '{display,hz}'
WHERE id = 42;
