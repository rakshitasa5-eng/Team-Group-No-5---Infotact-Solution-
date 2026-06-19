# Week 2 Documentation – Cohort Retention Matrix Development

---

# Day 1 – Week 2 Planning and Objective Definition

## Objective

The objective of Week 2 was to develop a Cohort Retention Matrix to analyze customer retention behavior over multiple monthly periods.

The team focused on understanding how long customers remained active after their initial subscription and identifying periods where customer churn became significant.

The retention analysis was planned using customer subscription data from the SaaS platform.

---

## Week 2 Goals

The following goals were finalized for Week 2:

* Build a Cohort Retention Matrix
* Calculate monthly retention percentages
* Track customer activity across monthly periods
* Identify customer churn patterns
* Prepare retention visualization structures
* Generate retention-based business insights

---

## Dataset Used

The analysis was conducted using the following dataset:

`cleaned_ravenstack_subscriptions.csv`

The dataset contains customer subscription history and activity records required for cohort analysis and retention tracking.

---

## Business Objective

The business objective of the retention analysis was to identify customer engagement patterns and determine the stages where customers are most likely to discontinue their subscriptions.

The analysis supports customer retention planning, product engagement improvement, and long-term subscription growth strategies.

---

# Day 2 – Cohort Analysis Research and Framework Design

## Understanding Cohort Analysis

On Day 2, the team researched cohort analysis methodologies and finalized the framework required for retention tracking.

A cohort was defined as a group of customers who subscribed during the same acquisition month.

For example:

* Customers who subscribed in January formed the January cohort.
* Customers who subscribed in February formed the February cohort.

This approach allowed customer retention behavior to be compared across multiple acquisition periods.

---

## Importance of Cohort Analysis

The team identified several advantages of cohort analysis:

* Measures long-term customer retention
* Identifies churn trends over time
* Tracks customer engagement behavior
* Supports customer lifecycle analysis
* Provides deeper insights than overall retention averages

Cohort analysis was selected because it provides a clearer understanding of how customer behavior changes after acquisition.

---

## Planned Outputs

The following outputs were planned during the framework design phase:

* Cohort Retention Matrix
* Monthly Retention Percentage Table
* Retention Trend Analysis
* Retention Heatmap Structure

---

# Day 3 – Cohort Retention Matrix Planning

## Objective

The objective of Day 3 was to finalize the structure of the cohort retention matrix and identify the dataset fields required for retention calculations.

---

## Key Fields Selected

The following fields from the subscription dataset were selected for analysis:

| Field Name  | Purpose                        |
| ----------- | ------------------------------ |
| account_id  | Unique customer identification |
| start_date  | Subscription start date        |
| cohortMonth | Customer acquisition month     |
| churn_flag  | Customer churn indicator       |

These fields were required to track customer retention behavior across different monthly periods.

---

## Retention Metrics Planned

The following retention metrics were planned:

* Month 0 Retention
* Month 1 Retention
* Month 2 Retention
* Month 3 Retention

Retention percentages were used to measure how many customers remained active after their acquisition month.

---

## Technical Planning

The retention matrix structure was planned using Pandas-based data manipulation techniques.

The analysis workflow included:

* Grouping customers using `groupby()`
* Organizing retention data using `pivot_table()`
* Tracking customer activity across monthly periods
* Calculating retention percentages for each cohort

These operations were required to generate the cohort retention matrix.

---

# Day 4 – Dataset Validation and Retention Preparation

## Objective

The objective of Day 4 was to validate the subscription dataset and confirm that it supported cohort retention analysis.

---

## Validation Findings

The validation process produced the following results:

| Validation Metric          | Result |
| -------------------------- | ------ |
| Total subscription records | 5000   |
| Unique customer accounts   | 500    |

The dataset contained multiple subscription records for customer accounts, enabling customer activity tracking across different monthly periods.

---

## Validation Outcome

The dataset structure successfully supported:

* Cohort assignment
* Monthly retention tracking
* Customer activity analysis
* Retention percentage calculations

No major structural issues or missing field dependencies were identified during validation.

The dataset was confirmed to be suitable for cohort analysis implementation.

---

# Day 5 – Retention Logic Development

## Objective

The objective of Day 5 was to define the retention calculation methodology and establish the customer tracking logic.

---

## Retention Logic

The retention analysis used customer subscription history to measure how long customers remained active after their first subscription month.

Customer activity was tracked across multiple monthly periods to evaluate long-term retention behavior.

---

## Cohort Definition

Customers were grouped into cohorts based on their first subscription month using the `cohortMonth` field.

This allowed retention performance to be compared across different customer acquisition periods.

---

## Retention Tracking Methodology

The retention tracking process included the following steps:

1. Identifying each customer’s acquisition month
2. Tracking repeated subscription activity
3. Measuring active customer counts per month
4. Calculating monthly retention percentages
5. Identifying customer drop-off trends

---

## Core Metrics Planned

The following metrics formed the basis of the retention analysis:

* Active customers per cohort
* Monthly retention percentages
* Customer churn trends
* Retention decay patterns

These metrics support the final retention analysis and business insight generation.

---

# Day 6 – Retention Visualization Planning

## Objective

The objective of Day 6 was to design the retention visualization structure and prepare the framework for retention heatmap generation.

---

## Retention Heatmap Structure

The retention heatmap was designed to visualize customer retention behavior across multiple cohorts and monthly periods.

The structure included:

* Rows representing customer cohorts
* Columns representing retention periods
* Retention percentages displayed as values

The heatmap structure improves the interpretation of customer retention and churn trends.

---

## Expected Retention Insights

The planned visualization analysis was expected to help identify:

* Early-stage customer drop-off
* Stronger-performing cohorts
* Long-term retention behavior
* Monthly retention decline patterns

These findings are important for customer engagement improvement strategies.

---

## Business Importance

The retention visualization framework supports better communication of customer behavior trends and assists product strategy and customer success teams in identifying retention improvement opportunities.

---

# Day 7 – Week 2 Summary

## Week 2 Activities Completed

During Week 2, the team successfully completed the following activities:

* Planned the cohort retention analysis framework
* Defined retention metrics
* Validated the subscription dataset
* Designed the cohort retention logic
* Planned the retention matrix structure
* Prepared retention visualization frameworks

---

## Planned Deliverables

The following deliverables were planned and partially developed during Week 2:

* Cohort Retention Matrix
* Retention Percentage Table
* Retention Heatmap Structure
* Retention Trend Analysis

---

## Business Findings and Expectations

The retention analysis framework is expected to provide insights into customer retention behavior and churn patterns.

Expected observations include:

* Gradual decline in customer retention across monthly periods
* Identification of high-retention customer cohorts
* Detection of early-stage customer churn
* Retention variation across acquisition periods

These findings are expected to support customer retention improvement and long-term subscription growth strategies.

---

## Overall Business Value

The Week 2 retention analysis established a strong analytical foundation for future project phases, including CLTV calculation and advanced customer segmentation.

The retention analysis supports future business decisions related to:

* Customer retention optimization
* Product engagement improvement
* Subscription growth planning
* Revenue forecasting
* Customer success strategies

The successful completion of Week 2 prepared the project for the Week 3 CLTV analysis phase.
