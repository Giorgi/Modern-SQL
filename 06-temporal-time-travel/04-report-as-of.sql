-- Rebuild any report as of any date -- no snapshot tables, no nightly export,
-- no "closest row" guessing.
-- Dialect: SQL Server (T-SQL)
-- Source: Section 6 (Temporal / time travel)

SELECT status,
       COUNT(*)    AS orders,
       SUM(amount) AS value
FROM   orders FOR SYSTEM_TIME AS OF '2026-03-31T23:59:59'
GROUP  BY status
ORDER  BY orders DESC;
