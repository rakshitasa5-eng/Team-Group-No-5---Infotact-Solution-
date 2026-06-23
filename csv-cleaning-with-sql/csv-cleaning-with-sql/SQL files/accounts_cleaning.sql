USE csv_cleaning;

CREATE TABLE accounts (
  account_id VARCHAR(20),
  account_name VARCHAR(100),
  industry VARCHAR(50),
  country VARCHAR(50),
  signup_date DATE,
  referral_source VARCHAR(50),
  plan_tier VARCHAR(20),
  seats INT,
  is_trial VARCHAR(10),
  churn_flag VARCHAR(10),
  SignupMonth VARCHAR(20)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Cleaned_accounts.csv'
INTO TABLE accounts
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM accounts;

SELECT * FROM accounts LIMIT 10;

SELECT
  SUM(CASE WHEN account_id IS NULL THEN 1 ELSE 0 END) AS null_account_id,
  SUM(CASE WHEN account_name IS NULL THEN 1 ELSE 0 END) AS null_account_name,
  SUM(CASE WHEN industry IS NULL THEN 1 ELSE 0 END) AS null_industry,
  SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS null_country,
  SUM(CASE WHEN signup_date IS NULL THEN 1 ELSE 0 END) AS null_signup_date,
  SUM(CASE WHEN referral_source IS NULL THEN 1 ELSE 0 END) AS null_referral_source,
  SUM(CASE WHEN plan_tier IS NULL THEN 1 ELSE 0 END) AS null_plan_tier,
  SUM(CASE WHEN seats IS NULL THEN 1 ELSE 0 END) AS null_seats,
  SUM(CASE WHEN is_trial IS NULL THEN 1 ELSE 0 END) AS null_is_trial,
  SUM(CASE WHEN churn_flag IS NULL THEN 1 ELSE 0 END) AS null_churn_flag,
  SUM(CASE WHEN SignupMonth IS NULL THEN 1 ELSE 0 END) AS null_signup_month
FROM accounts;

SELECT account_id, COUNT(*) AS cnt
FROM accounts
GROUP BY account_id
HAVING COUNT(*) > 1;

SELECT * FROM accounts
WHERE TRIM(account_name) = ''
   OR TRIM(industry) = ''
   OR TRIM(country) = '';
   
SELECT * FROM accounts
WHERE seats <= 0;

SELECT DISTINCT industry FROM accounts ORDER BY industry;

SELECT DISTINCT country FROM accounts ORDER BY country;

SELECT DISTINCT plan_tier FROM accounts;

SELECT DISTINCT is_trial FROM accounts;

SELECT DISTINCT churn_flag FROM accounts;

SELECT DISTINCT referral_source FROM accounts;

SELECT DISTINCT SignupMonth FROM accounts ORDER BY SignupMonth;

SELECT DISTINCT is_trial FROM accounts;
SELECT DISTINCT churn_flag FROM accounts;

SELECT * FROM accounts
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/accounts_verified_clean.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';