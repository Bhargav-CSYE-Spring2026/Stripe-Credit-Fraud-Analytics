# Stripe Credit Fraud Analytics

A dbt-native analytics platform built on BigQuery analyzing the ULB Credit Card Fraud dataset (284,807 transactions). Implements medallion architecture (staging → intermediate → marts), dbt Semantic Layer with MetricFlow, and full CI/CD via GitHub Actions.

## Tech Stack
- Warehouse: BigQuery (Google Cloud free tier)
- Transformation: dbt Core + dbt Cloud
- Data quality: dbt tests + dbt-expectations
- Semantic layer: MetricFlow (dbt Semantic Layer)
- CI/CD: GitHub Actions
- BI: Looker Studio, Tableau Public, Power BI

## Dataset
ULB Credit Card Fraud Detection — 284,807 transactions, 492 fraud cases (0.172%), September 2013.
