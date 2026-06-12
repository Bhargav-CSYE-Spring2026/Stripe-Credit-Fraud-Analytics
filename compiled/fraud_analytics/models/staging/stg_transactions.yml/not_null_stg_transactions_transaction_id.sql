
    
    



select transaction_id
from `stripe-fraud-analytics`.`dbt_ci_staging`.`stg_transactions`
where transaction_id is null


