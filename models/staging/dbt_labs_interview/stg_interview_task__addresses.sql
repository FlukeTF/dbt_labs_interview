with 

source as (

    select * from {{ source('interview_task', 'addresses') }}

),

renamed as (

    select
        cast(order_id as string) as order_id,
        cast(user_id as string) as user_id,
        name,
        address,
        state,
        country_code
    from source

)

select * from renamed
