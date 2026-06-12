
    
    

with dbt_test__target as (

  select txn_date as unique_field
  from `stripe-fraud-analytics`.`dbt_ci_marts`.`fct_fraud_daily`
  where txn_date is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


