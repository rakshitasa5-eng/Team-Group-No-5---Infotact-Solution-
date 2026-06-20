DROP TABLE ravenstack_subscriptions;

CREATE TABLE ravenstack_subscriptions (
  subscription_id VARCHAR(20),
  account_id VARCHAR(20),
  start_date VARCHAR(20),
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
  cohortMonth VARCHAR(20),
  SubscriptionMonth VARCHAR(20)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cleaned_ravenstack_subscriptions.csv'
INTO TABLE ravenstack_subscriptions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

UPDATE ravenstack_subscriptions
SET end_date = NULL
WHERE end_date = 'null';

ALTER TABLE ravenstack_subscriptions ADD COLUMN start_date_fixed DATE;

ALTER TABLE ravenstack_subscriptions ADD COLUMN end_date_fixed DATE;

UPDATE ravenstack_subscriptions
SET start_date_fixed = STR_TO_DATE(start_date, '%d-%m-%Y');

UPDATE ravenstack_subscriptions
SET end_date_fixed = STR_TO_DATE(end_date, '%d-%m-%Y')
WHERE end_date IS NOT NULL;

SELECT subscription_id, start_date, start_date_fixed, end_date, end_date_fixed
FROM ravenstack_subscriptions LIMIT 10;

ALTER TABLE ravenstack_subscriptions DROP COLUMN start_date;
ALTER TABLE ravenstack_subscriptions DROP COLUMN end_date;
ALTER TABLE ravenstack_subscriptions CHANGE start_date_fixed start_date DATE;
ALTER TABLE ravenstack_subscriptions CHANGE end_date_fixed end_date DATE;

SELECT subscription_id, start_date, end_date FROM ravenstack_subscriptions LIMIT 10;

DESCRIBE ravenstack_subscriptions;

SELECT COUNT(*) FROM ravenstack_subscriptions;

SELECT
  SUM(CASE WHEN subscription_id IS NULL THEN 1 ELSE 0 END) AS null_sub_id,
  SUM(CASE WHEN account_id IS NULL THEN 1 ELSE 0 END) AS null_account_id,
  SUM(CASE WHEN start_date IS NULL THEN 1 ELSE 0 END) AS null_start_date,
  SUM(CASE WHEN plan_tier IS NULL THEN 1 ELSE 0 END) AS null_plan_tier,
  SUM(CASE WHEN seats IS NULL THEN 1 ELSE 0 END) AS null_seats,
  SUM(CASE WHEN mrr_amount IS NULL THEN 1 ELSE 0 END) AS null_mrr,
  SUM(CASE WHEN arr_amount IS NULL THEN 1 ELSE 0 END) AS null_arr,
  SUM(CASE WHEN billing_frequency IS NULL THEN 1 ELSE 0 END) AS null_billing_freq
FROM ravenstack_subscriptions;

SELECT subscription_id, COUNT(*) AS cnt
FROM ravenstack_subscriptions
GROUP BY subscription_id
HAVING COUNT(*) > 1;

SELECT rs.account_id
FROM ravenstack_subscriptions rs
LEFT JOIN accounts a ON rs.account_id = a.account_id
WHERE a.account_id IS NULL;

SELECT * FROM ravenstack_subscriptions
WHERE end_date < start_date;

SELECT * FROM ravenstack_subscriptions
WHERE seats < 0 OR mrr_amount < 0 OR arr_amount < 0;

SELECT subscription_id, mrr_amount, arr_amount, (mrr_amount * 12) AS expected_arr
FROM ravenstack_subscriptions
WHERE ABS(arr_amount - (mrr_amount * 12)) > 1
LIMIT 20;

SELECT DISTINCT plan_tier FROM ravenstack_subscriptions;

SELECT DISTINCT billing_frequency FROM ravenstack_subscriptions;

SELECT DISTINCT is_trial, upgrade_flag, downgrade_flag, churn_flag, auto_renew_flag
FROM ravenstack_subscriptions
LIMIT 20;

SELECT * FROM ravenstack_subscriptions
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ravenstack_subscriptions_verified_clean.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';