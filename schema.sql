-- Shared demo schema: customers, categories, products, orders

CREATE TABLE customers (
    id          serial PRIMARY KEY,
    name        text        NOT NULL,
    region      text        NOT NULL,   -- handy later for ROLLUP/CUBE
    signup_date date        NOT NULL
);

CREATE TABLE categories (
    id        serial PRIMARY KEY,
    name      text    NOT NULL,
    parent_id integer REFERENCES categories(id)   -- NULL for top-level roots
);

-- products.specs (jsonb) holds attributes that vary by product type: a laptop has
-- cpu/ram_gb/display, a keyboard has switch/layout — JSON gives that flexibility
-- without a column per spec. This is the JSON section's demo column.
CREATE TABLE products (
    id          serial        PRIMARY KEY,
    name        text          NOT NULL,
    category_id integer       NOT NULL REFERENCES categories(id),
    tags        text          NOT NULL,                 -- denormalized CSV on purpose: feeds string_to_table (LATERAL)
    base_price  numeric(10,2) NOT NULL,
    specs       jsonb         NOT NULL DEFAULT '{}'     -- JSON section: heterogeneous per-product attributes
);

-- Example products.specs document (shape varies by product type):
--   {
--     "cpu": "M3 Pro", "ram_gb": 18, "wireless": false,
--     "ports": ["USB-C", "HDMI", "Thunderbolt"],
--     "display": { "size_in": 14.2, "hz": 120 },
--     "variants": [
--       { "sku": "MBP-14-SLV", "color": "silver",     "stock": 12 },
--       { "sku": "MBP-14-GRY", "color": "space-gray",  "stock": 0  }
--     ]
--   }
-- CREATE INDEX idx_products_specs ON products USING gin (specs jsonb_path_ops);  -- JSON section

CREATE TABLE orders (
    id          serial        PRIMARY KEY,
    customer_id integer       NOT NULL REFERENCES customers(id),
    product_id  integer       NOT NULL REFERENCES products(id),
    quantity    integer       NOT NULL,
    amount      numeric(12,2) NOT NULL,  -- line total: feeds window functions & aggregation
    status      text          NOT NULL,  -- completed/shipped/pending/cancelled/refunded
    ordered_at  timestamptz   NOT NULL   -- time axis for windows + the latest-order lookup
);

-- Aggregation section: the demos query a denormalized "sales" relation
-- (orders joined to its dimensions). The slides build it as an inline CTE;
-- exposing it as a VIEW lets the ROLLUP / CUBE / GROUPING SETS / FILTER /
-- subtotals files run standalone.
CREATE VIEW sales AS
SELECT cu.region,
       cat.name AS category,
       o.amount,
       o.status
FROM orders o
JOIN customers  cu  ON cu.id  = o.customer_id
JOIN products   p   ON p.id   = o.product_id
JOIN categories cat ON cat.id = p.category_id;

-- Vector section: pgvector lives in the same database. The embedding column is
-- added to the existing products table (no separate datastore). vector(1536)
-- matches a typical model output size; use your model's dimension.
-- The vector demo file shows this same ALTER live during the talk.
CREATE EXTENSION IF NOT EXISTS vector;
ALTER TABLE products ADD COLUMN IF NOT EXISTS embedding vector(1536);
-- CREATE INDEX idx_products_embedding ON products USING hnsw (embedding vector_cosine_ops);  -- vector section
