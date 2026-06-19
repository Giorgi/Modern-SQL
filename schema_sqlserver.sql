/* ============================================================================
   SQL Server demo schema  —  Section 7 (Temporal / "time travel")
   A T-SQL mirror of the shared Postgres schema (schema.txt). The orders table
   is a SYSTEM-VERSIONED temporal table: SQL Server keeps a full, query-able
   history of every row automatically — no triggers, no shadow tables, no app
   code. Run this first, then run section7_temporal_sqlserver.sql.
   Target: SQL Server 2016+ (system-versioning) or Azure SQL Database.
   ============================================================================ */

-- Clean slate. A system-versioned table must have versioning turned OFF before
-- it (and its history table) can be dropped.
IF OBJECT_ID(N'dbo.orders', N'U') IS NOT NULL
    ALTER TABLE dbo.orders SET (SYSTEM_VERSIONING = OFF);
DROP TABLE IF EXISTS dbo.orders;
DROP TABLE IF EXISTS dbo.orders_History;
DROP TABLE IF EXISTS dbo.products;
DROP TABLE IF EXISTS dbo.categories;
DROP TABLE IF EXISTS dbo.customers;
GO

CREATE TABLE dbo.customers (
    id          INT IDENTITY(1,1) PRIMARY KEY,
    name        NVARCHAR(100) NOT NULL,
    region      NVARCHAR(50)  NOT NULL,        -- handy for the ROLLUP/CUBE section
    signup_date DATE          NOT NULL
);

CREATE TABLE dbo.categories (
    id        INT IDENTITY(1,1) PRIMARY KEY,
    name      NVARCHAR(100) NOT NULL,
    parent_id INT NULL REFERENCES dbo.categories(id)   -- NULL for top-level roots
);

CREATE TABLE dbo.products (
    id          INT IDENTITY(1,1) PRIMARY KEY,
    name        NVARCHAR(150) NOT NULL,
    category_id INT           NOT NULL REFERENCES dbo.categories(id),
    tags        NVARCHAR(200) NOT NULL,                 -- denormalized CSV on purpose
    base_price  DECIMAL(10,2) NOT NULL,
    specs       NVARCHAR(MAX) NOT NULL
                CONSTRAINT DF_products_specs DEFAULT N'{}'
                CONSTRAINT CK_products_specs CHECK (ISJSON(specs) = 1)  -- JSON in a column
);
GO

/* orders — the SYSTEM-VERSIONED (temporal) table Section 7 demos.
   status, quantity and amount all change over an order's life; SQL Server
   records every prior version into dbo.orders_History by itself. The two
   period columns + PERIOD FOR SYSTEM_TIME + the WITH clause are the entire
   ceremony — flip the switch and you have an audit log for free. */
CREATE TABLE dbo.orders (
    id          INT           NOT NULL PRIMARY KEY,
    customer_id INT           NOT NULL REFERENCES dbo.customers(id),
    product_id  INT           NOT NULL REFERENCES dbo.products(id),
    quantity    INT           NOT NULL,
    amount      DECIMAL(12,2) NOT NULL,
    status      VARCHAR(20)   NOT NULL,   -- pending/shipped/completed/cancelled/refunded
    ordered_at  DATETIME2(0)  NOT NULL,
    SysStart    DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
    SysEnd      DATETIME2 GENERATED ALWAYS AS ROW END   HIDDEN NOT NULL,
    PERIOD FOR SYSTEM_TIME (SysStart, SysEnd)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.orders_History));
GO

-- Reference data (customers, categories, products). Orders are loaded by the
-- demo script so the temporal history starts clean.
INSERT INTO dbo.customers (name, region, signup_date) VALUES
    (N'Acme Corp', N'EU',   '2025-01-15'),
    (N'Globex',    N'NA',   '2025-02-03'),
    (N'Initech',   N'APAC', '2025-03-21');

INSERT INTO dbo.categories (name, parent_id) VALUES (N'Electronics', NULL);

INSERT INTO dbo.products (name, category_id, tags, base_price, specs) VALUES
    (N'Pro Laptop 14', 1, N'laptop,portable', 1499.00, N'{"cpu":"M3 Pro","ram_gb":18}'),
    (N'Mech Keyboard', 1, N'keyboard,input',    89.00, N'{"layout":"full","switch":"brown"}');
GO
