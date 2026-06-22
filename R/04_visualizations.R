# ================================================
# FITBIT ANALYTICS PROJECT
# File 4: Visualizations
# ================================================

# Load analysis first
source("03_analysis.R")

library(ggplot2)
library(scales)

# ── Chart 1: Steps vs Calories by Segment ────────
chart1 <- ggplot(segment_summary,
                 aes(x = reorder(user_segment, -avg_steps),
                     y = avg_calories,
                     fill = user_segment)) +
  geom_bar(stat = "identity", width = 0.6) +
  geom_text(aes(label = paste0(avg_calories, " cal")),
            vjust = -0.5, size = 4, fontface = "bold") +
  scale_fill_manual(values = c(
    "Active"    = "#2ECC71",
    "Moderate"  = "#F39C12",
    "Sedentary" = "#E74C3C"
  )) +
  labs(
    title    = "Average Calories Burned by Activity Segment",
    subtitle = "Active users burn 886 more calories/day than Sedentary users",
    x        = "User Segment",
    y        = "Average Daily Calories",
    caption  = "Source: Fitbit Fitness Tracker Data (Apr-May 2016)"
  ) +
  theme_minimal() +
  theme(
    plot.title    = element_text(size = 14, face = "bold"),
    plot.subtitle = element_text(size = 11, color = "gray50"),
    legend.position = "none"
  )

print(chart1)
ggsave("chart1_calories_by_segment.png", chart1,
       width = 8, height = 5, dpi = 300)

# ── Chart 2: Most Active Days ────────────────────
day_order <- c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")

day_summary$day_short <- substr(day_summary$day_of_week, 1, 3)
day_summary$day_short <- factor(day_summary$day_short, levels = day_order)

chart2 <- ggplot(day_summary,
                 aes(x = day_short,
                     y = avg_steps,
                     fill = avg_steps)) +
  geom_bar(stat = "identity", width = 0.7) +
  geom_text(aes(label = format(avg_steps, big.mark = ",")),
            vjust = -0.5, size = 3.5) +
  geom_hline(yintercept = 8000, linetype = "dashed",
             color = "red", linewidth = 0.8) +
  annotate("text", x = 6.5, y = 8200,
           label = "8K steps goal", color = "red", size = 3.5) +
  scale_fill_gradient(low = "#85C1E9", high = "#1A5276") +
  labs(
    title    = "Average Daily Steps by Day of Week",
    subtitle = "Tuesday and Saturday are the most active days",
    x        = "Day of Week",
    y        = "Average Steps",
    caption  = "Source: Fitbit Fitness Tracker Data (Apr-May 2016)"
  ) +
  theme_minimal() +
  theme(
    plot.title    = element_text(size = 14, face = "bold"),
    plot.subtitle = element_text(size = 11, color = "gray50"),
    legend.position = "none"
  )

print(chart2)
ggsave("chart2_steps_by_day.png", chart2,
       width = 8, height = 5, dpi = 300)

# ── Chart 3: Sleep vs Steps ───────────────────────
chart3 <- ggplot(sleep_summary,
                 aes(x = steps_category,
                     y = avg_hours_asleep,
                     fill = avg_hours_asleep)) +
  geom_bar(stat = "identity", width = 0.6) +
  geom_text(aes(label = paste0(avg_hours_asleep, " hrs")),
            vjust = -0.5, size = 4, fontface = "bold") +
  geom_hline(yintercept = 7, linetype = "dashed",
             color = "darkgreen", linewidth = 0.8) +
  annotate("text", x = 3.5, y = 7.15,
           label = "7hr recommended", color = "darkgreen", size = 3.5) +
  scale_fill_gradient(low = "#D5DBDB", high = "#6C3483") +
  labs(
    title    = "Average Sleep Hours by Daily Step Count",
    subtitle = "Counterintuitive: Less active users sleep more hours",
    x        = "Daily Steps Category",
    y        = "Average Hours Asleep",
    caption  = "Source: Fitbit Fitness Tracker Data (Apr-May 2016)"
  ) +
  theme_minimal() +
  theme(
    plot.title    = element_text(size = 14, face = "bold"),
    plot.subtitle = element_text(size = 11, color = "gray50"),
    legend.position = "none",
    axis.text.x  = element_text(angle = 15, hjust = 1)
  )

print(chart3)
ggsave("chart3_sleep_vs_steps.png", chart3,
       width = 8, height = 5, dpi = 300)

# ── Chart 4: User Segment Distribution ───────────
chart4 <- ggplot(segment_dist,
                 aes(x = "", y = percentage, fill = user_segment)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  geom_text(aes(label = paste0(user_segment, "\n", percentage, "%")),
            position = position_stack(vjust = 0.5),
            size = 4, fontface = "bold", color = "white") +
  scale_fill_manual(values = c(
    "Active"    = "#2ECC71",
    "Moderate"  = "#F39C12",
    "Sedentary" = "#E74C3C"
  )) +
  labs(
    title   = "User Activity Segment Distribution",
    subtitle = "Most users fall in Moderate and Active categories",
    caption = "Source: Fitbit Fitness Tracker Data (Apr-May 2016)"
  ) +
  theme_void() +
  theme(
    plot.title    = element_text(size = 14, face = "bold",
                                 hjust = 0.5),
    plot.subtitle = element_text(size = 11, color = "gray50",
                                 hjust = 0.5),
    legend.position = "none"
  )

print(chart4)
ggsave("chart4_segment_distribution.png", chart4,
       width = 7, height = 7, dpi = 300)

cat("\n✅ All 4 charts created and saved!\n")