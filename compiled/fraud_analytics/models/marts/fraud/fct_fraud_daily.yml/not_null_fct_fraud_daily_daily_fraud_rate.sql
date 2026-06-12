
    
    



select daily_fraud_rate
from `stripe-fraud-analytics`.`dbt_ci_marts`.`fct_fraud_daily`
where daily_fraud_rate is null


