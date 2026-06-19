-- stg_daily_activity.sql
-- Cleans and standardizes the raw daily activity data

WITH source AS (
    SELECT * FROM {{ source('raw', 'raw_daily_activity') }}
),

cleaned AS (
    SELECT
        id                                          AS user_id,
        TO_DATE(activitydate, 'MM/DD/YYYY')         AS activity_date,
        totalsteps                                  AS total_steps,
        ROUND(totaldistance, 2)                     AS total_distance_km,
        veryactiveminutes                           AS very_active_mins,
        fairlyactiveminutes                         AS fairly_active_mins,
        lightlyactiveminutes                        AS lightly_active_mins,
        sedentaryminutes                            AS sedentary_mins,
        (veryactiveminutes + fairlyactiveminutes 
         + lightlyactiveminutes)                    AS total_active_mins,
        calories,
        DAYNAME(TO_DATE(activitydate, 'MM/DD/YYYY')) AS day_of_week,
        CASE
            WHEN totalsteps >= 10000 THEN 'Active'
            WHEN totalsteps >= 5000  THEN 'Moderate'
            ELSE                          'Sedentary'
        END                                         AS user_segment
    FROM source
    WHERE totalsteps > 0  -- remove days device wasn't worn
)

SELECT * FROM cleaned