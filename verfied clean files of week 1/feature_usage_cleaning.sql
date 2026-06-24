USE csv_cleaning;

CREATE TABLE feature_usage (
  usage_id VARCHAR(20),
  subscription_id VARCHAR(20),
  usage_date DATE,
  feature_name VARCHAR(50),
  usage_count INT,
  usage_duration_secs DECIMAL(10,2),
  error_count INT,
  is_beta_feature VARCHAR(10),
  UsageMonth VARCHAR(20)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cleaned_feature_usage.csv'
INTO TABLE feature_usage
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM feature_usage;

SELECT * FROM feature_usage LIMIT 10;

SELECT
  SUM(CASE WHEN usage_id IS NULL THEN 1 ELSE 0 END) AS null_usage_id,
  SUM(CASE WHEN subscription_id IS NULL THEN 1 ELSE 0 END) AS null_subscription_id,
  SUM(CASE WHEN usage_date IS NULL THEN 1 ELSE 0 END) AS null_usage_date,
  SUM(CASE WHEN feature_name IS NULL THEN 1 ELSE 0 END) AS null_feature_name,
  SUM(CASE WHEN usage_count IS NULL THEN 1 ELSE 0 END) AS null_usage_count,
  SUM(CASE WHEN usage_duration_secs IS NULL THEN 1 ELSE 0 END) AS null_duration,
  SUM(CASE WHEN error_count IS NULL THEN 1 ELSE 0 END) AS null_error_count,
  SUM(CASE WHEN is_beta_feature IS NULL THEN 1 ELSE 0 END) AS null_beta,
  SUM(CASE WHEN UsageMonth IS NULL THEN 1 ELSE 0 END) AS null_month
FROM feature_usage;

SELECT usage_id, COUNT(*) AS cnt
FROM feature_usage
GROUP BY usage_id
HAVING COUNT(*) > 1;

SELECT * FROM feature_usage
WHERE usage_count < 0
   OR usage_duration_secs < 0
   OR error_count < 0;
   
SELECT * FROM feature_usage
WHERE error_count > usage_count;

SELECT DISTINCT feature_name FROM feature_usage ORDER BY feature_name;

SELECT DISTINCT is_beta_feature FROM feature_usage;

SELECT MIN(usage_date) AS earliest, MAX(usage_date) AS latest
FROM feature_usage;

SELECT DISTINCT UsageMonth FROM feature_usage ORDER BY UsageMonth;

SELECT usage_id, COUNT(*) AS cnt
FROM feature_usage
GROUP BY usage_id
HAVING COUNT(*) > 1;

SELECT * FROM feature_usage
WHERE usage_id IN (
  SELECT usage_id FROM feature_usage
  GROUP BY usage_id
  HAVING COUNT(*) > 1
)
ORDER BY usage_id;

SELECT usage_id, subscription_id, usage_count, error_count
FROM feature_usage
WHERE error_count > usage_count;

SELECT
  SUM(CASE WHEN usage_id IS NULL THEN 1 ELSE 0 END) AS null_usage_id,
  SUM(CASE WHEN subscription_id IS NULL THEN 1 ELSE 0 END) AS null_subscription_id,
  SUM(CASE WHEN usage_date IS NULL THEN 1 ELSE 0 END) AS null_usage_date,
  SUM(CASE WHEN feature_name IS NULL THEN 1 ELSE 0 END) AS null_feature_name,
  SUM(CASE WHEN usage_count IS NULL THEN 1 ELSE 0 END) AS null_usage_count,
  SUM(CASE WHEN usage_duration_secs IS NULL THEN 1 ELSE 0 END) AS null_duration,
  SUM(CASE WHEN error_count IS NULL THEN 1 ELSE 0 END) AS null_error_count,
  SUM(CASE WHEN is_beta_feature IS NULL THEN 1 ELSE 0 END) AS null_beta,
  SUM(CASE WHEN UsageMonth IS NULL THEN 1 ELSE 0 END) AS null_month
FROM feature_usage;

SELECT DISTINCT feature_name FROM feature_usage ORDER BY feature_name;

SET SQL_SAFE_UPDATES = 0;

UPDATE feature_usage
SET error_count = usage_count
WHERE error_count > usage_count;

SELECT * FROM feature_usage
WHERE error_count > usage_count;

ALTER TABLE feature_usage ADD COLUMN temp_row_num INT;

SET @row_number = 0;
SET @current_id = '';

UPDATE feature_usage
SET temp_row_num = (
  @row_number := IF(@current_id = usage_id, @row_number + 1, 1),
  @current_id := usage_id
)
ORDER BY usage_id, usage_date;

SELECT temp_row_num FROM feature_usage LIMIT 5;

SET @row_number = 0;
SET @current_id = '';

UPDATE feature_usage
SET temp_row_num = IF(
  @current_id = usage_id,
  @row_number := @row_number + 1,
  (@current_id := usage_id) AND (@row_number := 1)
)
ORDER BY usage_id, usage_date;

SET @row_number = 0;
SET @current_id = '';

UPDATE feature_usage
SET temp_row_num = (
  CASE
    WHEN @current_id = usage_id THEN @row_number := @row_number + 1
    ELSE @row_number := 1
  END
)
WHERE (@current_id := IF(@current_id = usage_id, @current_id, usage_id)) IS NOT NULL
ORDER BY usage_id, usage_date;

UPDATE feature_usage f
JOIN (
  SELECT usage_id, usage_date,
         ROW_NUMBER() OVER (PARTITION BY usage_id ORDER BY usage_date) AS rn
  FROM feature_usage
) ranked
ON f.usage_id = ranked.usage_id AND f.usage_date = ranked.usage_date
SET f.temp_row_num = ranked.rn;

SELECT usage_id, usage_date, temp_row_num
FROM feature_usage
WHERE usage_id IN (
  SELECT usage_id FROM feature_usage
  GROUP BY usage_id
  HAVING COUNT(*) > 1
)
ORDER BY usage_id, usage_date;

UPDATE feature_usage
SET usage_id = CONCAT(usage_id, '-dup', temp_row_num - 1)
WHERE temp_row_num > 1;

ALTER TABLE feature_usage DROP COLUMN temp_row_num;

SELECT usage_id, COUNT(*) AS cnt
FROM feature_usage
GROUP BY usage_id
HAVING COUNT(*) > 1;

SELECT * FROM feature_usage
WHERE error_count > usage_count;

SELECT * FROM feature_usage
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/feature_usage_verified_clean.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';