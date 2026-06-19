-- stg_weight_log.sql
-- Cleans and standardizes the raw weight log data

WITH source AS (
    SELECT * FROM {{ source('raw', 'raw_weight_log') }}
),

cleaned AS (
    SELECT
        id                          AS user_id,
        TO_DATE(
            LEFT(date, 9),
            'MM/DD/YYYY')           AS log_date,
        ROUND(weightkg, 2)          AS weight_kg,
        ROUND(weightpounds, 2)      AS weight_pounds,
        ROUND(bmi, 2)               AS bmi,
        ismanualreport              AS is_manual_report,
        CASE
            WHEN bmi < 18.5 THEN 'Underweight'
            WHEN bmi < 25.0 THEN 'Normal weight'
            WHEN bmi < 30.0 THEN 'Overweight'
            ELSE                  'Obese'
        END                         AS bmi_category
    FROM source
)

SELECT * FROM cleaned