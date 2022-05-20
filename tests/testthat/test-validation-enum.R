Symbol <- enum(c(Diamond = 1, Triangle = 2, Circle = 2))

test_that("validateEnumValue returns `NULL` when validation is successful", {
  expect_null(validateEnumValue(NULL, nullAllowed = TRUE))
  expect_null(validateEnumValue(1, Symbol))
})

test_that("validateEnumValue produces error when validation is unsuccessful", {
  expect_error(validateEnumValue(4, Symbol))
  expect_error(validateEnumValue(NULL))
})
