-- Just use the table -- history fills itself. Your code never writes to
-- _History; every UPDATE drops the old version there automatically.
-- Dialect: SQL Server (T-SQL)
-- Source: Section 6 (Temporal / time travel)

INSERT INTO orders (id, customer_id, quantity, amount, status)
VALUES (1001, 1, 2, 2998.00, 'pending');

UPDATE orders SET quantity = 3, amount = 4497.00
WHERE  id = 1001;

UPDATE orders SET status = 'shipped'
WHERE  id = 1001;

UPDATE orders SET status = 'refunded', amount = 2998.00
WHERE  id = 1001;
