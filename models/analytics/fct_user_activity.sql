-- fct_user_activity.sql

WITH activity AS (
    SELECT * FROM fitbit_db.staging.stg_daily_activity
),

user_summary AS (
    SELECT
        user_id,
        user_segment,
        COUNT(*)                              AS total_days_tracked,
        ROUND(AVG(total_steps), 0)            AS avg_daily_steps,
        ROUND(AVG(calories), 0)               AS avg_daily_calories,
        ROUND(AVG(very_active_mins), 1)       AS avg_very_active_mins,
        ROUND(AVG(sedentary_mins), 0)         AS avg_sedentary_mins,
        ROUND(AVG(total_active_mins), 0)      AS avg_total_active_mins,
        SUM(total_steps)                      AS total_steps_all_time,
        SUM(calories)                         AS total_calories_all_time
    FROM activity
    GROUP BY user_id, user_segment
)

SELECT
    a.user_id,
    a.activity_date,
    a.total_steps,
    a.calories,
    a.very_active_mins,
    a.fairly_active_mins,
    a.lightly_active_mins,
    a.sedentary_mins,
    a.total_active_mins,
    a.total_distance_km,
    a.day_of_week,
    a.user_segment,
    u.avg_daily_steps,
    u.avg_daily_calories,
    u.total_days_tracked
FROM activity a
LEFT JOIN user_summary u 
    ON a.user_id = u.user_id
    AND a.user_segment = u.user_segment