# ================================================
# FITBIT ANALYTICS PROJECT
# File 1: Snowflake Connection Setup
# ================================================

# Load libraries
library(DBI)
library(odbc)

# Connect to Snowflake
con <- dbConnect(
  odbc::odbc(),
  dsn      = "Snowflake_Fitbit",
  uid      = "TLKEERTHANA21",
  pwd      = "SNOW_PWD"  
)

# Test connection
if (dbIsValid(con)) {
  print("✅ Connected to Snowflake successfully!")
} else {
  print("❌ Connection failed!")
}