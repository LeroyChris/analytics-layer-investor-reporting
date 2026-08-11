with transactions as (
    select * from {{ ref('stg_transactions') }}
),

valid_transactions as (
    select
        t.*
    from transactions t
    inner join {{ ref('stg_users') }} u
        on t.user_id = u.user_id
)

select
    transaction_id,
    user_id,
    amount_idr,
    currency,
    transaction_type,
    transaction_date
from valid_transactions