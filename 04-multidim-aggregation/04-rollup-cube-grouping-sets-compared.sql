-- ROLLUP vs CUBE vs GROUPING SETS: same columns, three different intents.
-- Dialect: PostgreSQL
-- Source: Section 3 (Multi-dimensional aggregation)

-- the peel: (region, category), (region), ()
GROUP BY ROLLUP (region, category);

-- all combinations: (region, category), (region), (category), ()
GROUP BY CUBE (region, category);

-- exactly these two: no detail row, no grand total
GROUP BY GROUPING SETS ((region), (category));

-- bonus -- they compose:  ROLLUP(a), CUBE(b, c) = the two multiplied
