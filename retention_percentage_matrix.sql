-- =============================================================
-- retention_percentage_matrix.sql
-- Generated from: retention_percentage_matrix.csv
-- Shape: 24 rows (cohort months) x 24 columns
-- Audit: No duplicates, no null CohortMonth, no invalid values.
--   CohortMonth is sequential 2023-01 through 2024-12.
--   month_01 (baseline) = 1.0 for all 24 cohorts.
--   All non-null values are proportions in range [0.0, 1.0].
--   NaN pattern follows expected upper-right triangle (0 violations).
--   13 sparse NULLs within observable range = zero-subscriber months (valid).
--   Total non-null cells: 286 of 552.
-- Column renames applied:
--   CohortMonth → cohort_month
--   1–23        → month_01–month_23 (zero-padded, SQL-safe names)
-- =============================================================

DROP TABLE IF EXISTS retention_percentage_matrix;

CREATE TABLE retention_percentage_matrix (
    cohort_month  CHAR(7)        NOT NULL,  -- YYYY-MM cohort label
    month_01      NUMERIC(10, 6)  NOT NULL,  -- baseline: always 1.0
    month_02      NUMERIC(10, 6)          ,
    month_03      NUMERIC(10, 6)          ,
    month_04      NUMERIC(10, 6)          ,
    month_05      NUMERIC(10, 6)          ,
    month_06      NUMERIC(10, 6)          ,
    month_07      NUMERIC(10, 6)          ,
    month_08      NUMERIC(10, 6)          ,
    month_09      NUMERIC(10, 6)          ,
    month_10      NUMERIC(10, 6)          ,
    month_11      NUMERIC(10, 6)          ,
    month_12      NUMERIC(10, 6)          ,
    month_13      NUMERIC(10, 6)          ,
    month_14      NUMERIC(10, 6)          ,
    month_15      NUMERIC(10, 6)          ,
    month_16      NUMERIC(10, 6)          ,
    month_17      NUMERIC(10, 6)          ,
    month_18      NUMERIC(10, 6)          ,
    month_19      NUMERIC(10, 6)          ,
    month_20      NUMERIC(10, 6)          ,
    month_21      NUMERIC(10, 6)          ,
    month_22      NUMERIC(10, 6)          ,
    month_23      NUMERIC(10, 6)          ,
    PRIMARY KEY (cohort_month)
);

INSERT INTO retention_percentage_matrix (cohort_month, month_01, month_02, month_03, month_04, month_05, month_06, month_07, month_08, month_09, month_10, month_11, month_12, month_13, month_14, month_15, month_16, month_17, month_18, month_19, month_20, month_21, month_22, month_23) VALUES
    ('2023-01', 1.0, 0.5, 0.5, 0.5, NULL, NULL, 1.0, NULL, NULL, 0.5, 0.5, NULL, NULL, NULL, NULL, NULL, 0.5, NULL, 0.5, NULL, 1.0, 0.5, NULL),
    ('2023-02', 1.0, 0.5, 0.5, 0.375, 0.5, 0.25, 0.375, 0.375, 0.625, 0.25, 0.375, 0.625, 0.375, 0.625, 0.5, 0.375, NULL, 0.5, 0.375, 0.25, 0.25, 0.5, 0.375),
    ('2023-03', 1.0, 0.454545, 0.363636, 0.181818, 0.363636, 0.181818, 0.090909, 0.545455, 0.363636, 0.363636, 0.454545, 0.090909, 0.454545, 0.181818, 0.545455, 0.545455, 0.181818, 0.363636, 0.545455, 0.454545, 0.272727, 0.545455, NULL),
    ('2023-04', 1.0, 0.333333, 0.266667, 0.466667, 0.266667, 0.333333, 0.333333, 0.2, 0.333333, 0.266667, 0.333333, 0.4, 0.133333, 0.466667, 0.4, 0.266667, 0.2, 0.533333, 0.666667, 0.466667, 0.333333, NULL, NULL),
    ('2023-05', 1.0, 0.357143, 0.5, 0.642857, 0.357143, 0.285714, 0.285714, 0.214286, 0.357143, 0.5, 0.5, 0.357143, 0.285714, 0.357143, 0.5, 0.428571, 0.428571, 0.357143, 0.285714, 0.357143, NULL, NULL, NULL),
    ('2023-06', 1.0, 0.238095, 0.380952, 0.285714, 0.47619, 0.666667, 0.47619, 0.333333, 0.333333, 0.380952, 0.285714, 0.428571, 0.52381, 0.52381, 0.571429, 0.380952, 0.47619, 0.333333, 0.47619, NULL, NULL, NULL, NULL),
    ('2023-07', 1.0, 0.555556, 0.333333, 0.111111, 0.5, 0.555556, 0.388889, 0.555556, 0.444444, 0.388889, 0.444444, 0.222222, 0.333333, 0.388889, 0.666667, 0.388889, 0.277778, 0.5, NULL, NULL, NULL, NULL, NULL),
    ('2023-08', 1.0, 0.37037, 0.259259, 0.444444, 0.37037, 0.333333, 0.259259, 0.444444, 0.481481, 0.333333, 0.259259, 0.518519, 0.407407, 0.518519, 0.518519, 0.333333, 0.296296, NULL, NULL, NULL, NULL, NULL, NULL),
    ('2023-09', 1.0, 0.466667, 0.333333, 0.333333, 0.333333, 0.466667, 0.6, 0.4, 0.2, 0.533333, 0.666667, 0.533333, 0.4, 0.333333, 0.466667, 0.666667, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    ('2023-10', 1.0, 0.555556, 0.666667, 0.5, 0.333333, 0.611111, 0.333333, 0.5, 0.388889, 0.388889, 0.5, 0.555556, 0.555556, 0.444444, 0.388889, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    ('2023-11', 1.0, 0.5, 0.545455, 0.5, 0.545455, 0.5, 0.590909, 0.409091, 0.590909, 0.363636, 0.454545, 0.5, 0.454545, 0.636364, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    ('2023-12', 1.0, 0.45, 0.7, 0.55, 0.6, 0.55, 0.4, 0.7, 0.35, 0.7, 0.75, 0.65, 0.5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    ('2024-01', 1.0, 0.576923, 0.615385, 0.538462, 0.538462, 0.5, 0.576923, 0.423077, 0.461538, 0.384615, 0.615385, 0.538462, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    ('2024-02', 1.0, 0.611111, 0.722222, 0.666667, 0.666667, 0.722222, 0.5, 0.555556, 0.444444, 0.555556, 0.611111, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    ('2024-03', 1.0, 0.56, 0.72, 0.52, 0.72, 0.76, 0.52, 0.56, 0.56, 0.68, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    ('2024-04', 1.0, 0.590909, 0.727273, 0.590909, 0.681818, 0.636364, 0.681818, 0.636364, 0.681818, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    ('2024-05', 1.0, 0.571429, 0.607143, 0.571429, 0.642857, 0.75, 0.857143, 0.642857, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    ('2024-06', 1.0, 0.740741, 0.62963, 0.592593, 0.666667, 0.814815, 0.740741, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    ('2024-07', 1.0, 0.964286, 0.714286, 0.857143, 0.785714, 0.821429, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    ('2024-08', 1.0, 0.8, 0.85, 0.8, 0.85, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    ('2024-09', 1.0, 0.903226, 0.870968, 0.967742, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    ('2024-10', 1.0, 0.956522, 0.956522, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    ('2024-11', 1.0, 1.0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    ('2024-12', 1.0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
