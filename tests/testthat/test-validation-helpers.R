
test_that("validateIsInteger works as expected", {
  # should return NULL
  expect_null(validateIsInteger(5))
  expect_null(validateIsInteger(5L))
  expect_null(validateIsInteger(c(1L, 5)))
  expect_null(validateIsInteger(c(1L, 5L)))

  # not integers, so should error
  expect_error(validateIsInteger(c(1.5, 5)))
  expect_error(validateIsInteger(2.4))
  expect_error(validateIsInteger("2"))
  expect_error(validateIsInteger(TRUE))
})

test_that("It accepts an empty string", {
  expect_error(validatePathIsAbsolute(""), NA)
})

test_that("It accepts a path without wildcard", {
  path <- "Organism|path"
  expect_error(validatePathIsAbsolute(path), NA)
})

test_that("It throws an error for a path with a wildcard", {
  path <- "Organism|*path"
  expect_error(validatePathIsAbsolute(path), messages$errorEntityPathNotAbsolute(path))
})

test_that("It does not throw an error when a number is indeed an integer", {
  validateIsOfType(object = 2, type = "integer")
  # This is just to have an expectation. Validation throws if not ok
  expect_true(TRUE)
})

test_that("It does throw an error when a number is not an integer", {
  expect_error(validateIsOfType(object = 2.5, type = "integer"))
})

test_that("It does not throw an error when a validating that a string in an integer", {
  expect_error(validateIsInteger("s"), messages$errorWrongType(objectName = "\"s\"", expectedType = "integer", type = "character"))
})

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


test_that("Checks method of type 'validate' work properly", {
  # NULL when checks succeed
  expect_null(validateIsSameLength(A, A))
  expect_null(validateIsOfLength(A, 3))
  expect_null(validateIsOfType(A, "data.frame"))
  expect_null(validateIsIncluded("col3", names(A)))
  expect_null(validateIsIncluded(NULL, nullAllowed = TRUE))
  expect_null(validateIsString("x"))
  expect_null(validateIsNumeric(1.2))
  expect_null(validateIsNumeric(NULL, nullAllowed = TRUE))
  expect_null(validateIsInteger(5))
  expect_null(validateIsInteger(NULL, nullAllowed = TRUE))
  expect_null(validateIsLogical(TRUE))

  errorMessageIsSameLength <- "Arguments 'A, B' must have the same length, but they don't!"
  errorMessageIsOfLength <- "Object should be of length '5', but is of length '3' instead."
  errorMessageIsOfType <- "argument 'A' is of type 'data.frame', but expected 'character'!"
  errorMessageIsIncluded <- "Values 'col4' are not in included in parent values: 'col1, col2, col3'."

  # Error when checks fail
  expect_error(validateIsSameLength(A, B), errorMessageIsSameLength)
  expect_error(validateIsOfLength(A, 5), errorMessageIsOfLength)
  expect_error(validateIsOfType(A, "character"), errorMessageIsOfType)
  expect_error(validateIsIncluded("col4", names(A)), errorMessageIsIncluded)
})


test_that("enum validation works as expected", {
  expect_error(validateEnumValue(NULL))
  expect_null(validateEnumValue(NULL, nullAllowed = TRUE))

  Symbol <- enum(c(Diamond = 1, Triangle = 2, Circle = 2))
  expect_null(validateEnumValue(1, Symbol))
  expect_error(validateEnumValue(4, Symbol))
})
