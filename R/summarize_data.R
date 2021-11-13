#' Compute summary statistics, produce a tibble or data frame and a boxplot
#'
#' This function computes summary statistics on a numeric variable
#' grouped by a categorical variable. The summary statistics include
#' mean, median, minimum, maximum, and count. It also
#' produces a boxplot.
#'
#' @param df Tibble or data frame containing variables for computing summary statistics.
#' @param x A categorical variable by which rows are grouped.
#' @param y A numeric variable for computing summary statistics.
#' @return A tibble or data frame containing summary statistics and a boxplot.
#' @examples
#' summarize_data(gapminder::gapminder, continent, lifeExp)
#' summarize_data(palmerpenguins::penguins, species, bill_length_mm)
#' @export
#'
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

  summary_df <- df %>%
    dplyr::group_by({{ x }}) %>%
    dplyr::summarise(mean := mean({{ y }}, na.rm = na.rm),
              stats::median := median({{ y }}, na.rm = na.rm),
              min := min({{ y }}, na.rm = na.rm),
              max := max({{ y }}, na.rm = na.rm),
              dplyr::n := n())

  summary_plot <- df %>% ggplot2::ggplot(ggplot2::aes({{ x }}, {{ y }})) +
    ggplot2::geom_boxplot()

  return(list(summary_df, summary_plot))
}
