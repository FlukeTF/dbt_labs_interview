with all_orders as (
    select
        order_id,
        user_id,
        status,
        row_number() over (partition by user_id order by created_at asc) as row_num
    from {{ ref('stg_interview_task__orders') }}
    where status != 'cancelled'
),

first_orders as (
    select
        user_id,
        order_id as first_order_id
    from all_orders
    where row_num = 1
)

select
    user_id,
    first_order_id
from first_orders
