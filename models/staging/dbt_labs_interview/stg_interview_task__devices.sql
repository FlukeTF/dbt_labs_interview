select
    cast(type_id as string) as order_id,    
    device,
    type,
    timestamp_seconds(cast(created_at * 86400 as int64)) as created_at,
    timestamp_seconds(cast(updated_at * 86400 as int64)) as updated_at
from `dbt-public.interview_task.devices`
