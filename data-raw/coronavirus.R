## code to prepare `coronavirus` dataset goes here

library(readr)
library(dplyr)
library(magrittr)


coronavirus <- read.csv("https://github.com/RamiKrispin/coronavirus/blob/master/csv/coronavirus.csv")

coronavirus_long <- coronavirus %>%
  select(date, country, type, cases)

coronavirus_wide <- coronavirus_long %>%
  pivot_wider(names_from = type, values_from = cases)


usethis::use_data(coronavirus, overwrite = TRUE)

usethis::use_data(coronavirus_long, overwrite = TRUE)

usethis::use_data(coronavirus_wide, overwrite = TRUE)
