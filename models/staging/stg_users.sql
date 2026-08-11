
with source as (
    select * from {{ source('raw', 'raw_users') }}
),

deduplicated as (
    select
        *,
        row_number() over (partition by user_id order by signup_date) as row_num
    from source
)

select
    user_id,
    username,
    email,
    platform,
    cast(signup_date as date) as signup_date,
    country
from deduplicated
where row_num = 1
  and email is not null