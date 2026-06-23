# ================================================
# FITBIT ANALYTICS PROJECT
# File 3: Data Analysis
# ================================================

# Load data first
source("02_data_load.R")

library(dplyr)

# ── Convert column names to lowercase ────────────
names(activity_data) <- tolower(names(activity_data))
names(sleep_data)    <- tolower(names(sleep_data))

cat("Column names fixed!\n")
print(names(activity_data))

# ── Fix duplicate rows ───────────────────────────
activity_clean <- activity_data %>%
  distinct(user_id, activity_date, .keep_all = TRUE)

cat("Clean activity rows:", nrow(activity_clean), "\n")

# ── Q1: Steps vs Calories by Segment ────────────
segment_summary <- activity_clean %>%
  group_by(user_segment) %>%
  summarise(
    total_users     = n_distinct(user_id),
    avg_steps       = round(mean(total_steps), 0),
    avg_calories    = round(mean(calories), 0),
    avg_active_mins = round(mean(total_active_mins), 0)
  ) %>%
  arrange(desc(avg_steps))

print("Q1 - Segment Summary:")
print(segment_summary)

# ── Q2: Most Active Days ─────────────────────────
day_order <- c("Monday", "Tuesday", "Wednesday",
               "Thursday", "Friday", "Saturday", "Sunday")

day_summary <- activity_clean %>%
  group_by(day_of_week) %>%
  summarise(
    avg_steps    = round(mean(total_steps), 0),
    avg_calories = round(mean(calories), 0)
  ) %>%
  arrange(desc(avg_steps))

print("Q2 - Day of Week Summary:")
print(day_summary)

# ── Q3: Sleep vs Steps ───────────────────────────
sleep_summary <- sleep_data %>%
  group_by(steps_category) %>%
  summarise(
    total_records    = n(),
    avg_hours_asleep = round(mean(hours_asleep), 2),
    avg_wasted_mins  = round(mean(wasted_bed_mins), 0)
  ) %>%
  arrange(steps_category)

print("Q3 - Sleep vs Steps Summary:")
print(sleep_summary)

# ── User Segment Distribution ────────────────────
segment_dist <- activity_clean %>%
  group_by(user_segment) %>%
  summarise(total_days = n()) %>%
  mutate(percentage = round(total_days / sum(total_days) * 100, 1))

print("Segment Distribution:")
print(segment_dist)