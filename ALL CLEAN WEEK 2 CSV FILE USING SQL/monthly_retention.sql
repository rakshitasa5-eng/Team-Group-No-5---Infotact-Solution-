-- =============================================================
-- monthly_retention.sql
-- Generated from: monthly_retention.csv
-- Rows: 23 | Columns: 2
-- Audit: No duplicates, no nulls, no invalid retention values.
--   cohort_index is sequential 0–22 (months since cohort start).
--   retention_rate starts at 100.00 (month 0 baseline).
--   All values are between 0 and 100 (valid percentage range).
-- Column renames applied:
--   CohortIndex → cohort_index
--   0           → retention_rate
-- =============================================================

DROP TABLE IF EXISTS monthly_retention;

CREATE TABLE monthly_retention (
    cohort_index    INTEGER         NOT NULL,  -- months since cohort start (0 = baseline)
    retention_rate  NUMERIC(8, 6)   NOT NULL,  -- percentage retained (0.00 – 100.00)
    PRIMARY KEY (cohort_index)
);

INSERT INTO monthly_retention (cohort_index, retention_rate) VALUES
    (0, 100.0),
    (1, 58.943478),
    (2, 58.009091),
    (3, 52.361905),
    (4, 53.673684),
    (5, 54.105556),
    (6, 50.055556),
    (7, 46.8375),
    (8, 44.1),
    (9, 43.94),
    (10, 48.214286),
    (11, 45.166667),
    (12, 40.218182),
    (13, 44.76),
    (14, 50.644444),
    (15, 42.325),
    (16, 33.728571),
    (17, 43.116667),
    (18, 47.483333),
    (19, 38.225),
    (20, 46.4),
    (21, 51.5),
    (22, 37.5);
