-- Index it: pick the index for the query shape.
-- Dialect: PostgreSQL
-- Source: Section 5 (JSON / JSONB)

-- b-tree: filter / sort by one field  (=  <  >  range)
CREATE INDEX ON products ((specs ->> 'cpu'));
-- e.g.  WHERE specs ->> 'cpu' = 'M3 Pro'

-- GIN, jsonb_path_ops: containment & path (@> @?) -- smaller, faster
CREATE INDEX ON products USING gin (specs jsonb_path_ops);
-- e.g.  WHERE specs @> '{"wireless": false}'

-- GIN, default: key exists / filter by any key (? ?| ?&) -- the superset
CREATE INDEX ON products USING gin (specs);
-- e.g.  WHERE specs ? 'cpu'
