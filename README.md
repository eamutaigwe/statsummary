
<!-- README.md is generated from README.Rmd. Please edit that file -->

# statsummary

<!-- badges: start -->
<!-- badges: end -->

The goal of statsummary is to compute summary statistics (mean, median,
minimum, maximum, count) on a numeric variable grouped by a categorical
variable.

## Installation

statsummary is not yet on CRAN. You can install the development version
of statsummary like so:

``` r
devtools::install_github("eamutaigwe/statsummary")
```

## Example

Summarize_data() is a function that helps to carry out a fairly common
task on a dataset which quickly computes summary statistics (mean,
median, minimum, maximum, and count) on a numeric variable grouped by a
categorical variable.

It produces a list object with two items- a tibble or data frame
containing summary statistics on a numeric variable grouped by a
categorical variable, and a ggplot object- a boxplot which visually
presents some of the summary statistics found in the summary table
generated such as median, minimum, maximum, and count.

Below is a basic example which shows you how to use the function:

``` r
library(statsummary)
summarize_data(gapminder::gapminder, continent, lifeExp)
#> [[1]]
#> # A tibble: 5 × 6
#>   continent  mean median   min   max     n
#>   <fct>     <dbl>  <dbl> <dbl> <dbl> <int>
#> 1 Africa     48.9   47.8  23.6  76.4   624
#> 2 Americas   64.7   67.0  37.6  80.7   300
#> 3 Asia       60.1   61.8  28.8  82.6   396
#> 4 Europe     71.9   72.2  43.6  81.8   360
#> 5 Oceania    74.3   73.7  69.1  81.2    24
#> 
#> [[2]]
```

<img src="man/figures/README-example-1.png" width="100%" />

summarize_data() is designed to always group by a categorical variable.
So, if you decide to group by a numeric variable, it would throw an
error. An error message is also returned if your `y` variable is
categorical.

``` r
summarize_data(gapminder::gapminder, gdpPercap, lifeExp)
#> Error in summarize_data(gapminder::gapminder, gdpPercap, lifeExp): This function only works with a categorical input as x.
#> You have provided an object of class: numeric
```
