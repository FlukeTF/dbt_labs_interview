with 

source as (

    select * from {{ source('interview_task', 'orders') }}

),

renamed as (

    select
        cast(order_id as string) as order_id,
        cast(user_id as string) as user_id,
        created_at,
        updated_at,
        shipped_at,
        currency,
        status,
        amount_total_cents,
        shipping_method
    from source

)

select * from renamed
