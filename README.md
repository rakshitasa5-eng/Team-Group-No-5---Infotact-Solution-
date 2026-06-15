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

## Next Steps (Week 2)

* Create Subscription Month feature.
* Calculate Cohort Index.
* Build Cohort Retention Matrix.
* Compute monthly retention percentages.
* Generate Cohort Retention Heatmap.
* Analyze customer retention trends across cohorts.

---

## Team

**Team Group No. 5 – Infotact Solutions Internship Project**

---

## Status

✅ Week 1 Completed Successfully (15 June 2026)

🚀 Ready for Week 2: Cohort Retention Matrix Development

