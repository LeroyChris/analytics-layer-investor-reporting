with events as (
    select * from {{ ref('stg_app_events') }}
),

daily_activity as (
    select
        user_id,
        event_date as activity_date,
        count(*) as event_count,
        count(distinct event_type) as distinct_actions
    from events
    group by user_id, event_date
)

select
    user_id,
    activity_date,
    event_count,
    distinct_actions
from daily_activity