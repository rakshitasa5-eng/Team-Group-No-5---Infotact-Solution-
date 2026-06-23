SHOW VARIABLES LIKE 'secure_file_priv';
USE csv_cleaning;


USE csv_cleaning;

CREATE TABLE tickets (
  ticket_id VARCHAR(20),
  account_id VARCHAR(20),
  submitted_at DATETIME,
  closed_at DATETIME,
  resolution_time_hours DECIMAL(10,2),
  priority VARCHAR(20),
  first_response_time_minutes DECIMAL(10,2),
  satisfaction_score DECIMAL(5,2),
  escalation_flag VARCHAR(10),
  TicketMonth VARCHAR(20)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/tickets.csv'
INTO TABLE tickets
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM tickets;

SELECT
  SUM(CASE WHEN ticket_id IS NULL THEN 1 ELSE 0 END) AS null_ticket_id,
  SUM(CASE WHEN account_id IS NULL THEN 1 ELSE 0 END) AS null_account_id,
  SUM(CASE WHEN submitted_at IS NULL THEN 1 ELSE 0 END) AS null_submitted_at,
  SUM(CASE WHEN closed_at IS NULL THEN 1 ELSE 0 END) AS null_closed_at,
  SUM(CASE WHEN resolution_time_hours IS NULL THEN 1 ELSE 0 END) AS null_resolution_time,
  SUM(CASE WHEN priority IS NULL THEN 1 ELSE 0 END) AS null_priority,
  SUM(CASE WHEN first_response_time_minutes IS NULL THEN 1 ELSE 0 END) AS null_first_response,
  SUM(CASE WHEN satisfaction_score IS NULL THEN 1 ELSE 0 END) AS null_satisfaction,
  SUM(CASE WHEN escalation_flag IS NULL THEN 1 ELSE 0 END) AS null_escalation,
  SUM(CASE WHEN TicketMonth IS NULL THEN 1 ELSE 0 END) AS null_month
FROM tickets;

SELECT ticket_id, COUNT(*) AS cnt
FROM tickets
GROUP BY ticket_id
HAVING COUNT(*) > 1;

SELECT * FROM tickets
WHERE closed_at < submitted_at;

SELECT * FROM tickets
WHERE resolution_time_hours < 0
   OR first_response_time_minutes < 0;
   
   
SELECT DISTINCT satisfaction_score FROM tickets ORDER BY satisfaction_score;

SELECT DISTINCT priority FROM tickets;

SELECT DISTINCT escalation_flag FROM tickets;

SELECT DISTINCT TicketMonth FROM tickets;

SELECT
  SUM(CASE WHEN ticket_id IS NULL THEN 1 ELSE 0 END) AS null_ticket_id,
  SUM(CASE WHEN account_id IS NULL THEN 1 ELSE 0 END) AS null_account_id,
  SUM(CASE WHEN submitted_at IS NULL THEN 1 ELSE 0 END) AS null_submitted_at,
  SUM(CASE WHEN closed_at IS NULL THEN 1 ELSE 0 END) AS null_closed_at,
  SUM(CASE WHEN resolution_time_hours IS NULL THEN 1 ELSE 0 END) AS null_resolution_time,
  SUM(CASE WHEN priority IS NULL THEN 1 ELSE 0 END) AS null_priority,
  SUM(CASE WHEN first_response_time_minutes IS NULL THEN 1 ELSE 0 END) AS null_first_response,
  SUM(CASE WHEN satisfaction_score IS NULL THEN 1 ELSE 0 END) AS null_satisfaction,
  SUM(CASE WHEN escalation_flag IS NULL THEN 1 ELSE 0 END) AS null_escalation,
  SUM(CASE WHEN TicketMonth IS NULL THEN 1 ELSE 0 END) AS null_month
FROM tickets;

SELECT DISTINCT satisfaction_score FROM tickets ORDER BY satisfaction_score;

SELECT DISTINCT priority FROM tickets;

SELECT
  SUM(CASE WHEN ticket_id IS NULL THEN 1 ELSE 0 END) AS null_ticket_id,
  SUM(CASE WHEN account_id IS NULL THEN 1 ELSE 0 END) AS null_account_id,
  SUM(CASE WHEN submitted_at IS NULL THEN 1 ELSE 0 END) AS null_submitted_at,
  SUM(CASE WHEN closed_at IS NULL THEN 1 ELSE 0 END) AS null_closed_at,
  SUM(CASE WHEN resolution_time_hours IS NULL THEN 1 ELSE 0 END) AS null_resolution_time,
  SUM(CASE WHEN priority IS NULL THEN 1 ELSE 0 END) AS null_priority,
  SUM(CASE WHEN first_response_time_minutes IS NULL THEN 1 ELSE 0 END) AS null_first_response,
  SUM(CASE WHEN satisfaction_score IS NULL THEN 1 ELSE 0 END) AS null_satisfaction,
  SUM(CASE WHEN escalation_flag IS NULL THEN 1 ELSE 0 END) AS null_escalation,
  SUM(CASE WHEN TicketMonth IS NULL THEN 1 ELSE 0 END) AS null_month
FROM tickets;

SELECT DISTINCT satisfaction_score FROM tickets ORDER BY satisfaction_score;

SELECT * FROM tickets
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/tickets_verified_clean.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';