with source as (
    select * from {{ source('raw', 'raw_app_events') }}
)

select
    event_id,
    user_id,
    event_type,
    platform,
    cast(event_timestamp as timestamp) as event_timestamp,
    cast(event_timestamp as date) as event_date
from source