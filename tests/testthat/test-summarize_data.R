test_that("the two means are identical", {
    summary1 <- gapminder::gapminder %>%
                dplyr::group_by(continent) %>%
                dplyr::summarize(mean = mean(lifeExp, na.rm = TRUE))
    summary1$mean

    summary2 <- summarize_data(gapminder::gapminder, continent, lifeExp)
    summary2[[1]]$mean
  expect_identical(summary1$mean, summary2[[1]]$mean)
})

test_that("the function returns a list", {
  expect_type(summarize_data(gapminder::gapminder, continent, lifeExp), "list")
})

test_that("the use of a numeric variable for x returns an error", {
  expect_error(summarize_data(gapminder::gapminder, pop, lifeExp))
})

test_that("the two mean vectors have NAs", {
    na_present_1 <- gapminder::gapminder %>%
                    dplyr::group_by(continent) %>%
                    dplyr::summarise(mean = mean(lifeExp))
    na_present_2 <- summarize_data(gapminder::gapminder, continent, lifeExp, na.rm = FALSE)
  expect_equal(na_present_1$mean, na_present_2[[1]]$mean)
})

test_that("silent when function successfully creates a boxplot", {
          plot <- summarize_data(gapminder::gapminder, continent, lifeExp)
  expect_silent(print(plot[[2]]))
})
