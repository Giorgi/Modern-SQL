-- Traverse the graph: "friends of friends" as a pattern match. The engine
-- rewrites MATCH (a)-[:knows]->(b)-[:knows]->(c) to ordinary joins.
-- Dialect: Standard SQL/PGQ (SQL:2023)
-- Source: Section 8 (Graph queries -- bonus)

SELECT a, via, c
FROM GRAPH_TABLE (social
  MATCH (a IS person)-[IS knows]->(b IS person)
                     -[IS knows]->(c IS person)
  WHERE a.id <> c.id
  COLUMNS (a.name AS a, b.name AS via, c.name AS c)
)
ORDER BY a, c;
