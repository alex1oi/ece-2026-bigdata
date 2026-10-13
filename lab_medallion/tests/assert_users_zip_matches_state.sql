{{ config(severity='warn') }}

-- A zip code must belong to the range of its state: the test returns the inconsistent users
select
    u.user_id,
    u.state,
    u.zip_code,
    r.zip_min,
    r.zip_max
from {{ ref('stg_users') }} u
left join {{ ref('state_zip_ranges') }} r on u.state = r.state_code
where r.state_code is null
   or cast(u.zip_code as integer) not between r.zip_min and r.zip_max
