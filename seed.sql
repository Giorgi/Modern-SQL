-- ============================================================================
-- Sample data for the Modern SQL demo schema (PostgreSQL)
-- Run AFTER schema.txt. Loads customers, a category tree, products with JSONB
-- specs + CSV tags, and the exact 10 orders the window-function section walks
-- through (running totals 100/300/450/700 for customer 1, etc.).
--
-- Vector embeddings are left empty (they require a model);
-- the vector queries use literal query vectors and are illustrative.
-- ============================================================================

TRUNCATE orders, products, categories, customers RESTART IDENTITY CASCADE;

-- Customers (regions feed the ROLLUP / CUBE / sales-view demos) -----------
INSERT INTO customers (name, region, signup_date) VALUES
    ('Acme Corp', 'North', '2025-01-15'),   -- id 1
    ('Globex',    'South', '2025-02-03'),   -- id 2
    ('Initech',   'North', '2025-03-21');   -- id 3

-- Category tree (the recursive-CTE demo walks down from 'Electronics') -----
--   Electronics
--   ├─ Computers ── Laptops, Desktops
--   ├─ Peripherals ─ Keyboards, Mice
--   └─ Audio ─────── Headphones
INSERT INTO categories (name, parent_id) VALUES
    ('Electronics', NULL),   -- 1
    ('Computers',   1),      -- 2
    ('Peripherals', 1),      -- 3
    ('Audio',       1),      -- 4
    ('Laptops',     2),      -- 5
    ('Desktops',    2),      -- 6
    ('Keyboards',   3),      -- 7
    ('Mice',        3),      -- 8
    ('Headphones',  4);      -- 9

-- Products: heterogeneous JSONB specs (laptop/keyboard/mouse/headphones
-- shapes) + denormalized CSV tags for the string_to_table LATERAL demo ------
INSERT INTO products (name, category_id, tags, base_price, specs) VALUES
    ('MacBook Pro', 5, 'electronics,laptop,portable', 1999.00,
     '{"cpu":"M3 Pro","ram_gb":18,"wireless":false,
       "ports":["USB-C","HDMI","Thunderbolt"],
       "display":{"size_in":14.2,"hz":120},
       "variants":[{"sku":"MBP-14-SLV","color":"silver","stock":12},
                   {"sku":"MBP-14-GRY","color":"space-gray","stock":0}]}'),
    ('XPS 15', 5, 'electronics,laptop', 1499.00,
     '{"cpu":"i9","ram_gb":32,"wireless":false,
       "ports":["USB-C","SD"],
       "display":{"size_in":15.6,"hz":60},
       "variants":[{"sku":"XPS15-SLV","color":"silver","stock":5}]}'),
    ('Keychron K2', 7, 'electronics,wireless,office', 89.00,
     '{"layout":"compact","switch":"brown","wireless":true,
       "connectivity":{"bluetooth":true,"usb_c":true},
       "in_box":["keyboard","USB cable","manual"]}'),
    ('MX Keys', 7, 'electronics,wireless,office', 99.00,
     '{"layout":"full-size","wireless":true,
       "connectivity":{"bluetooth":true,"usb_c":true},
       "dimensions_mm":{"width":440,"height":130}}'),
    ('MX Master', 8, 'electronics,wireless', 99.00,
     '{"dpi":8000,"buttons":7,"wireless":true}'),
    ('Studio Headphones', 9, 'electronics,audio,wireless', 299.00,
     '{"wireless":true,"anc":true,"color":"black"}');

-- Orders: the exact set the window-function section steps through.
-- (customer, product, qty, amount, status, ordered_at)
INSERT INTO orders (customer_id, product_id, quantity, amount, status, ordered_at) VALUES
    (1, 3, 1, 100.00, 'completed', '2026-03-01'),
    (2, 2, 1, 200.00, 'completed', '2026-03-02'),
    (1, 5, 1, 200.00, 'completed', '2026-03-03'),
    (3, 1, 1, 250.00, 'completed', '2026-03-04'),
    (1, 4, 1, 150.00, 'shipped',   '2026-03-05'),
    (2, 3, 1, 150.00, 'refunded',  '2026-03-05'),
    (3, 4, 1, 200.00, 'shipped',   '2026-03-07'),
    (2, 5, 1,  50.00, 'pending',   '2026-03-08'),
    (1, 1, 1, 250.00, 'completed', '2026-03-09'),
    (3, 6, 1, 100.00, 'completed', '2026-03-10');
