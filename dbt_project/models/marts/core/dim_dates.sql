with date_spine as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2013-09-01' as date)",
        end_date="cast('2013-10-01' as date)"
    ) }}
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
