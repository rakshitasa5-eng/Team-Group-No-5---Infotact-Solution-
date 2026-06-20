DROP TABLE subscriptions;

CREATE TABLE subscriptions (
  subscription_id VARCHAR(20),
  account_id VARCHAR(20),
  start_date DATE,
  end_date VARCHAR(20),
  plan_tier VARCHAR(20),
  seats INT,
  mrr_amount DECIMAL(10,2),
  arr_amount DECIMAL(10,2),
  is_trial VARCHAR(10),
  upgrade_flag VARCHAR(10),
  downgrade_flag VARCHAR(10),
  churn_flag VARCHAR(10),
  billing_frequency VARCHAR(20),
  auto_renew_flag VARCHAR(10),
  cohortMonth VARCHAR(20)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cleaned_subscriptions.csv'
INTO TABLE subscriptions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SET SQL_SAFE_UPDATES = 0;

UPDATE subscriptions
SET end_date = NULL
WHERE end_date = '';

ALTER TABLE subscriptions ADD COLUMN end_date_fixed DATE;

UPDATE subscriptions
SET end_date_fixed = end_date
WHERE end_date IS NOT NULL;

ALTER TABLE subscriptions DROP COLUMN end_date;

ALTER TABLE subscriptions CHANGE end_date_fixed end_date DATE;

SELECT subscription_id, start_date, end_date FROM subscriptions LIMIT 10;

SELECT COUNT(*) FROM subscriptions;

SELECT
  SUM(CASE WHEN subscription_id IS NULL THEN 1 ELSE 0 END) AS null_sub_id,
  SUM(CASE WHEN account_id IS NULL THEN 1 ELSE 0 END) AS null_account_id,
  SUM(CASE WHEN start_date IS NULL THEN 1 ELSE 0 END) AS null_start_date,
  SUM(CASE WHEN plan_tier IS NULL THEN 1 ELSE 0 END) AS null_plan_tier,
  SUM(CASE WHEN seats IS NULL THEN 1 ELSE 0 END) AS null_seats,
  SUM(CASE WHEN mrr_amount IS NULL THEN 1 ELSE 0 END) AS null_mrr,
  SUM(CASE WHEN arr_amount IS NULL THEN 1 ELSE 0 END) AS null_arr,
  SUM(CASE WHEN billing_frequency IS NULL THEN 1 ELSE 0 END) AS null_billing_freq
FROM subscriptions;

SELECT subscription_id, COUNT(*) AS cnt
FROM subscriptions
GROUP BY subscription_id
HAVING COUNT(*) > 1;

SELECT s.account_id
FROM subscriptions s
LEFT JOIN accounts a ON s.account_id = a.account_id
WHERE a.account_id IS NULL;

SELECT * FROM subscriptions
WHERE end_date < start_date;

SELECT * FROM subscriptions
WHERE seats < 0 OR mrr_amount < 0 OR arr_amount < 0;

SELECT subscription_id, mrr_amount, arr_amount, (mrr_amount * 12) AS expected_arr
FROM subscriptions
WHERE ABS(arr_amount - (mrr_amount * 12)) > 1
LIMIT 20;

SELECT DISTINCT plan_tier FROM subscriptions;

SELECT DISTINCT billing_frequency FROM subscriptions;

SELECT COUNT(*) AS overlapping_ids
FROM subscriptions s
INNER JOIN ravenstack_subscriptions r ON s.subscription_id = r.subscription_id;

SELECT * FROM subscriptions
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/subscriptions_verified_clean.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';