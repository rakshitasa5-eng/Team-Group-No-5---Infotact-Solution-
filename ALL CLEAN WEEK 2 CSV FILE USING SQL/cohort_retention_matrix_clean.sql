-- ============================================================
-- cohort_retention_matrix_clean.sql
-- Project   : Cohort Retention Analysis
-- Internship: Infotact Solutions
-- Purpose   : Load cohort_retention_matrix.csv into MySQL in
--             normalized form and run cleanliness checks.
-- Author    : <your name>
-- ============================================================

-- NOTE: This CSV is TAB-delimited, not comma-delimited.
-- Also its CohortIndex columns run 1-23 (no "month 0" column
-- in this particular file -- unlike cohort_counts.csv).

-- STEP 1: Create database
CREATE DATABASE IF NOT EXISTS cohort_check;
USE cohort_check;

-- ============================================================
-- STEP 2: Create the STAGING table (wide format, same shape as CSV)
-- Columns 1-23 become c1-c23.
-- ============================================================
DROP TABLE IF EXISTS retention_matrix_wide;
CREATE TABLE retention_matrix_wide (
    CohortMonth VARCHAR(7),
    c1  INT, c2  INT, c3  INT, c4  INT, c5  INT, c6  INT, c7  INT,
    c8  INT, c9  INT, c10 INT, c11 INT, c12 INT, c13 INT, c14 INT,
    c15 INT, c16 INT, c17 INT, c18 INT, c19 INT, c20 INT, c21 INT,
    c22 INT, c23 INT
);

-- ============================================================
-- STEP 3: Import the CSV.
--
-- >>> IN WORKBENCH:
--   1. Run STEP 1 and STEP 2 above first (creates the table).
--   2. Navigator -> Schemas -> cohort_check -> Tables ->
--      right-click "retention_matrix_wide" -> Table Data Import Wizard.
--   3. Browse to cohort_retention_matrix__1_.csv
--   4. IMPORTANT: On the format screen, set the field separator
--      to TAB (not comma) -- the wizard usually auto-detects this,
--      but double check before clicking Next.
--   5. Map CSV columns "1,2,3...23" to table columns "c1,c2,c3...c23".
--   6. Finish the import.
--
-- If the wizard mis-detects the delimiter, easiest fix: open the
-- CSV in Excel, Save As -> CSV (Comma delimited), and re-import
-- using a comma instead.
-- ============================================================

-- STEP 3b: Verify import worked (should show ~24 rows)
SELECT COUNT(*) AS staging_row_count FROM retention_matrix_wide;

-- ============================================================
-- STEP 4: Create the NORMALIZED (long-format) table
-- One row per (CohortMonth, CohortIndex, CustomerCount)
-- ============================================================
DROP TABLE IF EXISTS retention_matrix_raw;
CREATE TABLE retention_matrix_raw (
    CohortMonth   VARCHAR(7) NOT NULL,
    CohortIndex   INT        NOT NULL,
    CustomerCount INT        NULL,
    PRIMARY KEY (CohortMonth, CohortIndex)
);

-- Convert wide -> long
INSERT INTO retention_matrix_raw (CohortMonth, CohortIndex, CustomerCount)
SELECT CohortMonth, 1, c1 FROM retention_matrix_wide WHERE c1 IS NOT NULL
UNION ALL SELECT CohortMonth, 2, c2 FROM retention_matrix_wide WHERE c2 IS NOT NULL
UNION ALL SELECT CohortMonth, 3, c3 FROM retention_matrix_wide WHERE c3 IS NOT NULL
UNION ALL SELECT CohortMonth, 4, c4 FROM retention_matrix_wide WHERE c4 IS NOT NULL
UNION ALL SELECT CohortMonth, 5, c5 FROM retention_matrix_wide WHERE c5 IS NOT NULL
UNION ALL SELECT CohortMonth, 6, c6 FROM retention_matrix_wide WHERE c6 IS NOT NULL
UNION ALL SELECT CohortMonth, 7, c7 FROM retention_matrix_wide WHERE c7 IS NOT NULL
UNION ALL SELECT CohortMonth, 8, c8 FROM retention_matrix_wide WHERE c8 IS NOT NULL
UNION ALL SELECT CohortMonth, 9, c9 FROM retention_matrix_wide WHERE c9 IS NOT NULL
UNION ALL SELECT CohortMonth, 10, c10 FROM retention_matrix_wide WHERE c10 IS NOT NULL
UNION ALL SELECT CohortMonth, 11, c11 FROM retention_matrix_wide WHERE c11 IS NOT NULL
UNION ALL SELECT CohortMonth, 12, c12 FROM retention_matrix_wide WHERE c12 IS NOT NULL
UNION ALL SELECT CohortMonth, 13, c13 FROM retention_matrix_wide WHERE c13 IS NOT NULL
UNION ALL SELECT CohortMonth, 14, c14 FROM retention_matrix_wide WHERE c14 IS NOT NULL
UNION ALL SELECT CohortMonth, 15, c15 FROM retention_matrix_wide WHERE c15 IS NOT NULL
UNION ALL SELECT CohortMonth, 16, c16 FROM retention_matrix_wide WHERE c16 IS NOT NULL
UNION ALL SELECT CohortMonth, 17, c17 FROM retention_matrix_wide WHERE c17 IS NOT NULL
UNION ALL SELECT CohortMonth, 18, c18 FROM retention_matrix_wide WHERE c18 IS NOT NULL
UNION ALL SELECT CohortMonth, 19, c19 FROM retention_matrix_wide WHERE c19 IS NOT NULL
UNION ALL SELECT CohortMonth, 20, c20 FROM retention_matrix_wide WHERE c20 IS NOT NULL
UNION ALL SELECT CohortMonth, 21, c21 FROM retention_matrix_wide WHERE c21 IS NOT NULL
UNION ALL SELECT CohortMonth, 22, c22 FROM retention_matrix_wide WHERE c22 IS NOT NULL
UNION ALL SELECT CohortMonth, 23, c23 FROM retention_matrix_wide WHERE c23 IS NOT NULL;

-- ============================================================
-- STEP 5: VALIDATION / CLEANLINESS CHECKS
-- ============================================================

-- 5.1 Row count check
SELECT COUNT(*) AS total_rows FROM retention_matrix_raw;

-- 5.2 Duplicate (CohortMonth, CohortIndex) pairs (should be 0 -- PK)
SELECT CohortMonth, CohortIndex, COUNT(*) AS cnt
FROM retention_matrix_raw
GROUP BY CohortMonth, CohortIndex
HAVING cnt > 1;

-- 5.3 CohortMonth format check (YYYY-MM)
SELECT DISTINCT CohortMonth
FROM retention_matrix_raw
WHERE CohortMonth NOT REGEXP '^[0-9]{4}-[0-9]{2}$';

-- 5.4 Negative customer counts (invalid data)
SELECT * FROM retention_matrix_raw WHERE CustomerCount < 0;

-- 5.5 CustomerCount should generally decrease (or stay flat) as
--     CohortIndex increases within the same cohort -- flag any
--     month-to-month INCREASE as suspicious
SELECT a.CohortMonth, a.CohortIndex, a.CustomerCount,
       b.CohortIndex AS prev_index, b.CustomerCount AS prev_count
FROM retention_matrix_raw a
JOIN retention_matrix_raw b
  ON a.CohortMonth = b.CohortMonth AND b.CohortIndex = a.CohortIndex - 1
WHERE a.CustomerCount > b.CustomerCount;

-- 5.6 CohortIndex should be within expected bounds (1-23 for this file)
SELECT * FROM retention_matrix_raw
WHERE CohortIndex < 1 OR CohortIndex > 23;

-- ============================================================
-- If all checks (5.2 - 5.6) return EMPTY results, the data is clean.
-- ============================================================
