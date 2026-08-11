with source as (
    select * from {{ source('raw', 'raw_transactions') }}
)

select
    transaction_id,
    user_id,
    cast(amount as numeric) as amount_idr,
    currency,
    transaction_type,
    cast(created_at as date) as transaction_date
from source
where amount is not null