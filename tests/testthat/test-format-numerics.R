test_that("formatNumerics returns character for integer, numeric or character objects", {
  # integer
  expect_type(formatNumerics(2L, digits = 1, scientific = TRUE), "character")
  # numeric
  expect_type(formatNumerics(2, digits = 1, scientific = TRUE), "character")
  # character
  expect_type(formatNumerics("2", digits = 1, scientific = TRUE), "character")
})


test_that("formatNumerics works as expected", {
  # integer and character as is
  expect_equal(formatNumerics(2L, digits = 1, scientific = TRUE), "2")
  expect_equal(formatNumerics("2", digits = 1, scientific = TRUE), "2")
  # numeric is formated
  expect_equal(formatNumerics(2, digits = 1, scientific = TRUE), "2.0e+00")

  # vector
  x <- formatNumerics(log(c(12, 15, 0.3)), digits = 1, scientific = TRUE)
  expect_equal(x, c("2.5e+00", "2.7e+00", "-1.2e+00"))

  y <- formatNumerics(c(12L, 15L, 3L))
  expect_equal(y, c("12", "15", "3"))

  # data.frame
  df <- data.frame(
    parameter = c("a", "b", "c"),
    value = c(1, 110.4, 6.666),
    stringsAsFactors = FALSE
  )
  expect_equal(
    formatNumerics(df, digits = 2, scientific = FALSE),
    structure(
      list(
        parameter = c("a", "b", "c"),
        value = c(
          "1.00",
          "110.40",
          "6.67"
        )
      ),
      row.names = c(NA, -3L),
      class = "data.frame"
    )
  )
})


test_that("formatNumerics handles empty collections correctly", {
  # Empty list
  empty_list <- list()
  expect_equal(formatNumerics(empty_list), empty_list)
  
  # Empty data.frame
  empty_df <- data.frame()
  expect_equal(formatNumerics(empty_df), empty_df)
  
  # List with empty vector
  list_with_empty <- list(a = numeric(0), b = character(0))
  result <- formatNumerics(list_with_empty, digits = 2)
  expect_equal(result$a, character(0))
  expect_equal(result$b, character(0))
})


test_that("formatNumerics handles nested structures correctly", {
  # Nested list with numeric values
  nested_list <- list(
    level1 = list(
      level2_numeric = c(1.234, 5.678),
      level2_char = "test"
    ),
    top_numeric = 9.999
  )
  
  result <- formatNumerics(nested_list, digits = 1, scientific = FALSE)
  
  # Check nested structure is preserved
  expect_true(is.list(result$level1))
  expect_equal(result$level1$level2_numeric, c("1.2", "5.7"))
  expect_equal(result$level1$level2_char, "test")
  expect_equal(result$top_numeric, "10.0")
  
  # Deeply nested list
  deep_nested <- list(
    a = list(
      b = list(
        c = 3.14159
      )
    )
  )
  
  result_deep <- formatNumerics(deep_nested, digits = 2, scientific = FALSE)
  expect_equal(result_deep$a$b$c, "3.14")
})


test_that("formatNumerics handles mixed type lists correctly", {
  # List with different types
  mixed_list <- list(
    numeric_val = 1.5,
    integer_val = 5L,
    char_val = "hello",
    logical_val = TRUE,
    numeric_vec = c(2.3, 4.5)
  )
  
  result <- formatNumerics(mixed_list, digits = 1, scientific = FALSE)
  
  expect_equal(result$numeric_val, "1.5")
  expect_equal(result$integer_val, "5")
  expect_equal(result$char_val, "hello")
  expect_equal(result$logical_val, TRUE)  # logical unchanged
  expect_equal(result$numeric_vec, c("2.3", "4.5"))
})
