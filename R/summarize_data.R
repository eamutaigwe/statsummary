#' Compute summary statistics, produce a tibble or data frame and a ggplot object- boxplot
#'
#' This function computes summary statistics on a numeric variable
#' grouped by a categorical variable. The summary statistics include
#' mean, median, minimum, maximum, and count.
#'
#' @param df Tibble or data frame containing variables for computing summary statistics.
#' Name is easily recognizable.
#' @param x A categorical variable by which rows are grouped.
#' It is named x because it is more generally used and easy to identify.
#' @param y A numeric variable for computing summary statistics.
#' It is named y because it is more generally used and easy to identify.
#' @param na.rm Gives the option to either remove or retain missing values.
#' It is a generally used argument to specify whether or not to remove missing values.
#'
#' @return A list object with 2 items: a tibble or data frame and a ggplot object- boxplot.
#' @importFrom stats "median"
#' @importFrom rlang .data
#'
#' @references Syntax suggested on StackOverflow by Gabra
#' https://stackoverflow.com/questions/40102613/ggplot2-adding-sample-size-information-to-x-axis-tick-labels
#' https://dplyr.tidyverse.org/articles/programming.html
#'
#' @examples
#' summarize_data(gapminder::gapminder, continent, lifeExp)
#' summarize_data(gapminder::gapminder, country, gdpPercap)
#' @export

summarize_data <- function(df, x, y, na.rm = TRUE) {
  val1 <- eval(substitute(x), df)
  val2 <- eval(substitute(y), df)
  if (!(is.character(val1) || is.factor(val1))) {
    stop('This function only works with a categorical input as x.\n',
         'You have provided an object of class: ', class(val1))
  }
  if (!is.numeric(val2)) {
    stop("This function only works with a numeric input as y.\n",
         "You have provided a variable of class: ", class(val2))
  }

  df2 <- df %>%
    dplyr::group_by({{ x }}) %>%
    dplyr::mutate(var_count = dplyr::n()) %>%
    dplyr::mutate(x_label = paste0({{ x }}, '\nN = ',.data$var_count))

  summary_df <- df2 %>%
    dplyr::summarise(mean = mean({{ y }}, na.rm = na.rm),
                    median = stats::median({{ y }}, na.rm = na.rm),
                    min = min({{ y }}, na.rm = na.rm),
                    max = max({{ y }}, na.rm = na.rm),
                    n = dplyr::n())

  summary_plot <- df2 %>%
    ggplot2::ggplot(ggplot2::aes(.data$x_label, {{ y }})) +
    ggplot2::geom_boxplot() +
    ggplot2::theme_minimal()

  return(list(summary_df, summary_plot))
}
