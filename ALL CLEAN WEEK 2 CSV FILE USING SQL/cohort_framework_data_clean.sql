-- ============================================================
-- cohort_framework_data_clean.sql
-- Project   : Cohort Retention Analysis
-- Internship: Infotact Solutions
-- Purpose   : Load cohort_framework_data.csv into MySQL and run
--             data-quality / cleanliness checks on it.
-- Author    : <your name>
-- ============================================================

-- STEP 1: Create database
CREATE DATABASE IF NOT EXISTS cohort_check;
USE cohort_check;

-- ============================================================
-- STEP 2: Create the table manually.
--
-- NOTE: The original CSV has TWO columns that only differ by case:
--   "cohortMonth"  and  "CohortMonth"
-- On Windows, MySQL table/column names are case-INSENSITIVE,
-- so importing both as-is will cause a column collision error.
-- Below, we rename them to clearly different names:
--   cohortMonth  ->  cohort_month_signup   (the original lowercase one)
--   CohortMonth  ->  cohort_month_actual   (the original capitalized one)
-- ============================================================
DROP TABLE IF EXISTS subs_full;
CREATE TABLE subs_full (
    subscription_id      VARCHAR(20),
    account_id            VARCHAR(20),
    start_date            DATE,
    end_date              DATE NULL,
    plan_tier             VARCHAR(20),
    seats                 INT,
    mrr_amount            DECIMAL(10,2),
    arr_amount            DECIMAL(10,2),
    is_trial              VARCHAR(10),
    upgrade_flag          VARCHAR(10),
    downgrade_flag        VARCHAR(10),
    churn_flag            VARCHAR(10),
    billing_frequency     VARCHAR(20),
    auto_renew_flag       VARCHAR(10),
    cohort_month_signup   VARCHAR(7),   -- was "cohortMonth"
    account_name          VARCHAR(50),
    industry              VARCHAR(50),
    country               VARCHAR(10),
    signup_date           DATE,
    referral_source       VARCHAR(30),
    SignupMonth           VARCHAR(7),
    cohort_month_actual   VARCHAR(7),   -- was "CohortMonth"
    SubscriptionMonth     VARCHAR(7),
    CohortIndex           INT
);

-- ============================================================
-- STEP 3: Import the CSV data.
--
-- >>> DO THIS PART IN WORKBENCH:
--   1. Run STEP 1 and STEP 2 above first (creates the table).
--   2. Navigator -> Schemas -> cohort_check -> Tables ->
--      right-click "subs_full" -> Table Data Import Wizard.
--   3. Browse to cohort_framework_data__1_.csv
--   4. IMPORTANT: When it shows the column mapping screen, make sure:
--        CSV column "cohortMonth"  maps to table column "cohort_month_signup"
--        CSV column "CohortMonth"  maps to table column "cohort_month_actual"
--      (the wizard may show both as duplicate headers -- map manually
--       if it asks you to choose).
--   5. Finish the import.
-- ============================================================

-- STEP 3b: Verify import worked (should show 5000)
SELECT COUNT(*) AS total_rows FROM subs_full;

-- ============================================================
-- STEP 4: DATA-QUALITY / CLEANLINESS CHECKS
-- ============================================================

-- 4.1 Duplicate subscription_id (should be unique -> expect 0 rows)
SELECT subscription_id, COUNT(*) AS cnt
FROM subs_full
GROUP BY subscription_id
HAVING cnt > 1;

-- 4.2 Missing values in critical fields
SELECT
    SUM(subscription_id IS NULL OR subscription_id = '') AS missing_sub_id,
    SUM(account_id IS NULL OR account_id = '')            AS missing_account,
    SUM(start_date IS NULL)                               AS missing_start_date,
    SUM(mrr_amount IS NULL)                                AS missing_mrr,
    SUM(plan_tier IS NULL OR plan_tier = '')               AS missing_plan_tier
FROM subs_full;

-- 4.3 Logical date check: end_date should never be before start_date
SELECT * FROM subs_full
WHERE end_date IS NOT NULL AND end_date < start_date;

-- 4.4 Logical date check: signup_date should not be after start_date
SELECT * FROM subs_full
WHERE signup_date > start_date;

-- 4.5 Negative or zero values where they shouldn't exist
SELECT * FROM subs_full WHERE seats <= 0;
SELECT * FROM subs_full WHERE mrr_amount < 0;
SELECT * FROM subs_full WHERE arr_amount < 0;

-- 4.6 Check valid categorical values (look for typos / inconsistent casing)
SELECT DISTINCT plan_tier         FROM subs_full;
SELECT DISTINCT billing_frequency FROM subs_full;
SELECT DISTINCT country           FROM subs_full;
SELECT DISTINCT industry          FROM subs_full;
SELECT DISTINCT referral_source   FROM subs_full;

-- 4.7 Check boolean-like flag columns only contain True/False
SELECT DISTINCT is_trial       FROM subs_full;
SELECT DISTINCT upgrade_flag   FROM subs_full;
SELECT DISTINCT downgrade_flag FROM subs_full;
SELECT DISTINCT churn_flag     FROM subs_full;
SELECT DISTINCT auto_renew_flag FROM subs_full;

-- 4.8 churn_flag consistency: if churned (True), end_date should NOT be null
SELECT * FROM subs_full WHERE churn_flag = 'True' AND end_date IS NULL;

-- 4.9 churn_flag consistency: if NOT churned (False), end_date SHOULD be null
SELECT * FROM subs_full WHERE churn_flag = 'False' AND end_date IS NOT NULL;

-- 4.10 mrr_amount vs arr_amount consistency (arr should roughly = mrr * 12)
SELECT *, (mrr_amount * 12) AS expected_arr
FROM subs_full
WHERE ABS(arr_amount - (mrr_amount * 12)) > 1
  AND is_trial = 'False';

-- 4.11 CohortIndex should never be negative
SELECT * FROM subs_full WHERE CohortIndex < 0;

-- 4.12 cohort_month_actual should always be <= SubscriptionMonth
--      (you can't appear in a cohort's retention before you signed up)
SELECT * FROM subs_full
WHERE cohort_month_actual > SubscriptionMonth;

-- ============================================================
-- If all checks above (4.1, 4.3, 4.4, 4.5, 4.8, 4.9, 4.11, 4.12)
-- return EMPTY results, and the DISTINCT checks (4.6, 4.7) only
-- show expected clean values, the dataset is clean.
-- ============================================================
