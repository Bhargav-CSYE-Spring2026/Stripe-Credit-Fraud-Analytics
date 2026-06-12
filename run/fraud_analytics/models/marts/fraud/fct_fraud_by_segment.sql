
  
    

    create or replace table `stripe-fraud-analytics`.`dbt_ci_marts`.`fct_fraud_by_segment`
      
    
    

    
    OPTIONS()
    as (
      with segments as (
    select * from `stripe-fraud-analytics`.`dbt_ci_intermediate`.`int_amount_segments`
)

select
    amount_segment,
    time_of_day,
    total_transactions,
    fraud_count,
    total_amount_eur,
    fraud_rate,
    safe_divide(
        fraud_count, sum(fraud_count) over ()
    )                                                   as pct_of_total_fraud,
    safe_divide(
        total_transactions, sum(total_transactions) over ()
    )                                                   as pct_of_total_transactions
from segments
order by fraud_rate desc
    );
  