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
