# 3.7 start new script
#3.8 ,3.9 Calculate the amount of delay and calculate flights_means
flights_means <- flights_clean %>%
  group_by(name) %>%
  summarize(
    avg_dep_delay = mean(dep_delay),
    avg_arr_delay = mean(arr_delay)) %>%
  arrange(avg_dep_delay)

# Display the result
print(flights_means)


#4.1 install datatable package
if (!requireNamespace("data.table", quietly = TRUE)) {
  install.packages("data.table")}
library(data.table)
# 4.2 use datatable to replace tydyversepipeline
flights_dt <- as.data.table(flights)

# Data cleaning and manipulation with data.table
flights_clean_dt <- flights_dt[
  !is.na(dep_delay) & !is.na(arr_delay),
  .(year, month, day, dep_delay, arr_delay, carrier)]

# Join with airlines data to get full airline names
airlines_dt <- as.data.table(airlines)
flights_clean_dt <- merge(flights_clean_dt, airlines_dt, by = "carrier", all.x = TRUE)

# Calculate the average departure and arrival delays for each airline
flights_means_dt <- flights_clean_dt[, .(
  avg_dep_delay = mean(dep_delay),
  avg_arr_delay = mean(arr_delay)
), by = name][order(avg_dep_delay)]

# Display the result
print(flights_means_dt)


# 4.3 Timing running time for analysis script
system.time({
  flights_clean <- flights %>%
    select(year, month, day, dep_delay, arr_delay, carrier) %>%
    filter(!is.na(dep_delay) & !is.na(arr_delay)) %>%
    left_join(airlines, by = "carrier") %>%
    group_by(name) %>%
    summarize(
      avg_dep_delay = mean(dep_delay),
      avg_arr_delay = mean(arr_delay)) %>%
    arrange(avg_dep_delay)})
# 4.3 Timing runtime for the data.table
system.time({
  flights_clean_dt <- flights_dt[
    !is.na(dep_delay) & !is.na(arr_delay),
    .(year, month, day, dep_delay, arr_delay, carrier)]
  flights_clean_dt <- merge(flights_clean_dt, airlines_dt, by = "carrier", all.x = TRUE)
  flights_means_dt <- flights_clean_dt[, .(
    avg_dep_delay = mean(dep_delay),
    avg_arr_delay = mean(arr_delay)
  ), by = name][order(avg_dep_delay)]})

