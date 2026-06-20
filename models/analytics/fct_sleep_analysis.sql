-- fct_sleep_analysis.sql

WITH activity AS (
    SELECT * FROM fitbit_db.staging.stg_daily_activity
),

sleep AS (
    SELECT * FROM fitbit_db.staging.stg_sleep_day
),

joined AS (
    SELECT
        a.user_id,
        a.activity_date,
        a.total_steps,
        a.calories,
        a.total_active_mins,
        a.very_active_mins,
        a.sedentary_mins,
        a.user_segment,
        a.day_of_week,
        s.hours_asleep,
        s.wasted_bed_mins,
        s.sleep_quality,
        s.total_time_in_bed,
        CASE
            WHEN a.total_steps < 5000  THEN '1. Under 5,000 steps'
            WHEN a.total_steps < 8000  THEN '2. 5,000-8,000 steps'
            WHEN a.total_steps < 10000 THEN '3. 8,000-10,000 steps'
            ELSE                            '4. Over 10,000 steps'
        END AS steps_category
    FROM activity a
    INNER JOIN sleep s
        ON a.user_id = s.user_id
        AND a.activity_date = s.sleep_date
)

SELECT * FROM joined