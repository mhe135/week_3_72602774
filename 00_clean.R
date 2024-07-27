# Installing and Loading Tidyverse and nycflights13 dataset
if (!requireNamespace("tidyverse", quietly = TRUE)) {
  install.packages("tidyverse")}
if (!requireNamespace("nycflights13", quietly = TRUE)) {
  install.packages("nycflights13")}
suppressPackageStartupMessages(library(tidyverse))
library(nycflights13)

# Reading flights dataset
head(flights)
