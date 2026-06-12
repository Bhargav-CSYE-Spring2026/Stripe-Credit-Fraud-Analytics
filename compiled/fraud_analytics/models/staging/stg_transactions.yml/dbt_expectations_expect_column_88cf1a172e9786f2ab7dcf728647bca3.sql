






    with grouped_expression as (
    select
        
        
    
  
( 1=1 and transaction_amount_eur >= 0 and transaction_amount_eur <= 30000
)
 as expression


    from `stripe-fraud-analytics`.`dbt_ci_staging`.`stg_transactions`
    

),
validation_errors as (

    select
        *
    from
        grouped_expression
    where
        not(expression = true)

)

select *
from validation_errors







