# Team Project

## Team Group No. 5 – Infotact Solutions Internship Project
---

### Project Title

#### SaaS Customer Retention & CLTV Analysis Using Cohort Analysis
---

#### Project Overview

The objective of this project is to analyze customer retention patterns, identify churn behavior, and estimate Customer Lifetime Value (CLTV) using the RavenStack SaaS subscription dataset. The project helps understand customer engagement trends and provides insights for improving customer retention strategies.


#### Dataset Used

The project utilizes multiple RavenStack SaaS datasets:

* ravenstack_subscriptions.csv
* ravenstack_accounts.csv
* churn_events.csv
* feature_usage.csv
* support_tickets.csv
---
### Week 1: Data Cleaning & Preparation

#### Objectives

* Load and explore datasets.
* Assess data quality.
* Handle missing values.
* Validate account identifiers.
* Convert date fields into datetime format.
* Check duplicates and data consistency.
* Export cleaned datasets.
  
#### Data Cleaning Tasks Performed

#### Python
* Loaded datasets using Pandas.
* Reviewed dataset structure and dimensions.
* Checked missing values.
* Validated account IDs.
* Converted date columns into datetime format.
* Verified negative and invalid values.
* Removed duplicates.
* Exported cleaned datasets.
  
#### SQL
* Performed data validation queries.
* Checked null values and duplicate records.
* Verified data consistency.
* Conducted exploratory analysis using SQL queries.
  
#### Deliverables
* cleaned_ravenstack_subscriptions.csv
* cleaned_ravenstack_accounts.csv
* cleaned_churn_events.csv
* cleaned_feature_usage.csv
* cleaned_support_tickets.csv
 --- 
### Week 2: Cohort Retention Analysis

#### Objectives
* Create Cohort Analysis Framework.
* Calculate customer retention metrics.
* Build retention matrices.
* Generate retention heatmap.

#### Tasks Performed
#### Master Dataset Creation
* Merged subscription and account datasets.
* Created consolidated dataset for cohort analysis.
#### Cohort Framework

Created:

* CohortMonth
* SubscriptionMonth
* CohortIndex
  
#### Retention Matrix
* Grouped customers by CohortMonth and CohortIndex.
* Counted unique customers for each cohort period.
* Generated customer retention count matrix.
#### Retention Percentage Matrix
* Converted retention counts into percentages.
* Calculated monthly retention rates for each cohort.
#### Retention Heatmap
* Visualized customer retention trends.
* Highlighted retention patterns across cohorts.
* Generated retention_heatmap.png.
#### Key Outcomes
* Cleaned and validated SaaS datasets.
* Built cohort analysis framework.
* Measured customer retention across multiple cohorts.
* Generated retention matrices and heatmap visualizations.
* Identified customer retention trends and churn behavior.
* Prepared foundation for Customer Lifetime Value (CLTV) analysis.
  
#### Technologies Used
* Python
* Pandas
* NumPy
* Matplotlib
* Seaborn
* SQL
* Jupyter Notebook
* Git & GitHub
 --- 
#### Project Structure
Team-Group-No-5---Infotact-Solution-

├── Cleaned Data/

    │   ├── cleaned_ravenstack_subscriptions.csv
    │   ├── cleaned_ravenstack_accounts.csv
    │   ├── cleaned_churn_events.csv
    │   ├── cleaned_feature_usage.csv
    │   └── cleaned_support_tickets.csv

    ├── csv-cleaning-with-sql/
    │   ├── SQL_Cleaning_Queries.sql
    │   └── SQL_Validation_Report.md

    ├── Cohort Retention Matrix/
    │   ├── cohort_framework_data.csv
    │   ├── cohort_retention_matrix.csv
    │   ├── retention_percentage_matrix.csv
    │   ├── retention_heatmap.png
    │   └── Week2_Cohort_Analysis.ipynb

    └── README.md
 
#### Next Steps (Week 3)
* Churn Analysis
* Customer Lifetime Value (CLTV) Calculation
* Customer Segmentation
* Revenue Analysis
* Business Recommendations
---  
#### Team

#### Team Group No. 5
#### Infotact Solutions Internship Project

#### Status

✅ Week 1 Completed

✅ Week 2 Completed

🔄 Week 3 In Progress (Churn Analysis & CLTV)
