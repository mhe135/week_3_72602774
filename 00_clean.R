3.4:
# Reading flights dataset
head(flights)

3.5:
# Load the Tidyverse library, which includes dplyr
library(tidyverse)
# Selecting only the carrier and delay variables
flights_clean <- flights %>%
  select(carrier, dep_delay, arr_delay)
# Summarizing the mean departure and arrival delays by carrier
flights_summary <- flights_clean %>%
  group_by(carrier) %>%
  summarize(
    mean_dep_delay = mean(dep_delay, na.rm = TRUE),
    mean_arr_delay = mean(arr_delay, na.rm = TRUE),
    .groups = 'drop'  # Drop grouping for easier further manipulation
  ) %>%
  arrange(mean_dep_delay)
# Printing the summary to check the results
print(flights_summary)

3.6:
# Load necessary libraries
library(nycflights13)
library(dplyr)
# Load the datasets
data("flights")
data("airlines")
# Create a summary of mean delays by carrier
flights_summary <- flights %>%
  select(carrier, dep_delay, arr_delay) %>%
  group_by(carrier) %>%
  summarize(
    mean_dep_delay = mean(dep_delay, na.rm = TRUE),
    mean_arr_delay = mean(arr_delay, na.rm = TRUE),
    .groups = 'drop')
# Join the airlines names onto the flights summary
flights_with_airlines <- flights_summary %>%
  left_join(airlines, by = "carrier") %>%
  select(-carrier, name, mean_dep_delay, mean_arr_delay) %>%
  rename(airline_name = name)
# Join the airlines names onto the flights summary
flights_with_airlines <- flights_summary %>%
  left_join(airlines, by = "carrier") %>%
  select(-carrier, name, mean_dep_delay, mean_arr_delay) %>%
  rename(airline_name = name)
head(flights_with_airlines)



