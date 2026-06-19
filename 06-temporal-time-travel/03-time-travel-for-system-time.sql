-- Time travel with FOR SYSTEM_TIME: full history, a point-in-time snapshot,
-- and every version active during a window.
-- Dialect: SQL Server (T-SQL)
-- Source: Section 5 (Temporal / time travel)

-- the full lifecycle of one order: current + history, unioned for you
SELECT status, quantity, amount, SysStart, SysEnd
FROM   orders FOR SYSTEM_TIME ALL
WHERE  id = 1001 ORDER BY SysStart;

-- the order exactly as it stood at one instant
SELECT status, quantity, amount FROM orders
       FOR SYSTEM_TIME AS OF '2026-03-31T23:59:59'
WHERE  id = 1001;

-- every version active during a window  (also: BETWEEN a AND b · CONTAINED IN (a, b))
SELECT status, quantity, SysStart, SysEnd
FROM   orders
       FOR SYSTEM_TIME FROM '2026-01-01' TO '2026-04-01'
WHERE  id = 1001
ORDER  BY SysStart;
