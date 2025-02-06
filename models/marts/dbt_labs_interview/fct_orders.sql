with orders as (
    select * 
    from {{ ref('stg_interview_task__orders') }}
),

addresses as (
    select *
    from {{ ref('stg_interview_task__addresses') }}
),

devices as (
    select *
    from {{ ref('int_interview_task__order_devices') }}
),

first_orders as (
    select *
    from {{ ref('int_interview_task__first_order') }}
),

payments as (
    select *
    from {{ ref('int_interview_task__order_payments') }}
),

final as (
    select

        o.order_id,
        o.user_id,
        o.created_at,
        o.updated_at,
        o.shipped_at,
        o.currency,
        o.status as order_status,

        case
            when o.status in ('paid','completed','shipped') then 'completed'
            else o.status
        end as order_status_category,

        case
            when a.country_code is null then 'Null country'
            when a.country_code = 'US' then 'US'
            else 'International'
        end as country_type,

        o.shipping_method,

        case
            when d.device = 'web' then 'desktop'
            when d.device in ('ios-app','android-app') then 'mobile-app'
            when d.device in ('mobile','tablet') then 'mobile-web'
            when d.device is null or d.device = '' then 'unknown'
            else 'ERROR'
        end as purchase_device_type,

        d.device as purchase_device,

        case
            when fo.first_order_id = o.order_id then 'new'
            else 'repeat'
        end as user_type,

        o.amount_total_cents,
        p.gross_total_amount_cents,

        case
            when o.currency = 'USD' then o.amount_total_cents
            else p.gross_total_amount_cents
        end as total_amount_cents,

        p.gross_tax_amount_cents,
        p.gross_amount_cents,
        p.gross_shipping_amount_cents,

        (o.amount_total_cents / 100.0) as amount_total,
        (p.gross_total_amount_cents / 100.0) as gross_total_amount,
        (
            case
                when o.currency = 'USD' then o.amount_total_cents
                else p.gross_total_amount_cents
            end
        ) / 100.0 as total_amount,
        (p.gross_tax_amount_cents / 100.0) as gross_tax_amount,
        (p.gross_amount_cents / 100.0) as gross_amount,
        (p.gross_shipping_amount_cents / 100.0) as gross_shipping_amount

    from orders o
    left join addresses a 
        on o.order_id = a.order_id
    left join devices d 
        on o.order_id = d.order_id
    left join first_orders fo 
        on o.user_id = fo.user_id
    left join payments p 
        on o.order_id = p.order_id
)

select * from final