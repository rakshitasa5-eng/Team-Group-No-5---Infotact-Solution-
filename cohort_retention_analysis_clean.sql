-- ============================================================
-- cohort_retention_analysis_clean.sql
-- Project   : Cohort Retention Analysis
-- Internship: Infotact Solutions
-- Purpose   : Load cohort_retention_analysis.xlsx (exported as CSV)
--             into MySQL in normalized form and run cleanliness checks.
-- Author    : <your name>
-- ============================================================

-- STEP 1: Create database
CREATE DATABASE IF NOT EXISTS cohort_check;
USE cohort_check;

-- ============================================================
-- STEP 2: Create the STAGING table (wide format, same shape as the sheet)
-- Columns 0-22 in Excel become c0-c22 here (SQL doesn't allow
-- column names that are pure numbers).
-- Values are PERCENTAGES (0-100), so DECIMAL(5,2) fits them.
-- ============================================================
DROP TABLE IF EXISTS retention_pct_wide;
CREATE TABLE retention_pct_wide (
    CohortMonth DATE,
    c0  DECIMAL(5,2), c1  DECIMAL(5,2), c2  DECIMAL(5,2), c3  DECIMAL(5,2),
    c4  DECIMAL(5,2), c5  DECIMAL(5,2), c6  DECIMAL(5,2), c7  DECIMAL(5,2),
    c8  DECIMAL(5,2), c9  DECIMAL(5,2), c10 DECIMAL(5,2), c11 DECIMAL(5,2),
    c12 DECIMAL(5,2), c13 DECIMAL(5,2), c14 DECIMAL(5,2), c15 DECIMAL(5,2),
    c16 DECIMAL(5,2), c17 DECIMAL(5,2), c18 DECIMAL(5,2), c19 DECIMAL(5,2),
    c20 DECIMAL(5,2), c21 DECIMAL(5,2), c22 DECIMAL(5,2)
);

-- ============================================================
-- STEP 3: Import the data.
--
-- >>> IN EXCEL FIRST:
--   File -> Save As -> CSV (Comma delimited) -> save as
--   cohort_retention_analysis.csv
--
-- >>> THEN IN WORKBENCH:
--   1. Run STEP 1 and STEP 2 above first (creates the table).
--   2. Navigator -> Schemas -> cohort_check -> Tables ->
--      right-click "retention_pct_wide" -> Table Data Import Wizard.
--   3. Browse to cohort_retention_analysis.csv and import.
--   4. On the column mapping screen, the CSV's "0,1,2...22" headers
--      should map to table columns "c0, c1, c2 ... c22" -- check this
--      manually if the wizard auto-maps incorrectly.
-- ============================================================

-- STEP 3b: Verify import worked (should show ~24 rows)
SELECT COUNT(*) AS staging_row_count FROM retention_pct_wide;

-- ============================================================
-- STEP 4: Create the NORMALIZED (long-format) table
-- One row per (CohortMonth, CohortIndex, RetentionPct)
-- ============================================================
DROP TABLE IF EXISTS retention_pct_raw;
CREATE TABLE retention_pct_raw (
    CohortMonth   DATE,
    CohortIndex   INT,
    RetentionPct  DECIMAL(5,2) NULL,
    PRIMARY KEY (CohortMonth, CohortIndex)
);

-- Convert wide -> long
INSERT INTO retention_pct_raw (CohortMonth, CohortIndex, RetentionPct)
SELECT CohortMonth, 0, c0 FROM retention_pct_wide WHERE c0 IS NOT NULL
UNION ALL SELECT CohortMonth, 1, c1 FROM retention_pct_wide WHERE c1 IS NOT NULL
UNION ALL SELECT CohortMonth, 2, c2 FROM retention_pct_wide WHERE c2 IS NOT NULL
UNION ALL SELECT CohortMonth, 3, c3 FROM retention_pct_wide WHERE c3 IS NOT NULL
UNION ALL SELECT CohortMonth, 4, c4 FROM retention_pct_wide WHERE c4 IS NOT NULL
UNION ALL SELECT CohortMonth, 5, c5 FROM retention_pct_wide WHERE c5 IS NOT NULL
UNION ALL SELECT CohortMonth, 6, c6 FROM retention_pct_wide WHERE c6 IS NOT NULL
UNION ALL SELECT CohortMonth, 7, c7 FROM retention_pct_wide WHERE c7 IS NOT NULL
UNION ALL SELECT CohortMonth, 8, c8 FROM retention_pct_wide WHERE c8 IS NOT NULL
UNION ALL SELECT CohortMonth, 9, c9 FROM retention_pct_wide WHERE c9 IS NOT NULL
UNION ALL SELECT CohortMonth, 10, c10 FROM retention_pct_wide WHERE c10 IS NOT NULL
UNION ALL SELECT CohortMonth, 11, c11 FROM retention_pct_wide WHERE c11 IS NOT NULL
UNION ALL SELECT CohortMonth, 12, c12 FROM retention_pct_wide WHERE c12 IS NOT NULL
UNION ALL SELECT CohortMonth, 13, c13 FROM retention_pct_wide WHERE c13 IS NOT NULL
UNION ALL SELECT CohortMonth, 14, c14 FROM retention_pct_wide WHERE c14 IS NOT NULL
UNION ALL SELECT CohortMonth, 15, c15 FROM retention_pct_wide WHERE c15 IS NOT NULL
UNION ALL SELECT CohortMonth, 16, c16 FROM retention_pct_wide WHERE c16 IS NOT NULL
UNION ALL SELECT CohortMonth, 17, c17 FROM retention_pct_wide WHERE c17 IS NOT NULL
UNION ALL SELECT CohortMonth, 18, c18 FROM retention_pct_wide WHERE c18 IS NOT NULL
UNION ALL SELECT CohortMonth, 19, c19 FROM retention_pct_wide WHERE c19 IS NOT NULL
UNION ALL SELECT CohortMonth, 20, c20 FROM retention_pct_wide WHERE c20 IS NOT NULL
UNION ALL SELECT CohortMonth, 21, c21 FROM retention_pct_wide WHERE c21 IS NOT NULL
UNION ALL SELECT CohortMonth, 22, c22 FROM retention_pct_wide WHERE c22 IS NOT NULL;

-- ============================================================
-- STEP 5: VALIDATION / CLEANLINESS CHECKS
-- ============================================================

-- 5.1 Row count check
SELECT COUNT(*) AS total_rows FROM retention_pct_raw;

-- 5.2 Duplicate (CohortMonth, CohortIndex) pairs (should be 0 -- PK)
SELECT CohortMonth, CohortIndex, COUNT(*) AS cnt
FROM retention_pct_raw
GROUP BY CohortMonth, CohortIndex
HAVING cnt > 1;

-- 5.3 RetentionPct must always be between 0 and 100
SELECT * FROM retention_pct_raw
WHERE RetentionPct < 0 OR RetentionPct > 100;

-- 5.4 CohortIndex 0 should ALWAYS be exactly 100%
--     (month 0 = the full cohort, this is the baseline)
SELECT * FROM retention_pct_raw
WHERE CohortIndex = 0 AND RetentionPct <> 100;

-- 5.5 Retention should not increase as CohortIndex increases
--     (you can't retain MORE customers than you started with)
SELECT a.CohortMonth, a.CohortIndex, a.RetentionPct, base.RetentionPct AS month0_pct
FROM retention_pct_raw a
JOIN retention_pct_raw base
  ON a.CohortMonth = base.CohortMonth AND base.CohortIndex = 0
WHERE a.RetentionPct > base.RetentionPct;

-- 5.6 Every cohort month should have a CohortIndex = 0 entry
SELECT DISTINCT CohortMonth
FROM retention_pct_raw
WHERE CohortMonth NOT IN (
    SELECT CohortMonth FROM retention_pct_raw WHERE CohortIndex = 0
);

-- 5.7 CohortIndex should be within expected bounds (0-22)
SELECT * FROM retention_pct_raw
WHERE CohortIndex < 0 OR CohortIndex > 22;

-- ============================================================
-- If all checks (5.2, 5.3, 5.4, 5.5, 5.6, 5.7) return EMPTY
-- results, the retention percentage data is clean.
-- ============================================================
