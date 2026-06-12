
    
    

with all_values as (

    select
        amount_segment as value_field,
        count(*) as n_records

    from `stripe-fraud-analytics`.`dbt_ci_intermediate`.`int_amount_segments`
    group by amount_segment

)

select *
from all_values
where value_field not in (
    'zero','micro','small','medium','large'
)


