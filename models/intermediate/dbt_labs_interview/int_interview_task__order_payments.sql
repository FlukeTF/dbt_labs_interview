with payments as (
    select
        order_id,
        status,
        amount_cents,
        tax_amount_cents,
        amount_shipping_cents
    from {{ ref('stg_interview_task__payments') }}
),

aggregated as (
    select
        order_id,
        sum(case when status = 'completed' then tax_amount_cents else 0 end) as gross_tax_amount_cents,
        sum(case when status = 'completed' then amount_cents else 0 end) as gross_amount_cents,
        sum(case when status = 'completed' then amount_shipping_cents else 0 end) as gross_shipping_amount_cents,
        sum(case when status = 'completed' then tax_amount_cents + amount_cents + amount_shipping_cents else 0 end) as gross_total_amount_cents
    from payments
    group by order_id
)

select
    order_id,
    gross_tax_amount_cents,
    gross_amount_cents,
    gross_shipping_amount_cents,
    gross_total_amount_cents
from aggregated