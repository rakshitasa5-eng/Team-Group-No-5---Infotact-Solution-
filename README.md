# Team Project
# CLTV Branch
#Infotact Solutions || Batch 18 || Group 5

#Customer Lifetime Value (CLTV) Analysis

Week 3 README – CLTV Analysis (In Progress)
2
 
3
## Status
4
 
5
This README covers all Week 3 work completed so far: data loading and validation, Average Order Value (AOV), average customer lifespan, purchase frequency, the full CLTV formula by acquisition channel, CLTV by plan tier, and customer value segmentation. Visualizations (bar chart, scatter plot, heatmap) are the only piece remaining and will be added on Day 4.
6
 
7
---
8
 
9
## Objective
10
 
11
Week 3 builds on the Cohort Retention Matrix delivered in Week 2. While Week 2 answered *how long* customers stay active, Week 3's goal is to answer *how much each customer is worth* — calculating Customer Lifetime Value (CLTV) across acquisition channels and plan tiers, then using that to identify the highest-value customer segments.
12
 
13
---
14
 
15
## Datasets Used
16
 
17
* `accounts_verified_clean.csv`
18
* `subscriptions_verified_clean.csv`
19
20
These two files were merged on `account_id` to attach each subscription record to its account-level `referral_source`, `industry`, and `country`.
21
 
22
---
23
 
24
## Step 1: Data Validation
25
 
26
Before any calculation began, the verified/cleaned files handed off from Week 1 were checked against the original documented schema and found to differ in three ways:
27
 
28
* The header row was missing from the CSV exports; column names had to be supplied manually based on the original schema.
29
* String fields contained a stray carriage-return character (`\r`) embedded inside the values themselves, which had to be stripped before any grouping or calculation.
30
* In `subscriptions_verified_clean.csv`, the `end_date` column had been moved to the last position, with null values written as the literal string `\N` instead of being left blank.
31
32
Once corrected, row counts were checked against the original README and confirmed correct: 500 accounts and 5,000 subscription records, with zero negative lifespans and zero unmatched account merges.
33
 
34
---
35
 
36
## Step 2: The Three Inputs to CLTV
37
 
38
CLTV is calculated as:
39
 
40
**CLTV = Average Order Value × Purchase Frequency × Average Customer Lifespan**
41
 
42
All three inputs were calculated by acquisition channel.
43
 
44
**Average Order Value (AOV)** — the average `mrr_amount` (Monthly Recurring Revenue) per subscription, grouped by `referral_source`.
45
 
46
**Average Customer Lifespan** — the number of days between `start_date` and `end_date` (or today's date, for subscriptions still active), divided by 30.44 to convert days into months.
47
 
48
**Purchase Frequency** — the average number of subscription records per account, grouped by `referral_source`.
49
 
50
---
51
 
52
## Step 3: CLTV by Acquisition Channel
53
 
54
| Referral Source | Avg. MRR (USD) | Purchase Freq. | Avg. Lifespan (Months) | CLTV (USD) |
55
| ---------------- | --------------- | --------------- | ------------------------ | ----------- |
56
| Partner | 2,363.71 | 9.96 | 21.96 | 516,833.49 |
57
| Organic | 2,392.06 | 10.26 | 20.69 | 507,991.13 |
58
| Other | 2,315.22 | 9.97 | 21.48 | 495,917.26 |
59
| Ads | 2,146.62 | 10.20 | 21.72 | 475,782.77 |
60
| Event | 2,095.37 | 9.55 | 21.27 | 425,728.03 |
61
 
62
**Finding:** Partner-referred customers generate the highest lifetime value, driven mainly by the longest average retention (21.96 months) rather than the highest AOV or purchase frequency. Organic actually has a slightly higher AOV and the highest purchase frequency of any channel, but its shorter lifespan keeps its CLTV just behind partner's — the two are close, not a landslide.
63
 
64
---
65
 
66
## Step 4: CLTV by Plan Tier
67
 
68
| Plan Tier | Avg. MRR (USD) | Purchase Freq. | Avg. Lifespan (Months) | CLTV (USD) |
69
| ---------- | --------------- | --------------- | ------------------------ | ----------- |
70
| Enterprise | 4,917.71 | 3.60 | 21.22 | 375,348.87 |
71
| Pro | 1,256.77 | 3.53 | 21.37 | 94,911.82 |
72
| Basic | 474.68 | 3.34 | 21.60 | 34,217.98 |
73
 
74
**Finding:** Enterprise customers generate roughly 4x the lifetime value of Pro and 11x that of Basic. Average lifespan is nearly identical across all three tiers (~21–22 months), meaning this gap is driven almost entirely by MRR, not retention.
75
 
76
---
77
 
78
## Step 5: Customer Value Segmentation
79
 
80
Individual accounts were classified into High, Medium, and Low CLTV segments using a tercile split (`pd.qcut`, q=3) on each account's total historical MRR contribution.
81
 
82
| Segment | Number of Accounts |
83
| -------- | -------------------- |
84
| Low | 167 |
85
| High | 167 |
86
| Medium | 166 |
87
 
88
This even three-way split confirms the segmentation method is statistically balanced across the full 500-account base.
89
 
90
**Note on methodology:** the account-level segmentation above is based on total MRR contribution per account, rather than the full MRR × lifespan formula used at the channel and plan-tier level. This is a simplification — accounts with more subscriptions and higher MRR generally do represent higher lifetime value — but it means this per-account figure isn't calculated identically to the channel/tier CLTV numbers above it.
91
 
92
---
93
 
94
## Next Steps
95
 
96
* Build the CLTV bar chart by acquisition channel
97
* Build the MRR vs. lifespan scatter plot by plan tier
98
* Build the CLTV heatmap by plan tier × acquisition channel
99
* Save each chart to its own output filename
100
* Write up final Day 4/5 business findings and recommendations
101
102
This README will be updated as each of these steps is completed.
