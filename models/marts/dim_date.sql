with date_spine as (
    select
        generate_series(
            '2024-01-01'::date,
            '2024-06-30'::date,
            '1 day'::interval
        )::date as date_day
)

select
    date_day,
    extract(year from date_day)::int as year,
    extract(month from date_day)::int as month,
    extract(day from date_day)::int as day_of_month,
    trim(to_char(date_day, 'Day')) as day_name,
    trim(to_char(date_day, 'Month')) as month_name
from date_spine