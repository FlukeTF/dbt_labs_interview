with devices as (
    select
        order_id,
        device,
        created_at
    from {{ ref('stg_interview_task__devices') }}
    where type = 'order'
),
ranked as (
    select
        order_id,
        device,
        created_at,
        row_number() over (partition by order_id order by created_at) as row_num
    from devices
)
select
    order_id,
    device
from ranked
where row_num = 1