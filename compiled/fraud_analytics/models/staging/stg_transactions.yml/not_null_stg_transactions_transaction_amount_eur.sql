
    
    



select transaction_amount_eur
from `stripe-fraud-analytics`.`dbt_ci_staging`.`stg_transactions`
where transaction_amount_eur is null


