
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cwdcovid19

<!-- badges: start -->

<!-- badges: end -->

The goal of cwdcovid19 is to …

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("etc5523-2020/r-package-assessment-1029YanMa")
```

## Example

This package contains the dataset from the ‘coronavirous’ R package and
provide a long form and a wide form of the data:

``` r
library(cwdcovid19)
library(tibble)

coronavirus %>% 
  head(10)
#>          date province     country      lat     long      type cases
#> 1  2020-01-22          Afghanistan 33.93911 67.70995 confirmed     0
#> 2  2020-01-23          Afghanistan 33.93911 67.70995 confirmed     0
#> 3  2020-01-24          Afghanistan 33.93911 67.70995 confirmed     0
#> 4  2020-01-25          Afghanistan 33.93911 67.70995 confirmed     0
#> 5  2020-01-26          Afghanistan 33.93911 67.70995 confirmed     0
#> 6  2020-01-27          Afghanistan 33.93911 67.70995 confirmed     0
#> 7  2020-01-28          Afghanistan 33.93911 67.70995 confirmed     0
#> 8  2020-01-29          Afghanistan 33.93911 67.70995 confirmed     0
#> 9  2020-01-30          Afghanistan 33.93911 67.70995 confirmed     0
#> 10 2020-01-31          Afghanistan 33.93911 67.70995 confirmed     0

coronavirus_long %>% 
  head(10)
#>          date     country      type cases
#> 1  2020-01-22 Afghanistan confirmed     0
#> 2  2020-01-23 Afghanistan confirmed     0
#> 3  2020-01-24 Afghanistan confirmed     0
#> 4  2020-01-25 Afghanistan confirmed     0
#> 5  2020-01-26 Afghanistan confirmed     0
#> 6  2020-01-27 Afghanistan confirmed     0
#> 7  2020-01-28 Afghanistan confirmed     0
#> 8  2020-01-29 Afghanistan confirmed     0
#> 9  2020-01-30 Afghanistan confirmed     0
#> 10 2020-01-31 Afghanistan confirmed     0

coronavirus_wide %>% 
  head(10)
#> # A tibble: 10 x 5
#>    date       country     confirmed death     recovered
#>    <date>     <chr>       <list>    <list>    <list>   
#>  1 2020-01-22 Afghanistan <int [1]> <int [1]> <int [1]>
#>  2 2020-01-23 Afghanistan <int [1]> <int [1]> <int [1]>
#>  3 2020-01-24 Afghanistan <int [1]> <int [1]> <int [1]>
#>  4 2020-01-25 Afghanistan <int [1]> <int [1]> <int [1]>
#>  5 2020-01-26 Afghanistan <int [1]> <int [1]> <int [1]>
#>  6 2020-01-27 Afghanistan <int [1]> <int [1]> <int [1]>
#>  7 2020-01-28 Afghanistan <int [1]> <int [1]> <int [1]>
#>  8 2020-01-29 Afghanistan <int [1]> <int [1]> <int [1]>
#>  9 2020-01-30 Afghanistan <int [1]> <int [1]> <int [1]>
#> 10 2020-01-31 Afghanistan <int [1]> <int [1]> <int [1]>
```
