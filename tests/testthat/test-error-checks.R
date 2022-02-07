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

x <- 1
y <- 2
z <- 3

a <- 1

test_that("Checks if type 'is' and 'has' work properly", {
  # Output is logical
  expect_type(isSameLength(A, A), "logical")
  expect_type(isOfLength(A, 3), "logical")
  expect_type(isOfType(A, "data.frame"), "logical")
  expect_type(isIncluded("col3", names(A)), "logical")

  # Output is `TRUE`
  expect_true(isSameLength(A, A))
  expect_true(isSameLength(c(1, 2), c("x", "y"), c(TRUE, FALSE)))
  expect_true(isSameLength(list(1, 2), list("x", "y"), list(TRUE, FALSE)))
  expect_true(isOfLength(A, 3))
  expect_true(isIncluded("col3", names(A)))
  expect_true(isIncluded(2, 2))
  expect_true(isIncluded("x", list("w", "x", 1, 2)))
  expect_true(isIncluded(c("x", "y"), c("a", "y", "b", "x")))
  expect_true(isIncluded(list("x", "y"), list("a", "b", "x", "y")))
  expect_true(isIncluded(a, list(x, y, z)))
  expect_true(isIncluded(a, c(x, y, z)))
  expect_true(isOfType(A, "data.frame"))
  expect_true(isOfType(c(1, "x"), c("numeric", "character")))
  expect_true(isOfType(NULL, nullAllowed = TRUE))

  # Output is `FALSE`
  expect_false(isSameLength(A, B))
  expect_false(isOfLength(A, 5))
  expect_false(isSameLength(c(1, 2), c("x"), c(TRUE, FALSE)))
  expect_false(isSameLength(list(1, 2), list("x", "y"), list(FALSE)))
  expect_false(isOfType(A, "character"))
  expect_false(isIncluded("col4", names(A)))
  expect_false(isIncluded(1, 2))
  expect_false(isIncluded("x", c("w", "a", "y")))
  expect_false(isIncluded(c("x", "y"), c("a", "b", "x")))
  expect_false(isIncluded(list("x", "y"), list("a", "b", "x")))
  expect_false(isIncluded(a, list(y, z)))
  expect_false(isIncluded(a, c(y, z)))
  expect_false(isIncluded(NULL))
  expect_false(isIncluded(character()))

  expect_equal(isOfType(NULL, nullAllowed = "a"), "a")

  expect_true(hasUniqueValues(c("x", NA, "y")))
  expect_false(hasUniqueValues(c("x", NA, "y", "x")))

  expect_true(isFileExtension("enum.R", "R"))
  expect_false(isFileExtension("enum.R", "pkml"))
})
