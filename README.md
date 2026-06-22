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

## Next Steps (Week 3)

* Analyze churn behavior using churn event data.
* Calculate Customer Lifetime Value (CLTV).
* Segment customers by retention and revenue contribution.
* Generate churn and CLTV dashboards.
* Develop business recommendations.

---

## Team

**Team Group No. 5 – Infotact Solutions Internship Project**

---

## Status

✅ Week 2 Completed Successfully (15 Jun – 22 Jun)


🚀 Ready for Week 3: Customer Lifetime Value (CLTV) Calculation

