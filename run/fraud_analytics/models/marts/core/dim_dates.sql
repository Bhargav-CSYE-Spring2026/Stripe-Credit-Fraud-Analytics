
  
    

    create or replace table `stripe-fraud-analytics`.`dbt_ci_marts`.`dim_dates`
      
    
    

    
    OPTIONS()
    as (
      with date_spine as (
    





with rawdata as (

    

    

    with p as (
        select 0 as generated_number union all select 1
    ), unioned as (

    select

    
    p0.generated_number * power(2, 0)
     + 
    
    p1.generated_number * power(2, 1)
     + 
    
    p2.generated_number * power(2, 2)
     + 
    
    p3.generated_number * power(2, 3)
     + 
    
    p4.generated_number * power(2, 4)
    
    
    + 1
    as generated_number

    from

    
    p as p0
     cross join 
    
    p as p1
     cross join 
    
    p as p2
     cross join 
    
    p as p3
     cross join 
    
    p as p4
    
    

    )

    select *
    from unioned
    where generated_number <= 30
    order by generated_number



),

all_periods as (

    select (
        

        datetime_add(
            cast( cast('2013-09-01' as date) as datetime),
        interval row_number() over (order by generated_number) - 1 day
        )


    ) as date_day
    from rawdata

),

filtered as (

    select *
    from all_periods
    where date_day <= cast('2013-10-01' as date)

)

select * from filtered


),

final as (
    select
        cast(date_day as date)                          as date_day,
        extract(year from date_day)                     as year,
        extract(month from date_day)                    as month,
        extract(day from date_day)                      as day_of_month,
        extract(dayofweek from date_day)                as day_of_week,
        format_date('%A', cast(date_day as date))       as day_name,
        format_date('%B', cast(date_day as date))       as month_name,
        case when extract(dayofweek from date_day)
            in (1, 7) then true else false end          as is_weekend
    from date_spine
)

select * from final
    );
  