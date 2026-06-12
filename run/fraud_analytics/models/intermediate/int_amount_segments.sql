

  create or replace view `stripe-fraud-analytics`.`dbt_ci_intermediate`.`int_amount_segments`
  OPTIONS()
  as with transactions as (
    select * from `stripe-fraud-analytics`.`dbt_ci_staging`.`stg_transactions`
),

segmented as (
    select
        transaction_id,
        transaction_timestamp,
        transaction_amount_eur,
        is_fraud,
        case
            when transaction_amount_eur = 0        then 'zero'
            when transaction_amount_eur < 10       then 'micro'
            when transaction_amount_eur < 100      then 'small'
            when transaction_amount_eur < 1000     then 'medium'
            else                                        'large'
        end                                             as amount_segment,
        case
            when extract(hour from transaction_timestamp)
                between 6 and 11                    then 'morning'
            when extract(hour from transaction_timestamp)
                between 12 and 17                   then 'afternoon'
            when extract(hour from transaction_timestamp)
                between 18 and 22                   then 'evening'
            else                                        'night'
        end                                             as time_of_day
    from transactions
)

select
    amount_segment,
    time_of_day,
    count(*)                                            as total_transactions,
    countif(is_fraud = 1)                               as fraud_count,
    sum(transaction_amount_eur)                         as total_amount_eur,
    safe_divide(
        countif(is_fraud = 1), count(*)
    )                                                   as fraud_rate
from segmented
group by 1, 2;

