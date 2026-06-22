# ================================================
# FITBIT ANALYTICS PROJECT
# File 2: Load Data from Snowflake
# ================================================

# Run connection first
source("01_connection.R")

# ── Load Activity Data ───────────────────────────
activity_data <- dbGetQuery(con, "
    SELECT
        user_id,
        activity_date,
        total_steps,
        calories,
        very_active_mins,
        fairly_active_mins,
        lightly_active_mins,
        sedentary_mins,
        total_active_mins,
        total_distance_km,
        day_of_week,
        user_segment
    FROM fitbit_db.TLKEERTHANA21.fct_user_activity
")

# ── Load Sleep Data ──────────────────────────────
sleep_data <- dbGetQuery(con, "
    SELECT
        user_id,
        activity_date,
        total_steps,
        hours_asleep,
        wasted_bed_mins,
        sleep_quality,
        steps_category,
        user_segment
    FROM fitbit_db.TLKEERTHANA21.fct_sleep_analysis
")

# ── Quick Check ──────────────────────────────────
cat("Activity data rows:", nrow(activity_data), "\n")
cat("Sleep data rows:", nrow(sleep_data), "\n")
cat("Activity columns:", ncol(activity_data), "\n")
cat("Sleep columns:", ncol(sleep_data), "\n")

# Preview data
head(activity_data, 5)
head(sleep_data, 5)