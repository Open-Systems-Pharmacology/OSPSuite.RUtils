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

test_that("isSameLength returns `TRUE` when objects have same lengths", {
  expect_true(isSameLength(A, A))
  expect_true(isSameLength(c(1, 2), c("x", "y"), c(TRUE, FALSE)))
  expect_true(isSameLength(list(1, 2), list("x", "y"), list(TRUE, FALSE)))
  expect_true(isSameLength(character(), integer()))
})

test_that("isSameLength returns `FALSE` when objects have different lengths", {
  expect_false(isSameLength(A, B))
  expect_false(isSameLength(c(1, 2), c("x"), c(TRUE, FALSE)))
  expect_false(isSameLength(list(1, 2), list("x", "y"), list(FALSE)))
})


test_that("isOfLength returns `TRUE` when correct length is specified", {
  expect_true(isOfLength(A, 3L))
  expect_true(isOfLength(c(1, 2), 2L))
  expect_true(isOfLength(list("1", 2, 4.5, TRUE), 4L))
  expect_true(isOfLength(character(), 0L))
})

test_that("isOfLength returns `FALSE` when incorrect length is specified", {
  expect_false(isOfLength(A, 5))
  expect_false(isOfLength(c(1, 2), 3L))
  expect_false(isOfLength(list("1", 2, 4.5, TRUE), 3L))
  expect_false(isOfLength(character(), 1L))
})

test_that("isIncluded returns `TRUE` when base type values are included", {
  expect_true(isIncluded("col3", names(A)))
  expect_true(isIncluded(2, 2))
  expect_true(isIncluded("x", list("w", "x", 1, 2)))
  expect_true(isIncluded(c("x", "y"), c("a", "y", "b", "x")))
  expect_true(isIncluded(list("x", "y"), list("a", "b", "x", "y")))
  expect_true(isIncluded(a, list(x, y, z)))
  expect_true(isIncluded(a, c(x, y, z)))
})

test_that("isIncluded returns `TRUE` when compound type values are included", {
  skip_if_not(getRversion() > "4.1")

  expect_true(isIncluded(as.factor("a"), c("a", "b")))
  expect_true(isIncluded(c("a", "b"), as.factor(c("a", "b"))))
  expect_true(isIncluded(as.factor("a"), list("a", "b")))
  expect_true(isIncluded(list("a", "b"), as.factor(c("a", "b"))))
  expect_true(isIncluded(as.Date("1970-02-01"), c(as.Date("1970-02-01"), as.Date("1980-12-21"))))
  expect_true(isIncluded(as.Date("1970-02-01"), list(as.Date("1970-02-01"), as.Date("1980-12-21"))))
})

test_that("isIncluded returns `FALSE` when base type values are not included", {
  expect_false(isIncluded("col4", names(A)))
  expect_false(isIncluded(1, 2))
  expect_false(isIncluded("x", c("w", "a", "y")))
  expect_false(isIncluded(c("x", "y"), c("a", "b", "x")))
  expect_false(isIncluded(list("x", "y"), list("a", "b", "x")))
  expect_false(isIncluded(a, list(y, z)))
  expect_false(isIncluded(a, c(y, z)))
  expect_false(isIncluded(NULL))
  expect_false(isIncluded(character()))
})

test_that("isIncluded returns `FALSE` when compound type values are not included", {
  skip_if_not(getRversion() > "4.1")

  expect_false(isIncluded(as.factor("a"), c("d", "b")))
  expect_false(isIncluded(c("a", "b"), as.factor(c("d", "b"))))
  expect_false(isIncluded(as.factor("a"), list("c", "b")))
  expect_false(isIncluded(list("a", "b"), as.factor(c("c", "b"))))
  expect_false(isIncluded(as.Date("1970-02-01"), c(as.Date("1972-02-01"), as.Date("1980-12-21"))))
  expect_false(isIncluded(as.Date("1970-02-01"), list(as.Date("1980-02-01"), as.Date("1980-12-21"))))
})

test_that("isOfType doesn't work when `nullAllowed` argument is not logical", {
  expect_error(
    isOfType(NULL, nullAllowed = "a"),
    "argument 'nullAllowed' is of type 'character', but expected 'logical'"
  )

  expect_error(
    isOfType(NULL, nullAllowed = 1),
    "argument 'nullAllowed' is of type 'double', but expected 'logical'"
  )

  expect_error(
    isOfType(NULL, nullAllowed = 0L),
    "argument 'nullAllowed' is of type 'integer', but expected 'logical'"
  )
})

test_that("isOfType returns `TRUE` when values are of expected type", {
  expect_true(isOfType(A, "data.frame"))
  expect_true(isOfType(list(A, B), "data.frame"))
  expect_true(isOfType(c(1, "x"), c("numeric", "character")))
  expect_true(isOfType(logical(), "logical"))
  expect_true(isOfType(NULL, nullAllowed = TRUE))

  Person <- R6::R6Class("Person", list(
    name = NULL,
    initialize = function(name) self$name <- name
  ))

  Jack <- Person$new(name = "Jack")
  Jill <- Person$new(name = "Jill")
  tmp <- list(Jack, NULL, Jill)

  expect_true(isOfType(tmp, Person, nullAllowed = TRUE))
})

test_that("isOfType returns `FALSE` when values are not of expected type", {
  expect_false(isOfType(A, "character"))
})

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

test_that("hasOnlyDistinctValues returns `TRUE` if values are distinct", {
  expect_true(hasOnlyDistinctValues(c("x", NA, "y")))
  expect_true(hasOnlyDistinctValues(list("x", NA, "y")))
})

test_that("hasOnlyDistinctValues returns `FALSE` if values are repeated", {
  expect_false(hasOnlyDistinctValues(c("x", NA, "y", "x")))
  expect_false(hasOnlyDistinctValues(list("x", NA, "y", "x")))
})

test_that("isFileExtension returns `TRUE` if extension is as expected", {
  expect_true(isFileExtension("enum.R", "R"))
  expect_true(isFileExtension("DESCRIPTION", ""))
  expect_true(isFileExtension("foo.", ""))
  expect_true(isFileExtension("C:/Users/.gitignore", "gitignore"))
})

test_that("isFileExtension returns `FALSE` if extension is unexpected", {
  expect_false(isFileExtension("enum.R", "pkml"))
  expect_false(isFileExtension("DESCRIPTION", "R"))
})


test_that("validateIsFileExtension returns NULL if extension is as expected", {
  expect_null(validateIsFileExtension("enum.R", "R"))
  expect_null(validateIsFileExtension("DESCRIPTION", ""))
  expect_null(validateIsFileExtension("foo.", ""))
  expect_null(validateIsFileExtension("C:/Users/.gitignore", "gitignore"))
})

test_that("validateIsFileExtension produces error if extension is unexpected", {
  expect_error(
    validateIsFileExtension("enum.R", "pkml"),
    messages$errorWrongFileExtension("R", "pkml"),
    fixed = TRUE
  )

  expect_error(
    validateIsFileExtension("DESCRIPTION", "R"),
    messages$errorWrongFileExtension("", "R"),
    fixed = TRUE
  )
})
