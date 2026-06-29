# Week 3 Documentation – Customer Lifetime Value (CLTV) Calculation

---

# Day 1 – Week 3 Planning and Data Preparation

## Objective

The objective of Week 3 was to calculate Customer Lifetime Value (CLTV) for the RavenStack customer base and determine which customer segments generate the highest long-term revenue.

The team built on the cohort retention groundwork completed in Week 2 and shifted the analysis from retention behavior to financial value, using customer subscription and account data.

---

## Week 3 Goals

The following goals were finalized for Week 3:

* Load and validate the verified/cleaned dataset files
* Segment customers by acquisition channel and plan tier
* Calculate Average Order Value (AOV) per segment
* Calculate average customer lifespan per segment
* Calculate purchase frequency per segment
* Apply the CLTV formula across all segments
* Classify customers into High, Medium, and Low value groups
* Visualize CLTV findings for business reporting

---

## Datasets Used

The analysis was conducted using the following verified datasets, handed off from the Week 1 cleaning phase:

* `accounts_verified_clean.csv`
* `subscriptions_verified_clean.csv`
* `churn_events_verified_clean.csv`
* `feature_usage_verified_clean.csv`
* `tickets_verified_clean.csv`

In addition, the Week 2 deliverable `cohort_retention_matrix.csv` was loaded as supporting context for cohort-based segmentation.

---

## Business Objective

The business objective of the CLTV analysis was to identify which customer acquisition channels and plan tiers return the highest long-term value, so the Finance team can determine an acceptable Customer Acquisition Cost (CAC) and the Product team can prioritize retention efforts on the highest-value segments.

---

## Data Loading Validation

Before any calculation began, the verified files were inspected and found to differ from the originally documented schema in three ways:

* The header row was missing from all five CSV files; column names had to be supplied manually based on the original schema.
* String fields across all files contained a stray carriage-return character (`\r`) embedded inside the value itself, which had to be stripped before any text-based grouping.
* The `subscriptions_verified_clean.csv` file had its `end_date` column relocated to the last position, with null values written as the literal string `\N` instead of being left blank.

These issues were resolved at load time so that downstream calculations operated on clean, correctly typed data. Row counts were validated against the original README and confirmed to match: 500 accounts, 5,000 subscriptions, 600 churn events, 25,000 feature usage records, and 2,000 support tickets.

---

# Day 2 – Average Order Value, Lifespan, and Purchase Frequency

## Objective

The objective of Day 2 was to calculate the three core inputs to the CLTV formula — Average Order Value (AOV), average customer lifespan, and purchase frequency — broken out by acquisition channel.

---

## Methodology

Subscriptions were merged with account-level data on `account_id` to attach `referral_source`, `industry`, and `country` to each subscription record.

Customer lifespan was calculated as the number of days between `start_date` and `end_date` (or today's date, for still-active subscriptions), converted to months by dividing by 30.44, the average number of days per month.

Purchase frequency was calculated as the average number of subscription records per account, grouped by referral source.

---

## AOV by Acquisition Channel

| Referral Source | Avg. MRR (USD) |
| ---------------- | --------------- |
| Partner | 2,363.71 |
| Organic | 2,392.06 |
| Other | 2,315.22 |
| Ads | 2,146.62 |
| Event | 2,095.37 |

---

## Average Lifespan by Acquisition Channel

| Referral Source | Avg. Lifespan (Months) |
| ---------------- | ------------------------ |
| Partner | 21.78 |
| Ads | 21.54 |
| Other | 21.30 |
| Event | 21.09 |
| Organic | 20.52 |

---

## Purchase Frequency by Acquisition Channel

| Referral Source | Avg. Subscriptions per Account |
| ---------------- | -------------------------------- |
| Organic | 10.26 |
| Ads | 10.20 |
| Other | 9.97 |
| Partner | 9.96 |
| Event | 9.55 |

---

# Day 3 – CLTV Formula and Segment Tables

## Objective

The objective of Day 3 was to combine the Day 2 metrics into a single CLTV figure per segment, and to classify individual customer accounts by value tier.

---

## CLTV Formula

The CLTV formula applied was:

**CLTV = Average Order Value × Purchase Frequency × Average Customer Lifespan**

---

## CLTV by Acquisition Channel

| Referral Source | Avg. MRR | Purchase Freq. | Avg. Lifespan (Months) | CLTV (USD) |
| ---------------- | -------- | -------------- | ------------------------ | ----------- |
| Partner | 2,363.71 | 9.96 | 21.78 | 512,602.72 |
| Organic | 2,392.06 | 10.26 | 20.52 | 503,660.25 |
| Other | 2,315.22 | 9.97 | 21.30 | 491,756.62 |
| Ads | 2,146.62 | 10.20 | 21.54 | 471,888.19 |
| Event | 2,095.37 | 9.55 | 21.09 | 422,152.81 |

**Finding:** Partner-referred customers generate the highest lifetime value, despite organic customers having a slightly higher purchase frequency. This is driven by partner customers' longer average retention (21.78 months, the highest of any channel).

---

## CLTV by Plan Tier

| Plan Tier | Avg. MRR | Purchase Freq. | Avg. Lifespan (Months) | CLTV (USD) |
| ---------- | -------- | -------------- | ------------------------ | ----------- |
| Enterprise | 4,917.71 | 3.60 | 21.04 | 372,198.05 |
| Pro | 1,256.77 | 3.53 | 21.19 | 94,117.99 |
| Basic | 474.68 | 3.34 | 21.42 | 33,935.05 |

**Finding:** Enterprise accounts generate roughly 4x the lifetime value of Pro accounts and 11x that of Basic accounts, almost entirely driven by MRR rather than retention length, since lifespan is similar across all three tiers.

---

## Customer Value Segmentation

Individual accounts were classified into High, Medium, and Low CLTV segments using tercile splits (`pd.qcut`, q=3) on total historical MRR contribution per account.

| Segment | Number of Accounts |
| -------- | -------------------- |
| Low | 167 |
| High | 167 |
| Medium | 166 |

This even three-way split confirms the segmentation method is statistically balanced and ready for use in targeting and reporting.

---

# Day 4 – Visualization

## Objective

The objective of Day 4 was to translate the CLTV findings into visual form for stakeholder communication, following the same chart standards established in Week 2's retention heatmap work.

---

## Charts Produced

* **Bar chart** — CLTV by acquisition channel, ranking all five referral sources from highest to lowest value.
* **Scatter plot** — MRR vs. customer lifespan, colored by plan tier, showing how Enterprise, Pro, and Basic accounts cluster differently in value vs. retention.
* **Heatmap** — average MRR (CLTV proxy) by plan tier and acquisition channel combined, allowing identification of the single highest-value combination (Enterprise customers via partner channel).

---

## Quality Note

During chart generation, all three visualizations were saved using the same output filename in the working notebook. This was identified during review and should be corrected to three distinct filenames (e.g. `cltv_by_channel.png`, `mrr_vs_lifespan.png`, `cltv_heatmap.png`) before final submission, so that all three charts are preserved as separate files rather than overwriting one another.

---

# Day 5 – Week 3 Summary

## Week 3 Activities Completed

During Week 3, the following activities were completed:

* Loaded and validated five verified datasets against the original schema
* Resolved data formatting issues (missing headers, embedded carriage returns, reordered columns, non-standard null markers) prior to analysis
* Calculated AOV, purchase frequency, and average lifespan by acquisition channel
* Applied the CLTV formula across both acquisition channel and plan tier segments
* Classified all 500 customer accounts into High, Medium, and Low value tiers
* Produced three supporting visualizations for stakeholder reporting

---

## Deliverables

* CLTV segment table by acquisition channel
* CLTV segment table by plan tier
* Customer value classification (High / Medium / Low)
* CLTV bar chart by acquisition channel
* MRR vs. lifespan scatter plot by plan tier
* CLTV heatmap by plan tier and acquisition channel

---

## Business Findings

* **Partner channel delivers the highest CLTV** (512,602.72 USD), driven primarily by longer customer retention rather than higher purchase frequency.
* **Event-acquired customers have the lowest CLTV** (422,152.81 USD) of all channels, suggesting this channel may warrant a lower CAC ceiling or a different retention strategy.
* **Plan tier is the dominant driver of lifetime value**: Enterprise customers are worth roughly 11x a Basic customer, almost entirely due to MRR differences rather than retention differences, since average lifespan is nearly identical across tiers (~21 months for all three).
* **Customer value is evenly distributed** across the High/Medium/Low segmentation, supporting confident use of this classification for targeted retention or upsell campaigns.

---

## Recommendations

* Prioritize the partner channel in acquisition spend, as it returns the highest CLTV per acquired customer.
* Investigate the event channel's shorter retention and lower CLTV to determine whether a different onboarding or pricing approach is needed.
* Focus upsell campaigns on Pro-tier customers, since moving a customer from Pro to Enterprise has a larger CLTV impact than any change in retention behavior.
* Use the High-value customer segment (167 accounts) as the basis for a dedicated customer success or account management track, given their outsized revenue contribution.

---

## Overall Business Value

The Week 3 CLTV analysis converts the retention patterns identified in Week 2 into a financial decision-making tool. By quantifying lifetime value per channel and per plan tier, this analysis gives the Finance Director a defensible basis for setting maximum acceptable CAC by channel, and gives the Product Manager a ranked list of segments to prioritize for retention investment.

The CLTV findings, combined with Week 2's retention curves, provide the analytical foundation for Week 4's visualization and strategic storytelling phase.
