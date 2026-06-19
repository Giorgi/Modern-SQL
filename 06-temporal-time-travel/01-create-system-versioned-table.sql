-- System-versioned (temporal) table: two period columns + one switch, and the
-- engine maintains a history table for you.
-- Dialect: SQL Server (T-SQL). SQL:2011 SYSTEM_TIME; also in Db2, MariaDB.
-- Source: Section 5 (Temporal / time travel)

CREATE TABLE dbo.orders (
    id          INT           NOT NULL PRIMARY KEY,
    customer_id INT           NOT NULL,
    quantity    INT           NOT NULL,
    amount      DECIMAL(12,2) NOT NULL,
    status      VARCHAR(20)   NOT NULL,
    SysStart    DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
    SysEnd      DATETIME2 GENERATED ALWAYS AS ROW END   HIDDEN NOT NULL,
    PERIOD FOR SYSTEM_TIME (SysStart, SysEnd)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.orders_History));
