# Week 2 Documentation

## Objective

Build the Cohort Retention Matrix and analyze customer retention behavior.

## Cohort Analysis Concept

A cohort is a group of customers acquired during the same month.

Customers will be grouped using their first subscription month.

## Retention Metrics

* Month 0 Retention
* Month 1 Retention
* Month 2 Retention
* Month 3 Retention

## Expected Outputs

* Cohort Matrix
* Retention Percentage Table
* Retention Heatmap

## Dataset Used

cleaned_ravenstack_subscriptions.csv

## Business Goal

Identify when customers are most likely to churn and determine long-term retention patterns.

## Day 3 - Cohort Retention Matrix Planning


### Objective

The objective of Week 2 is to build a Cohort Retention Matrix using subscription data and analyze customer retention patterns over time.

### Dataset Used

* cleaned_ravenstack_subscriptions.csv

### Key Fields Required

* account_id
* start_date
* cohortMonth
* churn_flag

### Expected Deliverables

* Cohort Retention Matrix
* Retention Percentage Table
* Retention Heatmap
* Retention Insights

### Cohort Analysis Approach

1. Group customers by their first subscription month.
2. Track customer activity across subsequent months.
3. Measure how many customers remain active in each period.
4. Calculate retention percentages for every cohort.
5. Visualize retention trends using a heatmap.

### Business Value

Cohort analysis helps identify customer retention trends and highlights periods where customer drop-off is highest. These insights support customer success, product, and revenue growth decisions.

## Day 4 - Dataset Validation

### Validation Findings

- Total subscription records: 5000
- Unique customer accounts: 500
- Dataset supports cohort retention analysis because accounts appear across multiple subscription records.

## Day 5 - Cohort Retention Logic
### Retention Logic

The cohort retention process will use customer subscription history to measure how long customers remain active after their initial subscription month.

### Cohort Definition

Customers will be grouped based on their first subscription month using the `cohortMonth` field.

### Retention Tracking

Retention will be measured by tracking repeated subscription activity for each `account_id` across multiple records.

### Core Metrics

* Number of active customers per cohort
* Monthly retention percentages
* Customer drop-off trends over time

### Expected Output

The final output will include a Cohort Retention Matrix and retention percentage analysis for business insights.
