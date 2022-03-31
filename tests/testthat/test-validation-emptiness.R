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

# isEmpty ------------------------------

test_that("isEmpty returns `TRUE` when objects are empty", {
  expect_true(isEmpty(NULL))
  expect_true(isEmpty(data.frame()))
  expect_true(isEmpty(list()))
  expect_true(isEmpty(character()))
  expect_true(isEmpty(numeric()))
  expect_true(isEmpty(A[FALSE, ]))
})

test_that("isEmpty returns `FALSE` when objects are not empty", {
  expect_false(isEmpty(a))
  expect_false(isEmpty(A))
  expect_false(isEmpty(list("x", "y")))
  expect_false(isEmpty(""))
})

# validateIsNotEmpty ------------------------------

test_that("validateIsNotEmpty returns `NULL` when objects are not empty", {
  expect_null(validateIsNotEmpty(A))
  expect_null(validateIsNotEmpty(""))
})

test_that("validateIsNotEmpty produces error when objects are empty", {
  errorMessageIsEmpty <- "argument 'NULL' is empty!"
  expect_error(validateIsNotEmpty(NULL), errorMessageIsEmpty)
})

# hasEmptyString ------------------------------

test_that("hasEmptyString returns `TRUE` when strings are empty", {
  expect_true(hasEmptyString(character(0)))
  expect_true(hasEmptyString(c("", "y")))
  expect_true(hasEmptyString(list("", "y")))
  expect_true(hasEmptyString(c("", NA)))
  expect_true(hasEmptyString(list("", NA)))
  expect_true(hasEmptyString(NA))
  expect_true(hasEmptyString(c(NA, "x", "y")))
  expect_true(hasEmptyString(list(NA, "x", "y")))
})

test_that("hasEmptyString returns `FALSE` when string are not empty", {
  expect_false(hasEmptyString("   abc   "))
  expect_false(hasEmptyString(c("x", "y")))
  expect_false(hasEmptyString(list("x", "y")))
})
