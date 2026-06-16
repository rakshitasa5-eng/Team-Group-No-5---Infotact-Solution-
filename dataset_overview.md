# Ravenstack Dataset Overview

## Purpose

This document describes the datasets used in the SaaS Cohort Retention and Customer Lifetime Value (CLTV) Analysis project.

## Dataset Files

| File Name                      | Purpose                                                               |
| ------------------------------ | --------------------------------------------------------------------- |
| ravenstack_accounts.csv        | Contains customer account information and account identifiers.        |
| ravenstack_subscriptions.csv   | Contains subscription history, plan information, and revenue metrics. |
| ravenstack_churn_events.csv    | Records customer churn events and churn dates.                        |
| ravenstack_feature_usage.csv   | Tracks product feature usage and customer engagement.                 |
| ravenstack_support_tickets.csv | Contains customer support interactions and ticket history.            |

## Why These Files Matter

* Accounts → customer information
* Subscriptions → retention and revenue analysis
* Churn Events → churn analysis
* Feature Usage → customer engagement analysis
* Support Tickets → customer satisfaction indicators

## Dataset Relationships

All datasets are connected using a common customer/account identifier.

Accounts
├── Subscriptions
├── Churn Events
├── Feature Usage
└── Support Tickets

## Project Usage

These datasets will be used for:

* Cohort Retention Analysis
* Customer Churn Analysis
* Customer Lifetime Value (CLTV) Calculation
* Customer Segmentation

Documentation Note

This document provides an overview of the datasets used in the project and explains how they support the analytical workflow.
