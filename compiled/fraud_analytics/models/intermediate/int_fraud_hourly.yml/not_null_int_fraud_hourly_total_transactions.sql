
    
    



select total_transactions
from `stripe-fraud-analytics`.`dbt_ci_intermediate`.`int_fraud_hourly`
where total_transactions is null


