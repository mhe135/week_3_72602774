library(nycflights13)
library(dplyr)
library(data.table)

# 3.3 Installing and loading Tidyverse and nycflights13 packages
if (!requireNamespace("tidyverse", quietly = TRUE)) {
  install.packages("tidyverse")
}
if (!requireNamespace("nycflights13", quietly = TRUE)) {
  install.packages("nycflights13")
}
suppressPackageStartupMessages(library(tidyverse))
library(nycflights13)

# 3.4 reading data
head(flights) 

#3.5 Basic Data Manipulation with dplyr
#install dplyr library
library(dplyr)
# Data cleaning and tidyverse
flights_clean <- flights %>%
  select(year, month, day, dep_delay, arr_delay, carrier) %>%
  filter(!is.na(dep_delay) & !is.na(arr_delay))
