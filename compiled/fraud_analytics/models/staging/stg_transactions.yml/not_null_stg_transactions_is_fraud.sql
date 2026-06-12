
    
    



select is_fraud
from `stripe-fraud-analytics`.`dbt_ci_staging`.`stg_transactions`
where is_fraud is null


