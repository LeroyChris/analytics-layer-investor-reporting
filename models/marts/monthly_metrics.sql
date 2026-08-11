with monthly_revenue as (
    select
        date_trunc('month', transaction_date)::date as month,
        sum(amount_idr) as total_revenue,
        count(distinct user_id) as transacting_users
    from {{ ref('fact_transactions') }}
    where transaction_type = 'deposit'
    group by date_trunc('month', transaction_date)::date
),

monthly_active_users as (
    select
        date_trunc('month', activity_date)::date as month,
        count(distinct user_id) as mau
    from {{ ref('fact_daily_activity') }}
    group by date_trunc('month', activity_date)::date
)

select
    r.month,
    r.total_revenue,
    r.transacting_users,
    a.mau,
    case
        when a.mau > 0 then round(r.total_revenue / a.mau, 2)
        else 0
    end as arpu
from monthly_revenue r
left join monthly_active_users a
    on r.month = a.month
order by r.month