-- stg_sleep_day.sql
-- Cleans and standardizes the raw sleep data

WITH source AS (
    SELECT * FROM {{ source('raw', 'raw_sleep_day') }}
),

cleaned AS (
    SELECT
        id                                              AS user_id,
        TO_DATE(
            LEFT(sleepday, 9), 'MM/DD/YYYY')            AS sleep_date,
        totalminutesasleep                              AS total_mins_asleep,
        totaltimeinbed                                  AS total_time_in_bed,
        ROUND(totalminutesasleep / 60.0, 2)             AS hours_asleep,
        (totaltimeinbed - totalminutesasleep)            AS wasted_bed_mins,
        CASE
            WHEN totalminutesasleep >= 420 THEN 'Good Sleeper'
            WHEN totalminutesasleep >= 360 THEN 'Moderate Sleeper'
            ELSE                                'Poor Sleeper'
        END                                             AS sleep_quality
    FROM source
)

SELECT * FROM cleaned