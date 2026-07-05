# Team Project

# SaaS/E-Commerce Cohort Retention & CLTV Analysis

## Week 1: Transactional Data Cleaning and Wrangling

### Project Overview

The objective of this project is to analyze customer retention patterns and calculate Customer Lifetime Value (CLTV) using RavenStack SaaS data. The project aims to identify customer churn behavior, understand retention trends, and generate actionable business insights to improve customer engagement and profitability.

---

## Datasets Used

The project utilizes the following RavenStack SaaS datasets:

1. **ravenstack_subscriptions.csv** – Subscription and revenue data
2. **ravenstack_accounts.csv** – Customer account information
3. **ravenstack_churn_events.csv** – Customer churn records and reasons
4. **ravenstack_feature_usage.csv** – Product feature usage metrics
5. **ravenstack_support_tickets.csv** – Customer support interactions

---

## Week 1 Objectives

* Load and explore all project datasets.
* Assess data quality and identify missing values.
* Validate account identifiers and subscription records.
* Convert date columns into appropriate datetime formats.
* Handle missing values and invalid records.
* Create Cohort Month feature for customer acquisition tracking.
* Prepare cleaned datasets for retention and CLTV analysis.

---

## Data Cleaning Activities Performed

### Subscription Dataset

* Imported and explored subscription data.
* Checked missing values and validated records.
* Converted start_date and end_date to datetime format.
* Created cohortMonth based on each customer's first subscription date.
* Exported cleaned subscription dataset.

### Accounts Dataset

* Validated account information.
* Checked for duplicate and missing records.
* Converted signup_date to datetime format.
* Verified seat allocation values and categorical fields.

### Churn Events Dataset

* Identified missing feedback entries.
* Handled missing feedback values appropriately.
* Converted churn_date to datetime format.
* Validated churn event records.

### Feature Usage Dataset

* Validated usage metrics and feature activity records.
* Converted usage_date to datetime format.
* Checked usage counts, durations, and error metrics.
* Created UsageMonth feature.

### Support Tickets Dataset

* Handled missing satisfaction scores.
* Converted submitted_at and closed_at fields to datetime format.
* Validated resolution times and response times.
* Reviewed ticket priority and escalation information.

---

## Key Outcomes

* Successfully cleaned and validated all project datasets.
* Created Cohort Month feature for retention analysis.
* Standardized date formats across datasets.
* Prepared datasets for Cohort Retention Matrix development.
* Established a clean data foundation for CLTV calculations and churn analysis.
* Maintained project version control using Git and GitHub.

---

## Deliverables

* cleaned_subscriptions.csv
* cleaned_accounts.csv
* cleaned_churn_events.csv
* cleaned_feature_usage.csv
* cleaned_support_tickets.csv
* Week 1 Jupyter Notebook
* GitHub documentation and commit history

---

# Week 2: Cohort Retention Analysis

## Project Overview

The objective of Week 2 was to build the cohort analysis framework and measure customer retention over time using the RavenStack SaaS subscription dataset. This analysis helps identify customer retention patterns, churn behavior, and long-term engagement trends.

---

## Week 2 Objectives
* Create Subscription Month feature.
* Calculate Cohort Index for each customer.
* Build Cohort Retention Matrix.
* Calculate monthly retention percentages.
* Generate Cohort Retention Heatmap.
* Prepare datasets for churn and CLTV analysis.


## Tasks Performed
### 1. Created Subscription Month
* Extracted the subscription month from the start date.
* Converted dates into monthly periods for cohort tracking.
### 2. Calculated Cohort Index
* Measured the number of months between customer acquisition and subscription activity.
* Assigned a Cohort Index value for retention analysis.
### 3. Built Cohort Retention Matrix
* Grouped customers by CohortMonth and CohortIndex.
* Calculated unique customer counts for each cohort period.
* Created a customer retention count matrix.
### 4. Calculated Retention Rates
* Converted retention counts into percentage values.
* Measured monthly retention performance across cohorts.
* Generated the retention percentage matrix.
### 5. Generated Retention Heatmap
* Visualized retention trends using a heatmap.
* Identified high-retention and low-retention customer cohorts.
* Highlighted customer drop-off patterns over time.


## Deliverables
* master_subscription_data.csv
* cohort_framework_data.csv
* cohort_retention_matrix.csv
* retention_percentage_matrix.csv
* retention_heatmap.png
* Week 2 Analysis Notebook

---

## Key Outcomes
* Successfully developed the cohort analysis framework.
* Measured customer retention across multiple monthly cohorts.
* Identified retention trends and churn patterns.
* Generated visual insights for business decision-making.
* Prepared data foundation for Customer Lifetime Value (CLTV) analysis.

---

# Week 3: Data Validation and Quality Audit

## Project Overview

The objective of Week 3 was to validate the cleaned datasets before proceeding with advanced business analysis such as Customer Lifetime Value (CLTV) and churn analysis. Data validation ensures that the cleaned datasets are accurate, complete, and suitable for reliable analytical results.

---

## Week 3 Objectives

* Verify the integrity of all cleaned datasets.
* Confirm row and column counts against the project documentation.
* Check for duplicate account IDs.
* Validate missing values in important columns.
* Audit numerical fields for unrealistic values and outliers.
* Document validation findings and prepare datasets for the next phase of analysis.

---

## Datasets Validated

* cleaned_ravenstack_accounts.csv
* cleaned_ravenstack_subscriptions.csv
* cleaned_churn_events.csv
* cleaned_feature_usage.csv
* cleaned_support_tickets.csv

---

## Data Validation Activities

### 1. Dataset Verification

* Loaded all cleaned datasets into Jupyter Notebook using Pandas.
* Verified dataset dimensions using the `.shape` function.
* Confirmed that row and column counts matched the project documentation.

### 2. Duplicate Record Validation

* Checked for duplicate `account_id` values in the Accounts dataset.
* Verified that each customer account is unique.

**Result**

* Duplicate Account IDs Found: **0**

### 3. Missing Value Validation

Validated important business columns including:

* signup_date
* seats
* subscription records

Missing values were reviewed to determine whether they represented valid business scenarios (such as active subscriptions without an end date).

### 4. Data Quality Audit

Performed quality checks on important numerical fields.

#### Seats Validation

* Minimum Seats: **1**
* Maximum Seats: **163**

Result:

* No unrealistic seat values detected.

#### Monthly Recurring Revenue (MRR) Validation

* Minimum MRR: **0**
* Maximum MRR: **33830**

Result:

* No negative revenue values were found.
* Zero MRR values correspond to trial or non-billed subscriptions and are considered valid.

### 5. Validation Findings

* Dataset dimensions verified successfully.
* No duplicate customer accounts detected.
* No critical missing values found.
* Numerical values fall within acceptable business ranges.
* Cleaned datasets passed all validation checks.

---

## Deliverables

* data_validation_report.md
* week3_validation_checks.ipynb
* Updated project documentation
* GitHub commits for validation and quality audit

---

## Key Outcomes

* Successfully verified data integrity across all cleaned datasets.
* Confirmed dataset consistency before CLTV calculations.
* Improved confidence in the reliability of retention and revenue analysis.
* Established a validated foundation for Week 4 visualization and business insights.

---

# Week 4 – Customer Churn Dashboard & Visualization
Project Title

# Week 4: Customer Churn Analytics Dashboard using Power BI

## Objective

The objective of Week 4 was to transform the cleaned and validated SaaS customer data into an interactive Power BI dashboard. The dashboard provides insights into customer churn, highlights high-risk customer segments, and supports data-driven business decisions through meaningful visualizations and KPIs.

## Datasets Used
* churn_master_data.csv
* churn_kpi_summary.csv
* churn_segment_analysis.csv

## Tools Used
* Python (Pandas)
* Jupyter Notebook
* Power BI
* Git & GitHub

## Work Completed

### 1. Prepared Dashboard Dataset
* Used the validated master dataset for dashboard development.
* Verified data consistency before importing into Power BI.
### 2. Created KPI Cards
* Developed KPI cards to display:
* Total Customers
* Active Customers
* Churned Customers
* Churn Rate
* Active Rate
### 3. Developed Churn Visualizations
* Created the following visuals:
* Monthly Churn Trend (Line Chart)
* Churn by Plan Tier (Bar Chart)
* Churn by Industry (Bar Chart)
### 4. Added Interactive Filters
* Implemented slicers for:
* Country
* Plan Tier
* Industry
These filters allow users to explore churn across different customer segments.
### 5. Added Business Insights
* Included a Key Insights section summarizing important findings from the analysis to support business decision-making.

### Key Results
* KPI	Value
* Total Customers	500
* Active Customers	148
* Churned Customers	352
* Churn Rate	70.40%
* Active Rate	29.60%

### Business Insights
* Overall churn rate is 70.40%.
* The Pro plan recorded the highest number of churned customers.
* The DevTools industry showed the highest churn among industries.
* Monthly churn trends help identify periods with increased customer loss.
* Interactive filters enable deeper analysis across customer segments.

### Deliverables
* churn_dashboard.pbix
* Customer_Churn_Analytics_Dashboard.pdf
* churn_master_data.csv
* churn_kpi_summary.csv
* churn_segment_analysis.csv

## Conclusion

Week 4 focused on presenting churn analysis through an interactive Power BI dashboard. By combining KPI cards, trend analysis, customer segmentation, and interactive filters, the dashboard provides stakeholders with a clear view of customer behavior and churn patterns. The final solution enables data-driven decisions to improve customer retention and supports effective business reporting.
---

## Team

**Team Group No. 5 – Infotact Solutions Internship Project**

---

## Status

✅  Successfully Completed all 4 week work.




