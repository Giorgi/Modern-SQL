-- Ties: ROW_NUMBER is always unique; RANK leaves a gap after a tie;
-- DENSE_RANK does not.
-- Dialect: PostgreSQL
-- Source: Section 2 (Window functions)

SELECT amount,
       ROW_NUMBER() OVER (ORDER BY amount DESC) AS row_number,
       RANK()       OVER (ORDER BY amount DESC) AS rank,
       DENSE_RANK() OVER (ORDER BY amount DESC) AS dense_rank
FROM (VALUES (200), (150), (150), (100)) AS t(amount);
