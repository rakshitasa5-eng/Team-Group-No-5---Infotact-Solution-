# Week 2 Documentation – Cohort Retention Analysis

---

# Day 1 – Week 2 Planning and Objective Definition

## Objective

During Day 1, the team initiated Week 2 activities by defining the objectives and analytical goals for cohort retention analysis.

The primary objective was to build a Cohort Retention Matrix using customer subscription data and evaluate customer retention behavior over time.

The team focused on understanding how customer activity changes after acquisition and identifying periods where customer churn becomes significant.

---

## Week 2 Goals

The following goals were finalized for Week 2:

* Build a Cohort Retention Matrix
* Calculate monthly retention percentages
* Analyze customer retention patterns
* Identify churn periods
* Create retention visualizations
* Generate business insights from retention trends

---

## Dataset Used

The analysis was conducted using the following dataset:

`cleaned_ravenstack_subscriptions.csv`

The dataset contains customer subscription history and activity records required for retention analysis.

---

## Business Goal

The business objective of the retention analysis was to identify customer engagement trends and determine the periods where customers are most likely to discontinue their subscriptions.

The findings are expected to support customer retention strategies, revenue growth planning, and product engagement improvements.

---

# Day 2 – Cohort Analysis Research and Framework Design

## Cohort Analysis Concept

On Day 2, the team researched cohort analysis methodologies and finalized the cohort grouping strategy.

A cohort was defined as a group of customers who subscribed during the same month.

Customers were grouped according to their first subscription month to measure retention behavior consistently across different acquisition periods.

Example:

* Customers who subscribed in January formed the January cohort.
* Customers who subscribed in February formed the February cohort.

This approach enabled retention comparison between multiple customer groups.

---

## Importance of Cohort Analysis

The team identified several advantages of cohort analysis:

* Helps measure long-term customer retention
* Detects customer churn trends
* Tracks engagement over time
* Supports customer lifecycle analysis
* Provides deeper insights than overall retention averages

The cohort methodology was selected because it provides a more accurate understanding of customer behavior patterns.

---

## Planned Outputs

The following outputs were finalized during the planning phase:

* Cohort Retention Matrix
* Monthly Retention Percentage Table
* Retention Heatmap
* Retention Trend Analysis

---

# Day 3 – Cohort Retention Matrix Planning

## Objective

The objective of Day 3 was to finalize the technical structure of the cohort retention matrix and identify the fields required for retention calculations.

---

## Key Fields Used

The following dataset columns were selected for analysis:

| Field Name  | Purpose                        |
| ----------- | ------------------------------ |
| account_id  | Unique customer identification |
| start_date  | Subscription start date        |
| cohortMonth | Customer cohort assignment     |
| churn_flag  | Customer churn indicator       |

These fields were essential for tracking customer activity and retention behavior across multiple periods.

---

## Retention Metrics

The team finalized the following retention metrics for analysis:

* Month 0 Retention
* Month 1 Retention
* Month 2 Retention
* Month 3 Retention

Retention percentages were calculated to measure how many customers remained active after their initial subscription month.

---

## Visualization Planning

The visualization structure for the retention analysis was also planned.

The analysis outputs included:

* Cohort Matrix
* Retention Percentage Charts
* Retention Heatmap

These visualizations were designed to improve the interpretation of retention trends and customer drop-off behavior.

---

# Day 4 – Dataset Validation

## Objective

The objective of Day 4 was to validate the subscription dataset and confirm that it supported cohort retention analysis.

---

## Validation Findings

The validation process produced the following findings:

| Validation Metric          | Result |
| -------------------------- | ------ |
| Total subscription records | 5000   |
| Unique customer accounts   | 500    |

The dataset contained multiple subscription records for customer accounts, enabling customer activity tracking across different monthly periods.

---

## Validation Outcome

The dataset structure successfully supported:

* Cohort assignment
* Monthly activity tracking
* Retention calculations
* Churn analysis

No major structural issues or missing field dependencies were identified during validation.

The validation process confirmed that the dataset was suitable for retention analysis and visualization.

---

# Day 5 – Cohort Retention Logic Development

## Objective

The objective of Day 5 was to define the retention calculation logic and establish the customer tracking methodology.

---

## Retention Logic

The retention analysis used customer subscription history to measure how long customers remained active after their initial subscription month.

Customer activity was tracked across multiple monthly periods to evaluate long-term retention behavior.

---

## Cohort Definition

Customers were assigned to cohorts based on their first subscription month using the `cohortMonth` field.

This allowed the team to analyze retention performance across different customer acquisition periods.

---

## Retention Tracking Process

The retention tracking methodology included:

1. Identifying each customer's acquisition month
2. Tracking repeated subscription activity
3. Measuring active customer counts per period
4. Calculating monthly retention percentages
5. Measuring customer drop-off trends

---

## Core Metrics Generated

The following metrics were generated during the analysis process:

* Active customers per cohort
* Monthly retention percentages
* Churn trend analysis
* Retention decay patterns

These metrics formed the foundation of the final retention analysis.

---

# Day 6 – Heatmap and Retention Visualization

## Objective

The objective of Day 6 was to create retention visualizations and analyze cohort retention patterns using heatmap representations.

---

## Retention Heatmap

A retention heatmap was developed to visualize customer retention behavior across different cohorts and monthly periods.

The heatmap structure included:

* Rows representing customer cohorts
* Columns representing retention periods
* Retention percentages displayed as values

This visualization made it easier to identify retention trends and periods of significant customer churn.

---

## Retention Insights

The heatmap analysis highlighted several important retention patterns:

* Early-stage customer drop-off was visible across multiple cohorts
* Certain cohorts demonstrated stronger long-term retention behavior
* Retention percentages gradually declined over time for most customer groups

The visualization helped identify areas where customer engagement improvements may be required.

---

## Business Importance

The retention visualization improved the ability to communicate customer behavior trends and provided actionable insights for customer success and product strategy teams.

---

# Day 7 – Week 2 Summary and Findings

## Week 2 Activities Completed

During Week 2, the team successfully completed the following tasks:

* Planned the cohort retention analysis framework
* Defined retention metrics
* Validated the subscription dataset
* Developed retention tracking logic
* Created retention visualization structures
* Analyzed retention trends using cohort methodology

---

## Final Deliverables Completed

The following outputs were completed during Week 2:

* Cohort Retention Matrix
* Retention Percentage Table
* Retention Heatmap
* Retention Trend Analysis
* Initial Business Insights

---

## Business Findings

The cohort analysis revealed valuable insights into customer retention behavior.

Key observations included:

* Customer retention declined gradually across monthly periods
* Certain customer cohorts retained users more effectively than others
* Early customer churn was identified as a major business concern
* Retention patterns varied across acquisition periods

These findings provided important insights for improving customer retention strategies and long-term subscription performance.

---

## Overall Business Value

The Week 2 retention analysis helped the team better understand customer lifecycle behavior and churn patterns.

The analysis supports future business decisions related to:

* Customer retention improvement
* Product engagement optimization
* Subscription growth strategies
* Revenue forecasting
* Customer success initiatives

The completion of Week 2 established a strong analytical foundation for the advanced business insights and segmentation analysis planned for subsequent project phases.
