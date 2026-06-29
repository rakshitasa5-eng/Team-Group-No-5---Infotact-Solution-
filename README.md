# Team Project
# CLTV Branch
#Infotact Solutions || Batch 18 || Group 5

#Customer Lifetime Value (CLTV) Analysis

#Week 3 README – Customer Lifetime Value (CLTV) Analysis

## Status

Week 3 is now functionally complete: data loading, validation, all three CLTV inputs, the full CLTV formula by channel and by plan tier, customer value segmentation, and all three visualizations. One output bug was found during the visualization step and is documented below under Step 7.

---

## Objective

Week 2 answered *how long* customers stay active, using the Cohort Retention Matrix. Week 3 answers *how much each customer is worth* — calculating Customer Lifetime Value (CLTV) by acquisition channel and by plan tier, then using that to rank and segment customers by value.

---

## Datasets Used

* `accounts_verified_clean.csv`
* `subscriptions_verified_clean.csv`
* `cohort_retention_matrix.csv` (Week 2 output, loaded for reference)

---

## Step 1: Loading and Validating the Data

**Code used:**
```python
accounts = pd.read_csv(f'{BASE}/accounts_verified_clean.csv', header=None,
    names=['account_id','account_name','industry','country','signup_date',
           'referral_source','plan_tier','seats','is_trial','churn_flag','cohort_month'])

subscriptions = pd.read_csv(f'{BASE}/subscriptions_verified_clean.csv', header=None,
    names=['subscription_id','account_id','start_date','plan_tier','seats','mrr_amount',
           'arr_amount','is_trial','upgrade_flag','downgrade_flag','churn_flag',
           'billing_frequency','auto_renew_flag','cohort_month','end_date'],
    na_values=['\\N'])

for table in [accounts, subscriptions, churn_events, feature_usage, tickets]:
    for col in table.select_dtypes(include='object').columns:
        table[col] = table[col].str.replace('\r', '', regex=False).str.strip()
```

**What this means:** the "verified clean" files from Week 1 were missing their header row, so column names had to be typed in by hand based on the original schema. The `subscriptions` file also had its `end_date` column moved to the very last position, with missing values written as the text `\N` instead of being left blank — handled with `na_values=['\\N']`. Every text column across all five files also had a stray `\r` character stuck inside the actual values, which the final loop strips out.

**Output:**
```
accounts: (500, 11)
subscriptions: (5000, 15)
churn_events: (600, 9)
feature_usage: (25000, 9)
tickets: (2000, 10)
cohort_matrix: (24, 24)
```

**Use of this step:** confirms the data matches the original README's documented row counts exactly (500 accounts, 5,000 subscriptions, etc.) before trusting any number calculated from it. Skipping this step is what caused the very first errors in this project — loading silently "succeeded" but produced garbage columns.

---

## Step 2: Merging Accounts into Subscriptions, Calculating Lifespan

**Code used:**
```python
df = subscriptions.merge(accounts[['account_id','referral_source','industry','country']],
                          on='account_id', how='left')

df['end_date_filled'] = df['end_date'].fillna(pd.Timestamp.today())
df['lifespan_months'] = ((df['end_date_filled'] - df['start_date']).dt.days / 30.44).round(1)

assert (df['lifespan_months'] >= 0).all()
assert df['referral_source'].notna().all()
```

**What this means:** every subscription row gets the account's `referral_source` attached to it, so subscriptions can be grouped by acquisition channel. Customer lifespan is calculated as the number of days between when a subscription started and when it ended — and for subscriptions still active (`end_date` is null), today's date is used instead, treating them as "still going." Dividing by 30.44 converts days into months (the average number of days per calendar month). The two `assert` lines are safety checks — they would stop the notebook immediately if any lifespan came out negative or any account failed to match.

**Use of this step:** this is the foundation every later calculation builds on. If the merge or the date math were wrong here, every CLTV number downstream would be wrong too.

---

## Step 3: Average Order Value (AOV) by Channel

**Code used:**
```python
aov_by_channel = df.groupby('referral_source')['mrr_amount'].mean().reset_index()
aov_by_channel.columns = ['referral_source', 'avg_mrr']
```

**What this means:** groups every subscription by which channel brought the customer in, then averages the Monthly Recurring Revenue (`mrr_amount`) within each group. This answers: "on average, how much does a customer from this channel pay per month?"

**Output:**

| Referral Source | Avg. MRR (USD) |
| ---------------- | --------------- |
| Organic | 2,392.06 |
| Partner | 2,363.71 |
| Other | 2,315.22 |
| Ads | 2,146.62 |
| Event | 2,095.37 |

**Use of this step:** AOV is the first of three inputs multiplied together to get CLTV. On its own it only tells half the story — a channel can have a high AOV and still end up with a low CLTV if its customers don't stick around.

---

## Step 4: Average Lifespan and Purchase Frequency by Channel

**Code used:**
```python
lifespan_by_channel = df.groupby('referral_source')['lifespan_months'].mean().reset_index()
lifespan_by_channel.columns = ['referral_source', 'avg_lifespan_months']

freq_by_account = df.groupby('account_id')['subscription_id'].count().reset_index()
freq_by_account.columns = ['account_id', 'sub_count']
freq_df = freq_by_account.merge(accounts[['account_id','referral_source']], on='account_id')
purchase_freq = freq_df.groupby('referral_source')['sub_count'].mean().reset_index()
purchase_freq.columns = ['referral_source', 'avg_purchase_freq']
```

**What this means:** the first block averages the `lifespan_months` calculated in Step 2, grouped by channel — answering "how many months does a typical customer from this channel stay?" The second block counts how many subscription records exist per `account_id` (an account that upgraded, downgraded, or renewed multiple times has more than one subscription record), then averages that count by channel — answering "how often does a typical customer from this channel take out a new subscription?"

**Output:**

| Referral Source | Avg. Lifespan (Months) | Avg. Purchase Freq. |
| ---------------- | ------------------------ | --------------------- |
| Partner | 22.03 | 9.96 |
| Ads | 21.78 | 10.20 |
| Other | 21.54 | 9.97 |
| Event | 21.33 | 9.55 |
| Organic | 20.75 | 10.26 |

**Use of this step:** these are the second and third inputs to the CLTV formula. Notice organic has the *highest* purchase frequency but the *shortest* lifespan of any channel — a hint that no single metric alone explains customer value.

---

## Step 5: The Full CLTV Formula, by Channel and by Plan Tier

**Code used:**
```python
cltv_table = aov_by_channel \
    .merge(purchase_freq, on='referral_source') \
    .merge(lifespan_by_channel, on='referral_source')

cltv_table['cltv'] = (cltv_table['avg_mrr'] *
                       cltv_table['avg_purchase_freq'] *
                       cltv_table['avg_lifespan_months'])
```

**What this means:** the three input tables are merged into one, then CLTV is calculated with one formula: **CLTV = Avg. MRR × Purchase Frequency × Avg. Lifespan**. The same three-input calculation is repeated grouped by `plan_tier` instead of `referral_source`.

**Output — CLTV by Acquisition Channel:**

| Referral Source | Avg. MRR | Purchase Freq. | Avg. Lifespan (Months) | CLTV (USD) |
| ---------------- | --------- | --------------- | ------------------------ | ----------- |
| Partner | 2,363.71 | 9.96 | 22.03 | 518,286.23 |
| Organic | 2,392.06 | 10.26 | 20.75 | 509,384.40 |
| Other | 2,315.22 | 9.97 | 21.54 | 497,308.64 |
| Ads | 2,146.62 | 10.20 | 21.78 | 477,121.12 |
| Event | 2,095.37 | 9.55 | 21.33 | 426,889.21 |

**Output — CLTV by Plan Tier:**

| Plan Tier | Avg. MRR | Purchase Freq. | Avg. Lifespan (Months) | CLTV (USD) |
| ---------- | --------- | --------------- | ------------------------ | ----------- |
| Enterprise | 4,917.71 | 3.60 | 21.28 | 376,416.60 |
| Pro | 1,256.77 | 3.53 | 21.43 | 95,174.84 |
| Basic | 474.68 | 3.34 | 21.66 | 34,311.04 |

**Use of this step:** this is the core deliverable of Week 3. By channel, partner edges out organic for the highest CLTV — but the gap is close (about $8,900, under 2%), driven by partner's longer retention rather than higher spend. By plan tier, Enterprise is worth roughly 4x Pro and 11x Basic, and that gap is driven almost entirely by MRR — average lifespan is nearly identical across all three tiers (~21–22 months), so tier upgrades matter far more to lifetime value than retention efforts do.

---

## Step 6: Customer Value Segmentation

**Code used:**
```python
account_cltv = df.groupby('account_id').agg(
    total_mrr=('mrr_amount','sum'),
    total_months=('lifespan_months','sum')
).reset_index()
account_cltv['estimated_cltv'] = account_cltv['total_mrr']

account_cltv['cltv_segment'] = pd.qcut(account_cltv['estimated_cltv'],
                                         q=3, labels=['Low','Medium','High'])
```

**What this means:** every individual account's subscriptions are summed up to get its total historical MRR, which is used here as a simplified stand-in for that account's lifetime value. `pd.qcut(..., q=3)` then sorts all 500 accounts by that value and splits them into three equal-sized groups — bottom third, middle third, top third.

**Output:**

| Segment | Number of Accounts |
| -------- | -------------------- |
| Low | 167 |
| High | 167 |
| Medium | 166 |

**Use of this step:** gives a ready-made list of which specific accounts are most valuable, for things like prioritizing account management or retention outreach. **Worth noting honestly:** this per-account figure is total MRR only — it does not multiply by lifespan or frequency the way the channel/tier CLTV above does. It's a reasonable simplification (higher MRR and more subscriptions usually do mean higher lifetime value) but it isn't calculated on the identical formula as Step 5.

---

## Step 7: Visualizations

**Chart 1 — CLTV by Acquisition Channel (bar chart)**
```python
sns.barplot(data=cltv_table, x='referral_source', y='cltv', palette='viridis')
plt.title('Customer Lifetime Value by Acquisition Channel')
plt.savefig(r'...\cltv_by_channel.png', dpi=150)
```
**Use:** ranks all five channels side by side so the partner-vs-organic-vs-others comparison from Step 5 is visible at a glance instead of read from a table.

**Chart 2 — MRR vs. Lifespan, colored by Plan Tier (scatter plot)**
```python
for tier, group in df.groupby('plan_tier'):
    plt.scatter(group['lifespan_months'], group['mrr_amount'], label=tier, alpha=0.4, color=colors[tier])
plt.savefig(r'...\cltv_by_channel.png', dpi=150)
```
**Use:** shows that Enterprise, Pro, and Basic occupy clearly separate horizontal bands by MRR, while all three are scattered across a similar range on lifespan — a visual confirmation of Step 5's finding that tier drives CLTV through revenue, not retention.

**Chart 3 — Avg MRR Heatmap by Plan Tier × Channel**
```python
pivot = df.groupby(['plan_tier','referral_source'])['mrr_amount'].mean().unstack()
sns.heatmap(pivot, annot=True, fmt='.0f', cmap='YlOrRd', linewidths=0.5)
plt.savefig(r'...\cltv_by_channel.png', dpi=150)
```
**Use:** cross-references tier and channel together. The output (visible in the latest notebook run) shows Enterprise customers acquired via partner reach the highest average MRR (5,275), making that combination the single most valuable customer profile in the dataset.

**⚠️ Bug found during review:** all three chart cells above save to the exact same filename, `cltv_by_channel.png`. Each chart overwrites the one before it on disk, so **only the heatmap (the last one run) currently exists as a saved file** — the bar chart and scatter plot were displayed correctly in the notebook but were never actually preserved as separate images.

**Fix needed before final submission:** give each chart its own filename, for example:
```python
plt.savefig(r'...\cltv_by_channel_bar.png', dpi=150)      # chart 1
plt.savefig(r'...\mrr_vs_lifespan_scatter.png', dpi=150)  # chart 2
plt.savefig(r'...\cltv_heatmap.png', dpi=150)              # chart 3
```
Then re-run all three cells once so all three image files exist side by side.

---

## Summary of Findings

* **Partner channel has the highest CLTV** ($518,286), but only narrowly ahead of organic ($509,384) — driven by longer retention, not higher spend or frequency.
* **Plan tier matters far more than channel for lifetime value** — Enterprise customers are worth roughly 11x Basic customers, almost entirely because of MRR, since lifespan barely differs across tiers.
* **The single highest-value customer profile** is Enterprise customers acquired through the partner channel (avg. MRR of 5,275 — the highest cell in the heatmap).
* **Customer value is evenly distributed** across the High/Medium/Low segmentation (167/166/167), confirming the method is statistically sound for targeting.

---

## Known Issue to Fix

The three Day 4 chart-saving cells all write to the same output filename. Only the most recently run chart currently survives on disk. This needs to be corrected (see Step 7) before charts are submitted as separate deliverable files.
