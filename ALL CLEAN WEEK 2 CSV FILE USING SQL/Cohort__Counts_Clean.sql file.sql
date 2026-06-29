-- ============================================================
-- cohort_counts_clean.sql
-- Purpose: Load cohort_counts.csv into MySQL in normalized form
--          and run data-quality / cleanliness checks on it.
-- Author: <your name>
-- ============================================================

-- STEP 1: Create database
CREATE DATABASE IF NOT EXISTS cohort_check;
USE cohort_check;

-- ============================================================
-- STEP 2: Create the STAGING table (wide format, same shape as CSV)
-- This was MISSING before -- that's why you got:
--   Error Code: 1146. Table 'cohort_check.cohort_counts_wide' doesn't exist
-- ============================================================
DROP TABLE IF EXISTS cohort_counts_wide;
CREATE TABLE cohort_counts_wide (
    CohortMonth VARCHAR(7),
    c0  DECIMAL(10,2), c1  DECIMAL(10,2), c2  DECIMAL(10,2), c3  DECIMAL(10,2),
    c4  DECIMAL(10,2), c5  DECIMAL(10,2), c6  DECIMAL(10,2), c7  DECIMAL(10,2),
    c8  DECIMAL(10,2), c9  DECIMAL(10,2), c10 DECIMAL(10,2), c11 DECIMAL(10,2),
    c12 DECIMAL(10,2), c13 DECIMAL(10,2), c14 DECIMAL(10,2), c15 DECIMAL(10,2),
    c16 DECIMAL(10,2), c17 DECIMAL(10,2), c18 DECIMAL(10,2), c19 DECIMAL(10,2),
    c20 DECIMAL(10,2), c21 DECIMAL(10,2), c22 DECIMAL(10,2)
);

-- ============================================================
-- STEP 3: Load the CSV data into cohort_counts_wide.
--
-- >>> DO THIS PART MANUALLY IN WORKBENCH (the table now exists, so
--     the import wizard will work without errors):
--
--   1. Run everything ABOVE this line first (creates the table).
--   2. In the Navigator -> Schemas -> cohort_check -> Tables,
--      right-click "cohort_counts_wide" -> Table Data Import Wizard.
--   3. Browse to cohort_counts.csv and import INTO this existing table
--      (it will now map CSV columns 0,1,2... to c0,c1,c2... automatically
--      if you match the column order, or let the wizard auto-map).
--   4. After import finishes, continue running the script BELOW this line.
--
-- Alternative (no wizard, fully automatic) -- uncomment and edit path:
--
-- LOAD DATA INFILE 'C:/Users/YourName/Downloads/cohort_counts.csv'
-- INTO TABLE cohort_counts_wide
-- FIELDS TERMINATED BY ','
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS
-- (CohortMonth, c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10,
--  c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22);
--
-- NOTE: LOAD DATA INFILE needs secure_file_priv permissions and the
-- file usually must sit in MySQL's secure upload folder. The Import
-- Wizard (steps 1-4 above) is easier on Windows and avoids this.
-- ============================================================

-- STEP 3b: Verify the staging table actually has data before continuing
SELECT COUNT(*) AS staging_row_count FROM cohort_counts_wide;
-- ^ If this returns 0, STOP -- the import did not work. Re-do Step 3.

-- ============================================================
-- STEP 4: Create the NORMALIZED (long-format) table
-- ============================================================
DROP TABLE IF EXISTS cohort_counts_raw;
CREATE TABLE cohort_counts_raw (
    CohortMonth   VARCHAR(7)   NOT NULL,
    CohortIndex   INT          NOT NULL,
    CustomerCount INT          NULL,
    PRIMARY KEY (CohortMonth, CohortIndex)
);

-- Convert wide -> long
INSERT INTO cohort_counts_raw (CohortMonth, CohortIndex, CustomerCount)
SELECT CohortMonth, 0, c0 FROM cohort_counts_wide WHERE c0 IS NOT NULL
UNION ALL SELECT CohortMonth, 1, c1 FROM cohort_counts_wide WHERE c1 IS NOT NULL
UNION ALL SELECT CohortMonth, 2, c2 FROM cohort_counts_wide WHERE c2 IS NOT NULL
UNION ALL SELECT CohortMonth, 3, c3 FROM cohort_counts_wide WHERE c3 IS NOT NULL
UNION ALL SELECT CohortMonth, 4, c4 FROM cohort_counts_wide WHERE c4 IS NOT NULL
UNION ALL SELECT CohortMonth, 5, c5 FROM cohort_counts_wide WHERE c5 IS NOT NULL
UNION ALL SELECT CohortMonth, 6, c6 FROM cohort_counts_wide WHERE c6 IS NOT NULL
UNION ALL SELECT CohortMonth, 7, c7 FROM cohort_counts_wide WHERE c7 IS NOT NULL
UNION ALL SELECT CohortMonth, 8, c8 FROM cohort_counts_wide WHERE c8 IS NOT NULL
UNION ALL SELECT CohortMonth, 9, c9 FROM cohort_counts_wide WHERE c9 IS NOT NULL
UNION ALL SELECT CohortMonth, 10, c10 FROM cohort_counts_wide WHERE c10 IS NOT NULL
UNION ALL SELECT CohortMonth, 11, c11 FROM cohort_counts_wide WHERE c11 IS NOT NULL
UNION ALL SELECT CohortMonth, 12, c12 FROM cohort_counts_wide WHERE c12 IS NOT NULL
UNION ALL SELECT CohortMonth, 13, c13 FROM cohort_counts_wide WHERE c13 IS NOT NULL
UNION ALL SELECT CohortMonth, 14, c14 FROM cohort_counts_wide WHERE c14 IS NOT NULL
UNION ALL SELECT CohortMonth, 15, c15 FROM cohort_counts_wide WHERE c15 IS NOT NULL
UNION ALL SELECT CohortMonth, 16, c16 FROM cohort_counts_wide WHERE c16 IS NOT NULL
UNION ALL SELECT CohortMonth, 17, c17 FROM cohort_counts_wide WHERE c17 IS NOT NULL
UNION ALL SELECT CohortMonth, 18, c18 FROM cohort_counts_wide WHERE c18 IS NOT NULL
UNION ALL SELECT CohortMonth, 19, c19 FROM cohort_counts_wide WHERE c19 IS NOT NULL
UNION ALL SELECT CohortMonth, 20, c20 FROM cohort_counts_wide WHERE c20 IS NOT NULL
UNION ALL SELECT CohortMonth, 21, c21 FROM cohort_counts_wide WHERE c21 IS NOT NULL
UNION ALL SELECT CohortMonth, 22, c22 FROM cohort_counts_wide WHERE c22 IS NOT NULL;

-- ============================================================
-- STEP 5: VALIDATION / CLEANLINESS CHECKS
-- ============================================================

-- 5.1 Row count check
SELECT COUNT(*) AS total_rows FROM cohort_counts_raw;

-- 5.2 Check for duplicate (CohortMonth, CohortIndex) pairs
--     (Should return 0 rows since it's the primary key)
SELECT CohortMonth, CohortIndex, COUNT(*) AS cnt
FROM cohort_counts_raw
GROUP BY CohortMonth, CohortIndex
HAVING cnt > 1;

-- 5.3 Check CohortMonth format is valid (YYYY-MM)
SELECT DISTINCT CohortMonth
FROM cohort_counts_raw
WHERE CohortMonth NOT REGEXP '^[0-9]{4}-[0-9]{2}$';

-- 5.4 Check for negative or zero customer counts (invalid data)
SELECT * FROM cohort_counts_raw WHERE CustomerCount <= 0;

-- 5.5 Check CohortIndex 0 always has the highest count per cohort
--     (Month 0 = cohort size; counts should not increase later,
--      since this is retention data -- flags suspicious data)
SELECT a.CohortMonth, a.CohortIndex, a.CustomerCount, base.CustomerCount AS month0_count
FROM cohort_counts_raw a
JOIN cohort_counts_raw base
  ON a.CohortMonth = base.CohortMonth AND base.CohortIndex = 0
WHERE a.CustomerCount > base.CustomerCount;

-- 5.6 Check every cohort month has a CohortIndex = 0 entry
SELECT DISTINCT CohortMonth
FROM cohort_counts_raw
WHERE CohortMonth NOT IN (
    SELECT CohortMonth FROM cohort_counts_raw WHERE CohortIndex = 0
);

-- 5.7 Check CohortIndex range is within expected bounds (0-22)
SELECT * FROM cohort_counts_raw WHERE CohortIndex < 0 OR CohortIndex > 22;

-- ============================================================
-- If all the above checks (5.2 - 5.7) return EMPTY results,
-- the data is clean.
-- ============================================================
