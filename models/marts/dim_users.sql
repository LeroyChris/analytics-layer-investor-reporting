with users as (
    select * from {{ ref('stg_users') }}
)

select
    user_id,
    username,
    email,
    platform,
    signup_date,
    country
from users