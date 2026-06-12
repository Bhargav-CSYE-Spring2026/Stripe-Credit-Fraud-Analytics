
    
    



select txn_date
from `stripe-fraud-analytics`.`dbt_ci_marts`.`fct_fraud_daily`
where txn_date is null


