# Final Worked — Project Documentation

**Prepared by:** Satyanarayan Baral — Data Analytics Intern, Infotact Solutions
**Duration:** Week 1 – Week 4 (1 month)
**Dataset scale:** 500 customer accounts • 5,000 subscription records • 2,000 support tickets • 600 churn events • 25,000 feature usage records

---

## 1. Project Summary

This project analyzes RavenStack's SaaS customer base end-to-end — from raw, messy CSV exports to a validated database, a full Customer Lifetime Value (CLTV) model, a cohort retention study, and a live Power BI support analytics dashboard — finishing with a business recommendation deck grounded entirely in the data.

The work was carried out in four weekly phases, each building on the previous one:

| Week | Focus | Tools |
|------|-------|-------|
| Week 1 | Data cleaning & validation | MySQL / SQL |
| Week 2 | Cohort retention analysis | Python (Pandas, Seaborn), Excel |
| Week 3 | Customer Lifetime Value (CLTV) analysis | Python (Pandas, Matplotlib, Seaborn) |
| Week 4 | Dashboard build + business storytelling | Power BI, Python, PowerPoint |

---

## 2. Week 1 — Data Cleaning with SQL

### Objective
Raw exports (`accounts`, `subscriptions`, `ravenstack_subscriptions`, `churn_events`, `feature_usage`, `tickets`) needed to be validated and cleaned in MySQL before any analysis could begin.

### Process
Each of the six datasets was loaded into a dedicated MySQL table via `LOAD DATA INFILE`, then run through a standard cleaning checklist:

- **Null audits** — counted nulls per column using `SUM(CASE WHEN ... IS NULL ...)` across every field.
- **Duplicate checks** — `GROUP BY <id> HAVING COUNT(*) > 1` on every primary key (`account_id`, `subscription_id`, `usage_id`, `ticket_id`, `churn_event_id`).
- **Referential integrity** — `LEFT JOIN` checks to confirm every `account_id` referenced in child tables (subscriptions, churn events) actually exists in `accounts`.
- **Logical validation** — checks such as `end_date < start_date`, negative `seats`/`mrr_amount`/`arr_amount`, and `error_count > usage_count`.
- **Category sanity checks** — `SELECT DISTINCT` on categorical fields (`plan_tier`, `industry`, `country`, `referral_source`, `priority`, `escalation_flag`, etc.) to catch inconsistent labels.
- **Date-format repair** — `ravenstack_subscriptions` had `start_date`/`end_date` stored as text in `DD-MM-YYYY` format; these were converted to proper `DATE` columns using `STR_TO_DATE`.
- **Duplicate resolution** — in `feature_usage`, real duplicate `usage_id`s were found and resolved by re-numbering each occurrence with `ROW_NUMBER() OVER (PARTITION BY usage_id ORDER BY usage_date)` and appending a `-dupN` suffix rather than silently dropping rows.
- **Data-integrity fix** — rows where `error_count > usage_count` (logically impossible) were corrected by capping `error_count` at `usage_count`.

### Known data quirks discovered (carried forward and documented for later weeks)
- Header rows were missing on some exports, requiring manual column naming.
- Every text field carried a stray `\r` character embedded in the value itself (not just a line ending), requiring stripping before any text-based grouping.
- `subscriptions_verified_clean.csv` had `end_date` relocated to the last column, with nulls written as the literal string `\N`.

### Outputs
- 6 SQL cleaning scripts (`accounts_cleaning.sql`, `subscriptions_cleaning.sql`, `ravenstack_subscriptions_cleaning.sql`, `churn_events_cleaning.sql`, `feature_usage_cleaning.sql`, `tickets_cleaning.sql`)
- 6 **verified clean CSV files** exported via `SELECT * INTO OUTFILE`, used as the single source of truth for every week that followed:
  - `accounts_verified_clean.csv`
  - `subscriptions_verified_clean.csv`
  - `ravenstack_subscriptions_verified_clean.csv`
  - `churn_events_verified_clean.csv`
  - `feature_usage_verified_clean.csv`
  - `tickets_verified_clean.csv`

Row counts were validated end-to-end: 500 accounts, 5,000 subscriptions, 600 churn events, 25,000 feature usage records, 2,000 tickets.

---

## 3. Week 2 — Cohort Retention Analysis

### Objective
Group customers into monthly acquisition cohorts (based on subscription start month) and track what percentage of each cohort was still active in each subsequent month, to understand *when* customers actually churn.

### Process
- Built a **CohortMonth** field from each account's first subscription date.
- Cross-tabulated active accounts by `CohortMonth` × `CohortIndex` (months since acquisition) to build a raw retention count matrix across **24 monthly cohorts** (Jan 2023 – Dec 2024).
- Converted raw counts into a **percentage retention matrix** (`retention_percentage_matrix.csv`), normalizing each cohort against its own starting size (Month 0 = 100%).
- Calculated an **average retention decay curve** across all cohorts (`monthly_retention.csv`) to find the overall shape of customer drop-off.
- Ranked cohorts by average retention to identify top- and bottom-performing acquisition months (`top_cohorts.csv`).
- Flagged high-value accounts for cross-reference with the Week 3 CLTV work (`high_value_customers.csv`).

### Key Finding
- **Month 0 retention is consistently strong** across all 24 cohorts (baseline validated).
- The **steepest decline happens in Month 1–2**, regardless of which month a customer was acquired in — average retention drops roughly 40 points between Month 0 and Month 1.
- **Retention stabilizes after Month 3** — customers who reach that point are far less likely to churn afterward.
- No single acquisition cohort significantly outperforms the others — the drop-off pattern is a product-level issue, not a seasonal one.

### Outputs
- `cohort_retention_matrix.csv` — raw retention counts, 24 cohorts × up to 23 months
- `retention_percentage_matrix.csv` — normalized retention percentages
- `monthly_retention.csv` — average retention rate by months-since-acquisition
- `top_cohorts.csv` — cohorts ranked by average retention
- `cohort_retention_analysis.xlsx` — Excel workbook version for stakeholder review
- Cohort retention heatmap (Blues color scale, annotated with retention %) — built in Week 4's notebook and reused in the final recommendation deck

---

## 4. Week 3 — Customer Lifetime Value (CLTV) Analysis

### Objective
Convert the retention behavior from Week 2 into a financial metric — quantify how much revenue each customer segment is actually worth over its lifetime.

### Formula Used
```
CLTV = Average Order Value (AOV) × Purchase Frequency × Average Customer Lifespan
```

### Process
1. Merged `subscriptions_verified_clean.csv` with `accounts_verified_clean.csv` on `account_id` to attach `referral_source`, `industry`, and `country` to every subscription row.
2. Calculated **customer lifespan** as days between `start_date` and `end_date` (or today's date for active subscriptions), converted to months (÷ 30.44).
3. Calculated **purchase frequency** as average subscription count per account, grouped by referral source.
4. Calculated **AOV** as average MRR per subscription, grouped by referral source and by plan tier.
5. Combined the three components into a single CLTV figure per segment (by acquisition channel, and separately by plan tier).
6. Classified all 500 individual accounts into **High / Medium / Low** value tiers using tercile splits (`pd.qcut`, q=3) on total historical MRR contribution — producing a near-even 3-way split (167 / 166 / 167 accounts).

### Key Results

**CLTV by Acquisition Channel**

| Referral Source | Avg. MRR (USD) | Purchase Freq. | Avg. Lifespan (months) | CLTV (USD) |
|---|---|---|---|---|
| Partner | 2,363.71 | 9.96 | ~22 | **~521,808** |
| Organic | 2,392.06 | 10.26 | ~20.7 | ~513,006 |
| Other | 2,315.22 | 9.97 | 21.30 | ~500,759 |
| Ads | 2,146.62 | 10.20 | 21.54 | ~480,343 |
| Event | 2,095.37 | 9.55 | 21.09 | **~429,866** |

**CLTV by Plan Tier**

| Plan Tier | Avg. MRR (USD) | Avg. Lifespan (months) | CLTV (USD) |
|---|---|---|---|
| Enterprise | 4,918 | ~21.3 | **~379,029** |
| Pro | 1,257 | ~21.4 | ~95,835 |
| Basic | 474 | ~21.6 | ~34,547 |

*(Note: figures were refined slightly between the Week 3 exploratory notebook and the Week 4 finalized numbers used in the recommendation deck; both versions are included in this repository — see `week3-cltv-analysis-documentation.md` for the full day-by-day breakdown and formula derivation.)*

### Key Findings
- **Partner-referred customers generate the highest lifetime value**, driven by longer retention (~22 months) rather than higher spend — organic customers actually have a slightly higher purchase frequency and AOV.
- **Event-acquired customers have the lowest CLTV**, mainly due to shorter average lifespan.
- **Plan tier is the dominant driver of CLTV, not retention.** Average lifespan is nearly identical across all three tiers (~21 months), so the ~11x CLTV gap between Enterprise and Basic is almost entirely explained by MRR (subscription price), not how long customers stay.
- Customer value segments (High/Medium/Low) split almost perfectly evenly, confirming the classification is statistically sound for use in targeting.

### Outputs
- `account_level_cltv.csv` — per-account CLTV and value segment
- `cltv_by_channel.csv` / `cltv_by_channel.png` — CLTV by acquisition channel (table + bar chart)
- `cltv_by_plan_tier.csv` — CLTV by plan tier
- `mrr-vs-lifespan.png` — scatter plot of MRR vs. lifespan, colored by plan tier
- `avg-mrr-heatmap.png` — MRR heatmap by plan tier × acquisition channel (identifies Enterprise-via-Partner as the single highest-value combination)
- `week3-cltv-analysis.ipynb` — full analysis notebook
- `week3-cltv-analysis-documentation.md` — detailed day-by-day methodology write-up

---

## 5. Week 4 — Dashboard Build & Business Recommendations

### Objective
Turn three weeks of analysis into (a) a live, interactive support operations dashboard for ongoing monitoring, and (b) a business recommendation deck for stakeholders.

### 5.1 Power BI Support Analytics Dashboard

Built in Power BI (`Support Analytics Dashboard.pbix`, exported as `.png` / `.pdf`) using the cleaned tickets, accounts, and subscriptions tables as the data model. The dashboard tracks:

- **Total tickets analyzed:** 2,000
- **Average resolution time:** 35.9 hours
- **Average first response time:** 88.5 minutes
- **Average satisfaction score:** 2.34 / 5
- Ticket volume, resolution time, and satisfaction broken out **by priority level** (Urgent / High / Medium / Low) and by month
- Escalation rate tracking

This is designed as a living operational dashboard — refreshable as new ticket data comes in — rather than a one-time report.

### 5.2 Consolidated Analysis Notebook (`complete-week4.ipynb`)

This notebook pulls together every prior week's output (`master_subscription_data.csv`, `retention_percentage_matrix.csv`, `high_value_customers.csv`, `top_cohorts.csv`, `monthly_retention.csv`) and produces the final polished visuals used in the recommendation deck:

1. **Cohort Retention Heatmap** — all 24 cohorts × retention period, annotated with percentages
2. **Average Retention Decay Curve** — with the Month 0→1 drop annotated directly on the chart
3. **Top 10 Cohorts Bar Chart** — ranked by average retention
4. **CLTV by Plan Tier + CLTV vs. Purchase Frequency scatter** — two-panel comparison
5. **Retention Rate by Plan Tier and by Industry** — side-by-side bar charts

### 5.3 Business Recommendations Deck (`RavenStack_Business_Recommendations.pptx`)

A 14-slide stakeholder presentation synthesizing all four weeks of findings into four concrete recommendations. Headline numbers used throughout:

- **Total MRR:** $11.3M across all subscriptions (avg. $2,268/subscription)
- **Enterprise concentration risk:** Enterprise accounts generate **74.7% of all MRR** despite being a minority of accounts — a concentration that is both an opportunity and a retention risk
- **Support quality gap:** urgent tickets resolve in 34.57 hrs vs. 36.35 hrs for low-priority tickets — a statistically negligible 1.8-hour difference, meaning there is effectively no working SLA today
- **Churn drivers:** Features (114 cases), Support (104), and Budget (104) together account for 53.7% of all 600 churn events — and the "Support" churn reason lines up directly with the 2.34/5 satisfaction score from the ticket data, confirming the same problem shows up independently in two different datasets

#### Recommendation 1 — Shift acquisition budget toward the Partner channel
Partner CLTV ($521,808) beats Event CLTV ($429,866) by ~21% per customer, driven by retention length, not spend. Action: audit current channel budget allocation against CLTV-per-channel and reallocate toward partner/affiliate development where budget is currently skewed toward lower-CLTV channels (Event, Ads).

#### Recommendation 2 — Build an aggressive Pro-to-Enterprise upsell program
Since lifespan is nearly flat across tiers (~21 months), retention campaigns cannot close the CLTV gap — only tier upgrades can. Moving one customer from Pro to Enterprise adds an estimated **$283,000** in lifetime value. Action: target Pro accounts with high seat counts and usage at capacity for a guided Enterprise trial.

#### Recommendation 3 — Implement priority-based SLAs in support
There is currently no meaningful difference in resolution time by ticket priority. Action: introduce explicit SLA targets (e.g., Urgent: <2 hr first response / <8 hr resolution; Low: <24 hr / <72 hr) so that Enterprise and Urgent tickets are actually treated as priority.

#### Recommendation 4 — Intercept churn before it happens
Four concrete tactics, all evidence-based:
1. Launch a Month-1 onboarding sequence, timed to hit before the steepest retention drop (Month 1–2).
2. Fix product feature gaps before considering price-based retention tactics (features is the #1 churn reason).
3. Use support ticket escalations/low satisfaction as an early-warning signal for proactive Customer Success outreach.
4. Give the 167 High-value accounts (top CLTV tercile) a dedicated retention track — proactive reviews, executive sponsorship, priority support routing.

### Outputs
- `Support Analytics Dashboard.pbix` / `.pdf` / `.png` — live Power BI dashboard
- `complete-week4.ipynb` — consolidated visualization notebook
- `RavenStack_Business_Recommendations.pptx` — 14-slide stakeholder recommendation deck
- Supporting charts: `cohort_retention_heatmap_final.png`, `retention_decay_curve.png`, `top_cohorts_bar.png`, `cltv_analysis.png`, `retention_by_segment.png`

---

## 6. Overall Business Value

Taken together, the four weeks form a single analytical pipeline: **clean data → understand retention behavior → quantify that behavior in dollar terms (CLTV) → operationalize it into a live dashboard and four specific, numbers-backed recommendations.**

This gives RavenStack's leadership:
- A defensible basis for setting **maximum acceptable Customer Acquisition Cost (CAC) by channel**, using real CLTV figures rather than assumptions.
- A ranked list of **which customer segments to prioritize** for retention and upsell investment.
- A **live support operations dashboard** to monitor whether SLA and satisfaction improvements are actually working.
- Four recommendations that are each traceable back to a specific number in the underlying 500-account, 5,000-subscription, 2,000-ticket, 600-churn-event dataset — not general SaaS best practices, but findings specific to RavenStack's own data.

---

## 7. Repository / File Index

```
├── README.md                                    ← this file
├── csv-cleaning-with-sql/
│   ├── SQL files/                                ← 6 cleaning scripts (Week 1)
│   ├── Cleaned files from week 1 work/            ← intermediate cleaned CSVs
│   └── Verified cleaned files/                    ← final verified CSVs (source of truth for Weeks 2–4)
├── Week 2 (Cohort Retention Matrix)/
│   └── cohort/retention matrices, Excel workbook
├── using-datasets-week3-work/
│   ├── complete-week4.ipynb                       ← consolidated Week 4 visualization notebook
│   ├── cohort_retention_matrix.csv / monthly_retention.csv / cohort_retention_analysis.xlsx
│   └── account_level_cltv.csv, cltv_by_channel.csv, cltv_by_plan_tier.csv + charts
├── week3-cltv-analysis/
│   ├── week3-cltv-analysis.ipynb                  ← Week 3 CLTV notebook
│   ├── week3-cltv-analysis-documentation.md       ← detailed day-by-day CLTV write-up
│   └── supporting charts (cltv_by_channel, mrr-vs-lifespan, avg-mrr-heatmap)
├── Support Analytics Dashboard.pbix / .pdf / .png  ← Week 4 Power BI dashboard
└── RavenStack_Business_Recommendations.pptx        ← Week 4 final stakeholder deck
```
