# Stripe Credit Fraud Analytics

A dbt-native analytics platform built on BigQuery analyzing the ULB Credit Card Fraud dataset (284,807 transactions). Implements medallion architecture (staging → intermediate → marts), dbt Semantic Layer with MetricFlow, and full CI/CD via GitHub Actions.

## Architecture
Raw (BigQuery) → Staging → Intermediate → Marts → Semantic Layer → BI

## Tech Stack
| Layer | Tool |
|---|---|
| Warehouse | BigQuery (Google Cloud) |
| Transformation | dbt Core 1.11.6 |
| Data quality | dbt tests + dbt-expectations |
| Semantic layer | MetricFlow (dbt Semantic Layer) |
| CI/CD | GitHub Actions |
| BI | Looker Studio, Tableau Public |

## Dataset
ULB Credit Card Fraud Detection — 284,807 transactions, 492 fraud cases (0.172%), September 2013.
Source: https://www.kaggle.com/datasets/mlg-ulb/creditcardfraud

## Models
- Staging: 1 model (stg_transactions)
- Intermediate: 2 models (int_fraud_hourly, int_amount_segments)
- Marts: 3 models (dim_dates, fct_fraud_daily, fct_fraud_by_segment)
- Total: 6 models, 19 tests — all passing

## Key Findings
- 773 duplicate rows found in raw data — handled via row_number() deduplication in staging
- Fraud rate: 0.172% (492 out of 284,807 transactions)
- Fraud concentrated in micro and small transaction segments
