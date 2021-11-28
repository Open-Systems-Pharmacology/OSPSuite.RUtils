test_that("formatNumerics work as expected", {
  # vector
  x <- formatNumerics(log(c(12, 15, 0.3)), digits = 1, scientific = TRUE)
  expect_equal(x, c("2.5e+00", "2.7e+00", "-1.2e+00"))

  # dataframe
  df <- data.frame(
    parameter = c("a", "b", "c"),
    value = c(1, 110.4, 6.666),
    stringsAsFactors = FALSE
  )
  expect_equal(
    formatNumerics(df, digits = 2, scientific = FALSE),
    structure(list(parameter = c("a", "b", "c"), value = c(
      "1.00",
      "110.40", "6.67"
    )), row.names = c(NA, -3L), class = "data.frame")
  )
})
