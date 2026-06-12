with source as (
    select * from `stripe-fraud-analytics`.`raw`.`transactions`
),

renamed as (
    select
        to_hex(md5(cast(coalesce(cast(time as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(amount as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(class as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v1 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v2 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v3 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v4 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v5 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v6 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v7 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v8 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v9 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v10 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v11 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v12 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v13 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v14 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v15 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v16 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v17 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v18 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v19 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v20 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v21 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v22 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v23 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v24 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v25 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v26 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v27 as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(v28 as string), '_dbt_utils_surrogate_key_null_') as string)))                                               as transaction_id,
        cast(time as numeric)                               as seconds_elapsed,
        timestamp_add(
            timestamp('2013-09-01 00:00:00'),
            interval cast(time as int64) second
        )                                                   as transaction_timestamp,
        cast(amount as numeric)                             as transaction_amount_eur,
        cast(class as int64)                                as is_fraud,
        v1, v2, v3, v4, v5, v6, v7, v8, v9, v10,
        v11, v12, v13, v14, v15, v16, v17, v18, v19, v20,
        v21, v22, v23, v24, v25, v26, v27, v28,
        row_number() over (
            partition by
                cast(time as string),
                cast(amount as string),
                cast(class as string),
                cast(v1 as string),
                cast(v2 as string),
                cast(v3 as string)
        )                                                   as row_num
    from source
),

deduped as (
    select * from renamed
    where row_num = 1
)

select
    transaction_id,
    seconds_elapsed,
    transaction_timestamp,
    transaction_amount_eur,
    is_fraud,
    v1, v2, v3, v4, v5, v6, v7, v8, v9, v10,
    v11, v12, v13, v14, v15, v16, v17, v18, v19, v20,
    v21, v22, v23, v24, v25, v26, v27, v28
from deduped