# Team Project

# SaaS/E-Commerce Cohort Retention & CLTV Analysis

## Week 1: Transactional Data Cleaning and Wrangling

### Project Overview

The objective of this project is to analyze customer retention patterns and calculate Customer Lifetime Value (CLTV) using SaaS subscription data. The analysis will help identify customer churn behavior, retention trends, and opportunities to improve customer engagement.

### Dataset

The project uses the RavenStack SaaS subscription dataset, which contains subscription details, account information, revenue metrics, and churn indicators.

### Week 1 Objectives

* Load and explore the subscription dataset.
* Assess data quality and identify missing values.
* Validate account identifiers and subscription records.
* Convert date fields into proper datetime format.
* Create the Cohort Month feature based on each customer's first subscription date.
* Prepare a clean dataset for retention analysis.

### Data Cleaning Steps Performed

1. Imported and explored the RavenStack subscription dataset.
2. Reviewed dataset structure, dimensions, and column information.
3. Checked for missing values across all columns.
4. Verified that no account identifiers were missing.
5. Identified missing end dates as active subscriptions and retained those records.
6. Converted `start_date` and `end_date` columns into datetime format.
7. Generated the `cohortMonth` column using each account's first subscription date.
8. Exported the cleaned dataset for further analysis.

### Key Outcomes

* Cleaned and validated subscription dataset.
* Cohort Month feature successfully created.
* Dataset prepared for Cohort Retention Matrix development.
* Version-controlled project updates using Git and GitHub.

### Deliverables

* Cleaned subscription dataset (`cleaned_subscriptions.csv`)
* Week 1 project documentation
* GitHub repository updates and commits

### Next Steps (Week 2)

* Create Subscription Month feature.
* Calculate Cohort Index.
* Build Cohort Retention Matrix.
* Compute monthly retention percentages.
* Generate Cohort Retention Heatmap.

### Team

Team Group No. 5 – Infotact Solutions Internship Project

### Status

Week 1 - Completing Soon...
