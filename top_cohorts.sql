-- =============================================================
-- top_cohorts.sql
-- Generated from: top_cohorts.csv
-- Rows: 24 | Columns: 3 (2 raw + 1 derived rank column)
-- Audit: No duplicates, no nulls, no invalid values.
--   All 24 cohort months (2023-01 to 2024-12) present — none missing.
--   avg_retention_rate range: 38.095238 to 100.0 (valid 0–100 %).
--   2024-11 and 2024-12 = 100.0 (newest cohorts, only 1–2 months observed).
--   Rows are sorted descending by avg_retention_rate (rank 1 = best).
-- Column renames applied:
--   CohortMonth → cohort_month
--   0           → avg_retention_rate
-- Column added:
--   rank        → integer rank (1 = highest avg_retention_rate)
-- =============================================================

DROP TABLE IF EXISTS top_cohorts;

CREATE TABLE top_cohorts (
    rank                INTEGER         NOT NULL,  -- 1 = best performing cohort
    cohort_month        CHAR(7)         NOT NULL,  -- YYYY-MM
    avg_retention_rate  NUMERIC(12, 6)  NOT NULL,  -- average retention % across observed months
    PRIMARY KEY (cohort_month)
);

INSERT INTO top_cohorts (rank, cohort_month, avg_retention_rate) VALUES
    (1, '2024-11', 100.0),
    (2, '2024-12', 100.0),
    (3, '2024-10', 97.133333),
    (4, '2024-09', 93.55),
    (5, '2024-08', 86.0),
    (6, '2024-07', 85.7),
    (7, '2024-06', 74.1),
    (8, '2024-05', 70.525),
    (9, '2024-04', 69.188889),
    (10, '2024-03', 66.0),
    (11, '2024-02', 64.145455),
    (12, '2023-01', 63.636364),
    (13, '2023-12', 60.769231),
    (14, '2024-01', 56.4),
    (15, '2023-11', 54.221429),
    (16, '2023-10', 51.486667),
    (17, '2023-09', 48.33125),
    (18, '2023-06', 45.110526),
    (19, '2023-02', 44.886364),
    (20, '2023-07', 44.755556),
    (21, '2023-08', 42.029412),
    (22, '2023-05', 41.79),
    (23, '2023-03', 38.854545),
    (24, '2023-04', 38.095238);
