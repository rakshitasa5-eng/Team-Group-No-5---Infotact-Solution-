# Team Project
# CLTV Branch
#Infotact Solutions || Batch 18 || Group 5

#Customer Lifetime Value (CLTV) Analysis

#Week 3 README – CLTV Analysis (In Progress)

## Status

This README covers all Week 3 work completed so far: data loading and validation, Average Order Value (AOV), average customer lifespan, purchase frequency, the full CLTV formula by acquisition channel, CLTV by plan tier, and customer value segmentation. Visualizations (bar chart, scatter plot, heatmap) are the only piece remaining and will be added on Day 4.

---

## Objective

Week 3 builds on the Cohort Retention Matrix delivered in Week 2. While Week 2 answered *how long* customers stay active, Week 3's goal is to answer *how much each customer is worth* — calculating Customer Lifetime Value (CLTV) across acquisition channels and plan tiers, then using that to identify the highest-value customer segments.

---

## Datasets Used

* `accounts_verified_clean.csv`
* `subscriptions_verified_clean.csv`

These two files were merged on `account_id` to attach each subscription record to its account-level `referral_source`, `industry`, and `country`.

---

## Step 1: Data Validation

Before any calculation began, the verified/cleaned files handed off from Week 1 were checked against the original documented schema and found to differ in three ways:

* The header row was missing from the CSV exports; column names had to be supplied manually based on the original schema.
* String fields contained a stray carriage-return character (`\r`) embedded inside the values themselves, which had to be stripped before any grouping or calculation.
* In `subscriptions_verified_clean.csv`, the `end_date` column had been moved to the last position, with null values written as the literal string `\N` instead of being left blank.

Once corrected, row counts were checked against the original README and confirmed correct: 500 accounts and 5,000 subscription records, with zero negative lifespans and zero unmatched account merges.

---

## Step 2: The Three Inputs to CLTV

CLTV is calculated as:

**CLTV = Average Order Value × Purchase Frequency × Average Customer Lifespan**

All three inputs were calculated by acquisition channel.

**Average Order Value (AOV)** — the average `mrr_amount` (Monthly Recurring Revenue) per subscription, grouped by `referral_source`.

**Average Customer Lifespan** — the number of days between `start_date` and `end_date` (or today's date, for subscriptions still active), divided by 30.44 to convert days into months.

**Purchase Frequency** — the average number of subscription records per account, grouped by `referral_source`.

---

## Step 3: CLTV by Acquisition Channel

| Referral Source | Avg. MRR (USD) | Purchase Freq. | Avg. Lifespan (Months) | CLTV (USD) |
| ---------------- | --------------- | --------------- | ------------------------ | ----------- |
| Partner | 2,363.71 | 9.96 | 21.96 | 516,833.49 |
| Organic | 2,392.06 | 10.26 | 20.69 | 507,991.13 |
| Other | 2,315.22 | 9.97 | 21.48 | 495,917.26 |
| Ads | 2,146.62 | 10.20 | 21.72 | 475,782.77 |
| Event | 2,095.37 | 9.55 | 21.27 | 425,728.03 |

**Finding:** Partner-referred customers generate the highest lifetime value, driven mainly by the longest average retention (21.96 months) rather than the highest AOV or purchase frequency. Organic actually has a slightly higher AOV and the highest purchase frequency of any channel, but its shorter lifespan keeps its CLTV just behind partner's — the two are close, not a landslide.

---

## Step 4: CLTV by Plan Tier

| Plan Tier | Avg. MRR (USD) | Purchase Freq. | Avg. Lifespan (Months) | CLTV (USD) |
| ---------- | --------------- | --------------- | ------------------------ | ----------- |
| Enterprise | 4,917.71 | 3.60 | 21.22 | 375,348.87 |
| Pro | 1,256.77 | 3.53 | 21.37 | 94,911.82 |
| Basic | 474.68 | 3.34 | 21.60 | 34,217.98 |

**Finding:** Enterprise customers generate roughly 4x the lifetime value of Pro and 11x that of Basic. Average lifespan is nearly identical across all three tiers (~21–22 months), meaning this gap is driven almost entirely by MRR, not retention.

---

## Step 5: Customer Value Segmentation

Individual accounts were classified into High, Medium, and Low CLTV segments using a tercile split (`pd.qcut`, q=3) on each account's total historical MRR contribution.

| Segment | Number of Accounts |
| -------- | -------------------- |
| Low | 167 |
| High | 167 |
| Medium | 166 |

This even three-way split confirms the segmentation method is statistically balanced across the full 500-account base.

**Note on methodology:** the account-level segmentation above is based on total MRR contribution per account, rather than the full MRR × lifespan formula used at the channel and plan-tier level. This is a simplification — accounts with more subscriptions and higher MRR generally do represent higher lifetime value — but it means this per-account figure isn't calculated identically to the channel/tier CLTV numbers above it.

---

## Next Steps

* Build the CLTV bar chart by acquisition channel
* Build the MRR vs. lifespan scatter plot by plan tier
* Build the CLTV heatmap by plan tier × acquisition channel
* Save each chart to its own output filename
* Write up final Day 4/5 business findings and recommendations

This README will be updated as each of these steps is completed.
