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
 
# 📊 Week 3 – Customer Lifetime Value (CLTV) Analysis & Data Validation

## 🚀 Project Title

**SaaS / E-Commerce Cohort Retention & Customer Lifetime Value (CLTV) Analysis**

---

# 📌 Project Overview

Week 3 focused on validating the cleaned datasets and calculating Customer Lifetime Value (CLTV). Before performing advanced business analysis, all datasets were verified for completeness, duplicates, missing values, and numerical consistency.

The team then calculated Customer Lifetime Value using Average Monthly Recurring Revenue (MRR), Purchase Frequency, and Customer Lifespan. Customer value was analyzed across acquisition channels and subscription plans, followed by customer segmentation and visualization.

---

# 🎯 Objectives

- Validate cleaned datasets.
- Verify dataset dimensions and data integrity.
- Detect duplicate records and missing values.
- Audit important business metrics.
- Calculate Customer Lifetime Value (CLTV).
- Compare CLTV across acquisition channels.
- Compare CLTV across subscription plans.
- Segment customers into value groups.
- Create business visualizations.

---

# 📂 Datasets Used

- accounts_verified_clean.csv
- subscriptions_verified_clean.csv
- cleaned_churn_events.csv
- cleaned_feature_usage.csv
- cleaned_support_tickets.csv
- cohort_retention_matrix.csv

---

# ✅ Work Completed

## Data Validation

- Verified row and column counts.
- Confirmed dataset consistency.
- Checked duplicate Account IDs.
- Validated missing values.
- Audited numerical fields.
- Verified seat values.
- Validated Monthly Recurring Revenue (MRR).

### Validation Results

- Duplicate Account IDs: **0**
- Minimum Seats: **1**
- Maximum Seats: **163**
- Minimum MRR: **0**
- Maximum MRR: **33830**
- No negative revenue values detected.
- Cleaned datasets passed all validation checks.

---

## Customer Lifetime Value (CLTV)

Calculated:

- Average Monthly Recurring Revenue (MRR)
- Purchase Frequency
- Customer Lifespan
- Customer Lifetime Value

Analysis performed by:

- Acquisition Channel
- Subscription Plan Tier

---

## Customer Segmentation

Segmented customers into:

- High Value
- Medium Value
- Low Value

using CLTV-based analysis.

---

## Visualizations

Created:

- CLTV by Acquisition Channel
- MRR vs Customer Lifespan
- CLTV Heatmap
- Customer Value Segmentation

---

# 🛠 Technologies Used

- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- Jupyter Notebook
- Git
- GitHub

---

# 📈 Key Findings

- Partner acquisition channel generated the highest CLTV.
- Enterprise subscription plan produced the highest customer value.
- Customer lifespan remained similar across subscription plans.
- Revenue (MRR) contributed more significantly to CLTV than lifespan.
- Customer segmentation evenly distributed customers into High, Medium, and Low value groups.

---

# 📦 Deliverables

- Data Validation Report
- Validation Notebook
- CLTV Analysis Notebook
- Customer Segmentation
- Business Visualizations
- Weekly Documentation

---

# 🎓 Learning Outcomes

- Performed data validation for analytical datasets.
- Calculated Customer Lifetime Value.
- Applied customer segmentation techniques.
- Created business visualizations using Python.
- Generated actionable business insights.

---

# 🏁 Conclusion

Week 3 successfully validated the project datasets and completed Customer Lifetime Value analysis. The team calculated CLTV using business metrics, segmented customers by value, and produced visualizations that identify high-value customer groups and acquisition channels. These outputs formed the analytical foundation for dashboard development in Week 4.
---  
# 📊 Week 4 – Customer Churn Dashboard & Business Insights

## 🚀 Project Title

**SaaS / E-Commerce Customer Churn Analytics Dashboard**

---

# 📌 Project Overview

Week 4 focused on transforming analytical results into interactive business dashboards and executive insights. Using Power BI, the team developed a Customer Churn Analytics Dashboard to visualize customer behavior, monitor churn trends, compare customer segments, and support business decision-making.

---

# 🎯 Objectives

- Build an interactive Power BI dashboard.
- Visualize customer churn trends.
- Present key business KPIs.
- Analyze churn across customer segments.
- Create interactive filters.
- Generate business insights for decision-making.

---

# 📂 Datasets Used

- churn_master_data.csv
- churn_kpi_summary.csv
- churn_segment_analysis.csv
- monthly_churn_trend.csv

---

# 🛠 Tools Used

- Python
- Pandas
- Power BI
- Jupyter Notebook
- Git
- GitHub

---

# ✅ Work Completed

## Dashboard Preparation

- Prepared the master churn dataset.
- Verified data consistency.
- Imported datasets into Power BI.

---

## KPI Dashboard

Created KPI cards for:

- Total Customers
- Active Customers
- Churned Customers
- Churn Rate
- Active Rate

### KPI Results

| KPI | Value |
|------|------:|
| Total Customers | 500 |
| Active Customers | 148 |
| Churned Customers | 352 |
| Churn Rate | 70.40% |
| Active Rate | 29.60% |

---

## Customer Churn Analysis

Performed customer segmentation by:

- Subscription Plan
- Industry
- Country

---

## Trend Analysis

Created:

- Monthly Churn Trend
- Monthly Churn Summary

---

## Interactive Features

Implemented dashboard slicers for:

- Country
- Plan Tier
- Industry

---

## Business Insights

Developed a dashboard section summarizing:

- Overall customer churn
- High-risk customer segments
- Monthly churn patterns
- Customer retention opportunities

---

# 📊 Dashboard Components

- KPI Cards
- Monthly Churn Trend
- Churn by Plan Tier
- Churn by Industry
- Interactive Filters
- Monthly Summary
- Business Insights

---

# 📈 Key Business Findings

- Overall customer churn rate is **70.40%**.
- The Pro subscription plan experienced the highest churn.
- DevTools customers recorded the highest churn among industries.
- Monthly churn analysis highlighted periods with increased customer loss.
- Interactive filtering enables detailed customer analysis.

---

# 📦 Deliverables

- Customer_Churn_Analytics_Dashboard.pbix
- Customer_Churn_Analytics_Dashboard.pdf
- Dashboard Screenshot
- KPI Summary
- Customer Segment Analysis
- Monthly Churn Analysis
- Weekly Documentation

---

# 🎓 Learning Outcomes

- Built an interactive Power BI dashboard.
- Created business KPIs.
- Designed interactive visualizations.
- Applied dashboard storytelling techniques.
- Converted analytical findings into business insights.

---

# 🏁 Conclusion

Week 4 successfully transformed validated datasets and analytical outputs into an interactive Customer Churn Analytics Dashboard. The dashboard combines KPI cards, trend analysis, customer segmentation, interactive filtering, and business insights to support executive reporting and customer retention strategies. The completed solution demonstrates a full end-to-end analytics workflow from data preparation to business visualization.
---
#### Team

#### Team Group No. 5
#### Infotact Solutions Internship Project




