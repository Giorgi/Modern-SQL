# Modern SQL — Sample Queries

Sample SQL for the **"JOIN 'My Session' ON Modern = 'SQL'"** talk.

Unless noted, queries target **PostgreSQL**. The temporal examples are
**SQL Server (T-SQL)**, and the graph examples are **SQL/PGQ** that requires [**PostgreSQL 19**.](https://www.postgresql.org/about/news/postgresql-19-beta-1-released-3313/)

## Topics

| Folder | Topic | Standard |
|--------|-------|----------|
| `01-ctes` | CTEs & recursive CTEs | SQL:1999 |
| `02-lateral` | LATERAL joins | SQL:1999 |
| `03-window-functions` | Window functions: ranking, running totals, LAG/LEAD, moving averages | SQL:2003 |
| `04-multidim-aggregation` | GROUPING SETS, ROLLUP, CUBE, FILTER, string_agg | SQL:1999 |
| `05-json-jsonb` | JSONB access, search, indexing, JSON_TABLE, building & modifying | SQL:2016 → 2023 |
| `06-temporal-time-travel` | System-versioned tables & `FOR SYSTEM_TIME` time travel | SQL:2011 |
| `07-vector-search` | pgvector: embeddings, distance operators, ANN indexes | beyond the standard |
| `08-graph-queries-bonus` | SQL/PGQ property graphs & `GRAPH_TABLE` ("what's next") | SQL:2023 |


## Schema

The queries reference the [demo schema](schema.txt) (`orders`, `customers`, `products`,
`categories`, …). See `schema_sqlserver.sql` for the SQL Server schema
