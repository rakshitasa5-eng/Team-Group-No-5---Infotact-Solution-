# Team Project
# CLTV Branch
#Infotact Solutions || Batch 18 || Group 5

#Customer Lifetime Value (CLTV) Analysis

 Week 3 README – CLTV Analysis (In Progress)

 Status

 This README reflects Week 3 progress through Day 2 — data loading, validation, AOV, average customer lifespan, and purchase frequency calculation. The full CLTV formula (AOV × Purchase Frequency × Average Lifespan), segment tables, customer value tiering, and visualizations are not yet complete and will be added as the week continues.

  ---

  ## Objective

   Week 3 builds on the Cohort Retention Matrix delivered in Week 2. While Week 2 answered *how long* customers stay active, Week 3's goal is to answer *how much each customer is worth* — calculating Customer Lifetime Value (CLTV) across acquisition channels and plan tiers.

   This README currently covers all three building blocks of the CLTV formula, calculated by acquisition channel. They have not yet been combined into a final CLTV number.

   ---

   ## Datasets Used So Far

  * `accounts_verified_clean.csv`
  * `subscriptions_verified_clean.csv`

    These two files were merged on `account_id` to attach each subscription record to its account-level `referral_source`, `industry`, and `country`.

    ---

    ## Data Validation

    Before calculating anything, the verified/cleaned files were checked against the original schema and found to differ in a few ways:

    * The header row was missing from the CSV exports; column names were supplied manually based on the documented schema.
    * String fields contained a stray carriage-return character (`\r`) embedded inside the values themselves, which was stripped before any calculations.
    * In `subscriptions_verified_clean.csv`, the `end_date` column had been moved to the last position, with null values written as the literal string `\N` instead of being left blank.

    Row counts were checked against the original README and confirmed correct: 500 accounts and 5,000 subscription records.

    ---

    ## The Three Inputs to CLTV

    CLTV is calculated as:

    **CLTV = Average Order Value × Purchase Frequency × Average Customer Lifespan**

    All three inputs have now been calculated by acquisition channel.

    ---

    ## 1. Average Order Value (AOV)

    AOV is the average recurring revenue a customer generates per billing period — calculated here as the average `mrr_amount` (Monthly Recurring Revenue) across subscriptions, grouped by `referral_source`.

    | Referral Source | Avg. MRR (USD) |
    | ---------------- | --------------- |
    | Organic | 2,392.06 |
    | Partner | 2,363.71 |
    | Other | 2,315.22 |
    | Ads | 2,146.62 |
    | Event | 2,095.37 |

    ---

    ## 2. Average Customer Lifespan

    Lifespan was calculated as the number of days between `start_date` and `end_date` (or today's date, for subscriptions still active), divided by 30.44 to convert days into months.

    | Referral Source | Avg. Lifespan (Months) |
    | ---------------- | ------------------------ |
    | Partner | 21.94 |
    | Ads | 21.69 |
    | Other | 21.45 |
    | Event | 21.24 |
    | Organic | 20.66 |

    **Early observation:** partner-referred customers have the longest average lifespan, while organic customers — despite having a strong AOV — have the shortest. This already hints that AOV alone won't tell the full CLTV story.

    ---

    ## 3. Purchase Frequency

    Purchase frequency was calculated as the average number of subscription records per account, grouped by `referral_source`.

    | Referral Source | Avg. Subscriptions per Account |
    | ---------------- | -------------------------------- |
    | Ads | 10.20 |
    | Event | *pending* |
    | Organic | *pending* |
    | Other | *pending* |
    | Partner | *pending* |

    *Table will be completed once the remaining four rows are confirmed from notebook output.*

    ---

    ## Next Steps

    * Confirm and fill in the remaining purchase frequency values above
    * Combine AOV, lifespan, and purchase frequency into the full CLTV formula
    * Build the CLTV segment table by acquisition channel
    * Repeat the full analysis by plan tier (`Basic`, `Pro`, `Enterprise`)
    * Classify individual accounts into High / Medium / Low value tiers
    * Build supporting visualizations (bar chart, scatter plot, heatmap)

    This README will be updated as each of these steps is completed.

