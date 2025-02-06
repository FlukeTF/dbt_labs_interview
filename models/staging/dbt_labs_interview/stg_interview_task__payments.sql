select
    cast(order_id as string) as order_id,
    cast(payment_id as string) as payment_id,
    status,
    payment_type,
    amount_cents,
    tax_amount_cents,
    amount_shipping_cents,    
    created_at
from `dbt-public.interview_task.payments`