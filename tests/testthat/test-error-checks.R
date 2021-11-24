A <- data.frame(
  col1 = c(1, 2, 3),
  col2 = c(4, 5, 6),
  col3 = c(7, 8, 9)
)

B <- data.frame(
  col1 = c(1, 2, 3),
  col2 = c(4, 5, 6),
  col3 = c(7, 8, 9),
  col4 = c(7, 8, 9)
)

test_that("Checks if type 'is' and 'has' work properly", {
  # Output is logical
  expect_type(isSameLength(A, A), "logical")
  expect_type(isOfLength(A, 3), "logical")
  expect_type(isOfType(A, "data.frame"), "logical")
  expect_type(isIncluded("col3", names(A)), "logical")

  # Output is TRUE
  expect_true(isSameLength(A, A))
  expect_true(isOfLength(A, 3))
  expect_true(isOfType(A, "data.frame"))
  expect_true(isIncluded("col3", names(A)))

  # Output is FALSE
  expect_false(isSameLength(A, B))
  expect_false(isOfLength(A, 5))
  expect_false(isOfType(A, "character"))
  expect_false(isIncluded("col4", names(A)))

  expect_true(hasUniqueValues(c("x", NA, "y")))
  expect_false(hasUniqueValues(c("x", NA, "y", "x")))

  expect_true(isFileExtension("enum.R", "R"))
  expect_false(isFileExtension("enum.R", "pkml"))
})
