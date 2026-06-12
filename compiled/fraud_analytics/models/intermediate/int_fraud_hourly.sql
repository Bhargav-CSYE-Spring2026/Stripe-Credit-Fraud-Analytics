with transactions as (
    select * from `stripe-fraud-analytics`.`dbt_ci_staging`.`stg_transactions`
),

hourly as (
    select
        timestamp_trunc(transaction_timestamp, hour)        as hour,
        date(transaction_timestamp)                         as txn_date,
        extract(hour from transaction_timestamp)            as hour_of_day,
        count(*)                                            as total_transactions,
        countif(is_fraud = 1)                               as fraud_transactions,
        sum(transaction_amount_eur)                         as total_amount_eur,
        sum(case when is_fraud = 1
            then transaction_amount_eur else 0 end)         as fraud_amount_eur,
        avg(transaction_amount_eur)                         as avg_transaction_amount,
        max(transaction_amount_eur)                         as max_transaction_amount
    from transactions
    group by 1, 2, 3
)

select
    *,
    safe_divide(fraud_transactions, total_transactions)     as fraud_rate,
    safe_divide(fraud_amount_eur, total_amount_eur)         as fraud_amount_rate
from hourly