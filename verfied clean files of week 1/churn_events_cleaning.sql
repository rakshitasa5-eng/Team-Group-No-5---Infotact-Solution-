USE csv_cleaning;

CREATE TABLE churn_events (
  churn_event_id VARCHAR(20),
  account_id VARCHAR(20),
  churn_date DATE,
  reason_code VARCHAR(50),
  refund_amount_usd DECIMAL(10,2),
  preceding_upgrade_flag VARCHAR(10),
  preceding_downgrade_flag VARCHAR(10),
  is_reactivation VARCHAR(10),
  feedback_text TEXT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cleaned_churn_events.csv'
INTO TABLE churn_events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM churn_events;

SELECT * FROM churn_events LIMIT 10;

SELECT
  SUM(CASE WHEN churn_event_id IS NULL THEN 1 ELSE 0 END) AS null_churn_event_id,
  SUM(CASE WHEN account_id IS NULL THEN 1 ELSE 0 END) AS null_account_id,
  SUM(CASE WHEN churn_date IS NULL THEN 1 ELSE 0 END) AS null_churn_date,
  SUM(CASE WHEN reason_code IS NULL THEN 1 ELSE 0 END) AS null_reason_code,
  SUM(CASE WHEN refund_amount_usd IS NULL THEN 1 ELSE 0 END) AS null_refund_amount,
  SUM(CASE WHEN preceding_upgrade_flag IS NULL THEN 1 ELSE 0 END) AS null_upgrade_flag,
  SUM(CASE WHEN preceding_downgrade_flag IS NULL THEN 1 ELSE 0 END) AS null_downgrade_flag,
  SUM(CASE WHEN is_reactivation IS NULL THEN 1 ELSE 0 END) AS null_reactivation,
  SUM(CASE WHEN feedback_text IS NULL THEN 1 ELSE 0 END) AS null_feedback
FROM churn_events;

SELECT churn_event_id, COUNT(*) AS cnt
FROM churn_events
GROUP BY churn_event_id
HAVING COUNT(*) > 1;

SELECT ce.account_id
FROM churn_events ce
LEFT JOIN accounts a ON ce.account_id = a.account_id
WHERE a.account_id IS NULL;

SELECT * FROM churn_events
WHERE refund_amount_usd < 0;

SELECT DISTINCT reason_code FROM churn_events ORDER BY reason_code;

SELECT DISTINCT preceding_upgrade_flag FROM churn_events;

SELECT DISTINCT preceding_downgrade_flag FROM churn_events;

SELECT DISTINCT is_reactivation FROM churn_events;

SELECT * FROM churn_events
WHERE preceding_upgrade_flag = preceding_downgrade_flag
  AND preceding_upgrade_flag NOT IN ('No', 'no', '0', 'FALSE', 'false');
  
SELECT MIN(churn_date) AS earliest, MAX(churn_date) AS latest
FROM churn_events;

SELECT DISTINCT preceding_upgrade_flag FROM churn_events;
SELECT DISTINCT preceding_downgrade_flag FROM churn_events;

SELECT churn_event_id, account_id, preceding_upgrade_flag, preceding_downgrade_flag
FROM churn_events
WHERE preceding_upgrade_flag = preceding_downgrade_flag
  AND preceding_upgrade_flag NOT IN ('No', 'no', '0', 'FALSE', 'false');
  
SELECT
  SUM(CASE WHEN churn_event_id IS NULL THEN 1 ELSE 0 END) AS null_churn_event_id,
  SUM(CASE WHEN account_id IS NULL THEN 1 ELSE 0 END) AS null_account_id,
  SUM(CASE WHEN churn_date IS NULL THEN 1 ELSE 0 END) AS null_churn_date,
  SUM(CASE WHEN reason_code IS NULL THEN 1 ELSE 0 END) AS null_reason_code,
  SUM(CASE WHEN refund_amount_usd IS NULL THEN 1 ELSE 0 END) AS null_refund_amount,
  SUM(CASE WHEN preceding_upgrade_flag IS NULL THEN 1 ELSE 0 END) AS null_upgrade_flag,
  SUM(CASE WHEN preceding_downgrade_flag IS NULL THEN 1 ELSE 0 END) AS null_downgrade_flag,
  SUM(CASE WHEN is_reactivation IS NULL THEN 1 ELSE 0 END) AS null_reactivation,
  SUM(CASE WHEN feedback_text IS NULL THEN 1 ELSE 0 END) AS null_feedback
FROM churn_events;

SELECT DISTINCT reason_code FROM churn_events ORDER BY reason_code;

SELECT * FROM churn_events
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/churn_events_verified_clean.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';