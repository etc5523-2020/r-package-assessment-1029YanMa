#' Count the number of countries
#'
#' @param data a data containing a country column
#' @export
#'
"n_countries"
library(dplyr)

n_countries <- function(data){
  dplyr::n_distinct(data$country)
}
