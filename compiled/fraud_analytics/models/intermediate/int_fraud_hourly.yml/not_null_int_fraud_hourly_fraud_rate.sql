
    
    



select fraud_rate
from `stripe-fraud-analytics`.`dbt_ci_intermediate`.`int_fraud_hourly`
where fraud_rate is null


