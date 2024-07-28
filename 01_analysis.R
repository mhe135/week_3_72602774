3.7:
# Load the cleaned data
source("00_clean.R")

# Continue with analysis: Group by airline and calculate average delays
summary_delays <- flights_with_airlines %>%
  group_by(airline_name) %>%
  summarize(
    avg_dep_delay = mean(mean_dep_delay),
    avg_arr_delay = mean(mean_arr_delay),
    .groups = 'drop')
# Load ggplot2 for visualization
library(ggplot2)

# Create a plot of the average departure and arrival delays
ggplot(summary_delays, aes(x = reorder(airline_name, avg_dep_delay), y = avg_dep_delay)) +
  geom_col(fill = "steelblue") +
  labs(title = "Average Departure Delays by Airline",
       x = "Airline",
       y = "Average Departure Delay (minutes)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_text(aes(label = sprintf("%.1f", avg_dep_delay)), position = position_dodge(width = 0.9), vjust = -0.25)

# Optionally, add a plot for average arrival delays
ggplot(summary_delays, aes(x = reorder(airline_name, avg_arr_delay), y = avg_arr_delay)) +
  geom_col(fill = "darkred") +
  labs(title = "Average Arrival Delays by Airline",
       x = "Airline",
       y = "Average Arrival Delay (minutes)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_text(aes(label = sprintf("%.1f", avg_arr_delay)), position = position_dodge(width = 0.9), vjust = -0.25)

3.8:
# Load the dplyr library
library(dplyr)

# Calculate the mean departure and arrival delays for each carrier
# and arrange them from the shortest to the longest departure delay
flights_means <- flights %>%
  group_by(carrier) %>%
  summarize(
    avg_dep_delay = mean(dep_delay, na.rm = TRUE),  # Calculate the mean, ignoring NA values
    avg_arr_delay = mean(arr_delay, na.rm = TRUE)   # Calculate the mean, ignoring NA values
  ) %>%
  arrange(avg_dep_delay)  # Arrange the results by average departure delay

# Display the summarized data
print(flights_means)

3.9:
# Load the dplyr library
library(dplyr)

# Assuming 'flights_means' and 'airlines' are already loaded
# Join the airlines names to the flights_means dataset
flights_means_with_names <- flights_means %>%
  left_join(airlines, by = "carrier") %>%  # Joining on the 'carrier' column
  select(-carrier, name, avg_dep_delay, avg_arr_delay) %>%
  rename(airline_name = name)  # Renaming 'name' to 'airline_name' for clarity

# Display the updated dataset
print(flights_means_with_names)

4:
# Install DT package if it's not already installed
if (!require(DT)) install.packages("DT")

# Load the DT package
library(DT)
library(shiny)
library(DT)  # Ensure the DT library is loaded

ui <- fluidPage(
  selectInput("airline", "Choose an Airline", choices = NULL),
  dataTableOutput("results")  # Correct function for displaying DataTable
)

server <- function(input, output, session) {
  data <- reactiveVal()
  
  # Update airline choices based on available data
  observe({
    # Example data update for select input
    updateSelectInput(session, "airline", choices = unique(c("Airline A", "Airline B")))
  })
  
  # Reactive table output using renderDT
  output$results <- renderDT({
    req(data())  # Ensure data is loaded
    data.frame(Airline = c("Airline A", "Airline B"), Delays = c(10, 20))  # Example data frame
  })
}

shinyApp(ui, server)

4.1:
# Install data.table if not already installed
if (!require(data.table)) {
  install.packages("data.table")
  library(data.table)
} else {
  library(data.table)}

# Load other necessary packages
library(shiny)
library(DT)
# Assuming 'flights' is a data frame loaded previously
flights_dt <- as.data.table(flights)

# Example operation: Calculating average delays by airline using data.table
flights_means <- flights_dt[, .(avg_dep_delay = mean(dep_delay, na.rm = TRUE),
                                avg_arr_delay = mean(arr_delay, na.rm = TRUE)), by = carrier]

# Sort by average departure delay
setorder(flights_means, avg_dep_delay)

4.2:
library(data.table)

# Convert the flights dataframe to a data table
flights_dt <- as.data.table(flights)

# Select columns, calculate means, and sort by mean departure delay
flights_summary <- flights_dt[, .(dep_delay, arr_delay), by = .(carrier)][
  , .(mean_dep_delay = mean(dep_delay, na.rm = TRUE),
      mean_arr_delay = mean(arr_delay, na.rm = TRUE)), by = carrier][
        order(mean_dep_delay)]

4.3:
# Tidyverse script run time
system.time({
  mtcars %>%
    filter(cyl > 6) %>%
    select(cyl, mpg)})

# Data.table script run time
system.time({
  dt <- as.data.table(mtcars)
  result <- dt[cyl > 6, .(cyl, mpg)]})



