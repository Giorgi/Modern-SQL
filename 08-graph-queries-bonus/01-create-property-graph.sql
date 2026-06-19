-- SQL/PGQ (SQL:2023): describe a property graph over tables you already have
-- -- no new database, no data copied, just metadata.
-- Dialect: Standard SQL/PGQ. Coming in PostgreSQL 19; Oracle 23ai has it today.
-- Source: Section 8 (Graph queries -- bonus)

CREATE PROPERTY GRAPH social
  VERTEX TABLES (
    person KEY (id) LABEL person PROPERTIES (name, city)
  )
  EDGE TABLES (
    knows SOURCE      KEY (a) REFERENCES person (id)
          DESTINATION KEY (b) REFERENCES person (id)
          LABEL knows
  );
