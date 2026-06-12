
    
    



select daily_fraud_count
from `stripe-fraud-analytics`.`dbt_ci_marts`.`fct_fraud_daily`
where daily_fraud_count is null


