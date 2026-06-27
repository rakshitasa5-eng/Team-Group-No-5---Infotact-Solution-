-- ============================================================
-- high_value_customers_clean.sql
-- Project   : Cohort Retention Analysis
-- Internship: Infotact Solutions
-- Purpose   : Load high_value_customers.csv into MySQL and run
--             data-quality / cleanliness checks on it.
-- Author    : <your name>
-- ============================================================

-- STEP 1: Create database
CREATE DATABASE IF NOT EXISTS cohort_check;
USE cohort_check;

-- ============================================================
-- STEP 2: Create the table
-- ============================================================
DROP TABLE IF EXISTS high_value_customers;
CREATE TABLE high_value_customers (
    account_id        VARCHAR(20)   NOT NULL,
    AverageRevenue    DECIMAL(12,4),
    PurchaseFrequency INT,
    PlanTier          VARCHAR(20),
    CLTV              DECIMAL(14,2),
    PRIMARY KEY (account_id)
);

-- ============================================================
-- STEP 3: Import the CSV.
--
-- >>> IN WORKBENCH:
--   1. Run STEP 1 and STEP 2 above first (creates the table).
--   2. Navigator -> Schemas -> cohort_check -> Tables ->
--      right-click "high_value_customers" -> Table Data Import Wizard.
--   3. Browse to high_value_customers.csv and import (comma-delimited,
--      standard format -- this file is straightforward).
-- ============================================================

-- STEP 3b: Verify import worked (should show 20 rows)
SELECT COUNT(*) AS total_rows FROM high_value_customers;

-- ============================================================
-- STEP 4: DATA-QUALITY / CLEANLINESS CHECKS
-- ============================================================

-- 4.1 Duplicate account_id (should be 0 rows -- it's the primary key,
--     but check anyway in case the import allowed duplicates)
SELECT account_id, COUNT(*) AS cnt
FROM high_value_customers
GROUP BY account_id
HAVING cnt > 1;

-- 4.2 Missing values in any column
SELECT
    SUM(account_id IS NULL OR account_id = '')   AS missing_account,
    SUM(AverageRevenue IS NULL)                  AS missing_avg_revenue,
    SUM(PurchaseFrequency IS NULL)                AS missing_purchase_freq,
    SUM(PlanTier IS NULL OR PlanTier = '')        AS missing_plan_tier,
    SUM(CLTV IS NULL)                              AS missing_cltv
FROM high_value_customers;

-- 4.3 Negative or zero values where they shouldn't exist
SELECT * FROM high_value_customers
WHERE AverageRevenue <= 0 OR PurchaseFrequency <= 0 OR CLTV <= 0;

-- 4.4 Check valid PlanTier categories (look for typos/inconsistent casing)
SELECT DISTINCT PlanTier FROM high_value_customers;

-- 4.5 CLTV math consistency check
--     CLTV here = AverageRevenue x PurchaseFrequency
--     (flag any row where it doesn't match within a small tolerance)
SELECT *,
       ROUND(AverageRevenue * PurchaseFrequency, 2) AS expected_cltv
FROM high_value_customers
WHERE ABS(CLTV - (AverageRevenue * PurchaseFrequency)) > 1;

-- 4.6 Check this table is genuinely "high value" -- i.e. no
--     surprisingly low CLTV values that shouldn't be in a top-customers list
SELECT * FROM high_value_customers
ORDER BY CLTV ASC
LIMIT 5;

-- ============================================================
-- If checks 4.1, 4.2, 4.3, and 4.5 return EMPTY results, and
-- 4.4 only shows expected plan tiers (e.g. Pro, Enterprise),
-- the data is clean.
-- ============================================================
