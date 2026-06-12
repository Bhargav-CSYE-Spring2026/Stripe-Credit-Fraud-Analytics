with hourly as (
    select * from `stripe-fraud-analytics`.`dbt_ci_intermediate`.`int_fraud_hourly`
),

daily as (
    select
        txn_date,
        sum(total_transactions)                         as daily_transactions,
        sum(fraud_transactions)                         as daily_fraud_count,
        sum(total_amount_eur)                           as daily_volume_eur,
        sum(fraud_amount_eur)                           as daily_fraud_amount_eur,
        avg(fraud_rate)                                 as avg_hourly_fraud_rate,
        max(fraud_rate)                                 as peak_hourly_fraud_rate,
        min(fraud_rate)                                 as min_hourly_fraud_rate,
        count(distinct hour_of_day)                     as active_hours
    from hourly
    group by 1
)

select
    txn_date,
    daily_transactions,
    daily_fraud_count,
    daily_volume_eur,
    daily_fraud_amount_eur,
    avg_hourly_fraud_rate,
    peak_hourly_fraud_rate,
    min_hourly_fraud_rate,
    active_hours,
    safe_divide(
        daily_fraud_count, daily_transactions
    )                                                   as daily_fraud_rate,
    safe_divide(
        daily_fraud_amount_eur, daily_volume_eur
    )                                                   as daily_fraud_amount_rate
from daily
order by txn_date