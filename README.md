# Modern SQL — Sample Queries

Sample SQL extracted from the talk **"JOIN 'My Session' ON Modern = 'SQL'"**.
One folder per topic, one `.sql` file per demo/query. Each file has a header
comment with the demo name, SQL dialect, and the source section.

Unless noted, queries target **PostgreSQL**. The temporal examples are
**SQL Server (T-SQL)**, and the graph examples are **standard SQL/PGQ**.

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

The queries reference the demo schema (`orders`, `customers`, `products`,
`categories`, …). See `schema_sqlserver.sql` and the seed scripts in the
parent folder.
