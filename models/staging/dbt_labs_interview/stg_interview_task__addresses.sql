select
    cast(order_id as string) as order_id,
    cast(user_id as string) as user_id,
    name,
    address,
    state,
    country_code
from `dbt-public.interview_task.addresses`