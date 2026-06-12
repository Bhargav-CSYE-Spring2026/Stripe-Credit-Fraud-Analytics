
    
    



select transaction_timestamp
from `stripe-fraud-analytics`.`dbt_ci_staging`.`stg_transactions`
where transaction_timestamp is null


