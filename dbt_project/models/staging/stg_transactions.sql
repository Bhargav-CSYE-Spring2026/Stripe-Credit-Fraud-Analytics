with source as (
    select * from {{ source('raw', 'transactions') }}
),

renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(['time', 'amount', 'v1', 'v14']) }}
                                                            as transaction_id,
        cast(time as numeric)                               as seconds_elapsed,
        timestamp_add(
            timestamp('2013-09-01 00:00:00'),
            interval cast(time as int64) second
        )                                                   as transaction_timestamp,
        cast(amount as numeric)                             as transaction_amount_eur,
        cast(class as int64)                                as is_fraud,
        v1, v2, v3, v4, v5, v6, v7, v8, v9, v10,
        v11, v12, v13, v14, v15, v16, v17, v18, v19, v20,
        v21, v22, v23, v24, v25, v26, v27, v28
    from source
)

select * from renamed
