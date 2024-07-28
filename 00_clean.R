# Installing and Loading Tidyverse and nycflights13 dataset
if (!requireNamespace("tidyverse", quietly = TRUE)) {
  install.packages("tidyverse")}
if (!requireNamespace("nycflights13", quietly = TRUE)) {
  install.packages("nycflights13")}
suppressPackageStartupMessages(library(tidyverse))
library(nycflights13)

# Reading flights dataset
head(flights)

# Select necessary variables: carrier, dep_delay, arr_delay
flights_clean <- flights %>%
  select(carrier, dep_delay, arr_delay)

# Summarize the mean departure and arrival delays by carrier
flights_summary <- flights_clean %>%
  group_by(carrier) %>%
  summarize(
    mean_dep_delay = mean(dep_delay, na.rm = TRUE),
    mean_arr_delay = mean(arr_delay, na.rm = TRUE)
  ) %>%
  arrange(mean_dep_delay)

# Display the summarized data
print(flights_summary)