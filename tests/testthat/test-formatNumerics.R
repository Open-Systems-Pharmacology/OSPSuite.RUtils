test_that("Formatting numerics work properly", {
  formatNumerics(log(c(12, 15, 0.3)), digits = 1, scientific = TRUE)

  # Format a data.frame
  x <- data.frame(parameter = c("a", "b", "c"), value = c(1, 110.4, 6.666))
  formatNumerics(x, digits = 2, scientific = FALSE)
})
