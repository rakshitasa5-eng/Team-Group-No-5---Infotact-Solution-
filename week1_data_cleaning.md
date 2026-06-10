Started 1st Week Project - SaaS subscription dataset

Step 1: Load Dataset

  import pandas as pd
  import os
    print(os.getcwd())
  df = pd.read_csv(r"C:\Users\raksh\Downloads\Infotect Project 2026\ravenstack_subscriptions.csv")
    df.head()

step 2: Explore Dataset

  df.info()
  df.shape

Step 3: Check Missing Values

  df.isnull().sum()
  df = df.dropna(subset=['account_id'])  # Removing Missing Account IDs
