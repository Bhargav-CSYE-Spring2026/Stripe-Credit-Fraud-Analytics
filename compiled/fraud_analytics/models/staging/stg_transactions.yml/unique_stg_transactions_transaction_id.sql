
    
    

with dbt_test__target as (

  select transaction_id as unique_field
  from `stripe-fraud-analytics`.`dbt_ci_staging`.`stg_transactions`
  where transaction_id is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


