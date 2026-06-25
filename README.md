# Team Project
# CLTV Branch
#Infotact Solutions || Batch 18 || Group 5

#Customer Lifetime Value (CLTV) Analysis

Week 3 README – CLTV Analysis (In Progress)
Status
This README reflects Week 3 progress through Day 2 — data loading, validation, and Average Order Value (AOV) calculation. The full CLTV formula (AOV × Purchase Frequency × Average Lifespan), segment tables, customer value tiering, and visualizations are not yet complete and will be added as the week continues.

Objective
Week 3 builds on the Cohort Retention Matrix delivered in Week 2. While Week 2 answered how long customers stay active, Week 3's goal is to answer how much each customer is worth — calculating Customer Lifetime Value (CLTV) across acquisition channels and plan tiers.

This README currently covers the first building block of that formula: Average Order Value (AOV).

Datasets Used So Far
accounts_verified_clean.csv
subscriptions_verified_clean.csv
These two files were merged on account_id to attach each subscription record to its account-level referral_source, industry, and country.

Data Validation
Before calculating anything, the verified/cleaned files were checked against the original schema and found to differ in a few ways:

The header row was missing from the CSV exports; column names were supplied manually based on the documented schema.
String fields contained a stray carriage-return character (\r) embedded inside the values themselves, which was stripped before any calculations.
In subscriptions_verified_clean.csv, the end_date column had been moved to the last position, with null values written as the literal string \N instead of being left blank.
Row counts were checked against the original README and confirmed correct: 500 accounts and 5,000 subscription records.

What Is AOV, in This Context
Average Order Value (AOV) in a subscription business is the average recurring revenue a customer generates per billing period — in this dataset, that's the average mrr_amount (Monthly Recurring Revenue) across subscriptions.

AOV is the first of three inputs needed for the CLTV formula:

CLTV = AOV × Purchase Frequency × Average Customer Lifespan

Purchase frequency and average lifespan have not been calculated yet as of this README.

AOV by Acquisition Channel
AOV was calculated by grouping all subscription records by referral_source and averaging mrr_amount within each group.

Referral Source	Avg. MRR (USD)
Organic	2,392.06
Partner	2,363.71
Other	2,315.22
Ads	2,146.62
Event	2,095.37
Early observation: organic and partner-acquired customers currently show the highest average monthly revenue, while event-acquired customers show the lowest. This is only one piece of the CLTV picture — channels with a high AOV could still end up with lower lifetime value once retention and purchase frequency are factored in, or vice versa.

Next Steps
Calculate average customer lifespan per channel (using start_date and end_date)
Calculate purchase frequency per channel (subscriptions per account)
Combine all three inputs into the full CLTV formula
Repeat the analysis by plan tier (Basic, Pro, Enterprise)
Classify individual accounts into High / Medium / Low value tiers
Build supporting visualizations (bar chart, scatter plot, heatmap)
This README will be updated as each of these steps is completed.


















