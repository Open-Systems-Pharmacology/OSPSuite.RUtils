# validateVectorRange -----------------------------------------------------

test_that("validateVectorRange() detects invalid 'valueRange' type correctly", {
  expect_error(
    validateVectorRange(x = c(1, 2), type = "numeric", valueRange = TRUE),
    "argument 'valueRange' is of type 'logical', but expected 'numeric'"
  )
  expect_error(
    validateVectorRange(x = c(1, 2), type = "numeric", valueRange = c("1", "2")),
    "argument 'valueRange' is of type 'character', but expected 'numeric'"
  )
  expect_error(
    validateVectorRange(x = 1:5, type = "integer", valueRange = c(1, 3.5)),
    "argument 'valueRange' is of type 'numeric', but expected 'integer'"
  )
  expect_error(
    validateVectorRange(x = c("1", "2"), type = "character", valueRange = c(1, 2)),
    " argument 'valueRange' is of type 'numeric', but expected 'character'"
  )
  expect_error(
    validateVectorRange(x = as.Date(c(1, 2)), type = "Date", valueRange = c(1, 2)),
    "argument 'valueRange' is of type 'numeric', but expected 'Date'"
  )
})

test_that("validateVectorRange() throws an error for unsupported 'valueRange' types", {
  expect_error(
    validateVectorRange(x = factor(c("low", "high")), type = "factor", valueRange = c("low", "high")),
    "'valueRange' is not applicable for the type: 'factor'"
  )
  expect_error(
    validateVectorRange(x = c(TRUE, FALSE), type = "logical", valueRange = c(0, 1)),
    "'valueRange' is not applicable for the type: 'logical'"
  )
})

test_that("validateVectorRange() identifies errors in 'valueRange' definitions", {
  expect_error(
    validateVectorRange(x = c("a", "b"), type = "character", valueRange = c("a", NA)),
    "'valueRange' must not contain NA values"
  )
  expect_error(
    validateVectorRange(x = c(1L, 2L), type = "integer", valueRange = c(1L, NA)),
    "'valueRange' must not contain NA values"
  )
  expect_error(
    validateVectorRange(x = c(1, 2), type = "numeric", valueRange = c(1)),
    "'valueRange' must be a vector of length 2 and in ascending order, but got '1'"
  )
  expect_error(
    validateVectorRange(x = c(1, 2), type = "numeric", valueRange = c(2, 1)),
    "'valueRange' must be a vector of length 2 and in ascending order, but got '2, 1'"
  )
})

test_that("validateVectorRange() identifies values outside 'valueRange'", {
  expect_error(
    validateVectorRange(x = c(-1, 2, 5), type = "numeric", valueRange = c(0, 10)),
    "Value\\(s\\) out of the allowed range: \\[0, 10\\]"
  )
  expect_error(
    validateVectorRange(x = 1:5, type = "integer", valueRange = c(1L, 3L)),
    "Value\\(s\\) out of the allowed range: \\[1, 3\\]"
  )
  expect_error(
    validateVectorRange(x = c("a", "b", "z"), type = "character", valueRange = c("a", "c")),
    "Value\\(s\\) out of the allowed range: \\[a, c\\]"
  )
  expect_error(
    validateVectorRange(
      x = as.Date(c("2020-01-01", "2020-01-20")), type = "Date",
      valueRange = as.Date(c("2020-01-01", "2020-01-10"))
    ),
    "Value\\(s\\) out of the allowed range: \\[2020-01-01, 2020-01-10\\]"
  )
})

test_that("validateVectorRange() successfully validates when values are within 'valueRange'", {
  expect_null(
    validateVectorRange(NULL, valueRange = NULL)
  )
  expect_null(
    validateVectorRange(x = c(1, 2), type = "numeric", valueRange = NULL)
  )
  expect_null(
    validateVectorRange(x = c(1, 2), type = "numeric", valueRange = c(1, 2))
  )
  expect_null(
    validateVectorRange(x = c(1, 2, NA), type = "numeric", valueRange = c(1, 2))
  )
  expect_null(
    validateVectorRange(x = c(-1L, 1L), type = "integer", valueRange = c(-1L, 1L))
  )
  expect_null(
    validateVectorRange(x = c("a", "b"), type = "character", valueRange = c("a", "z"))
  )
  expect_null(
    validateVectorRange(
      x = as.Date(c("2020-01-01", "2021-01-01")), type = "Date",
      valueRange = as.Date(c("2020-01-01", "2022-01-01"))
    )
  )
})


# validateVectorValues ----------------------------------------------------

test_that("validateVectorValues() detects invalid 'allowedValues' type correctly", {
  expect_error(
    validateVectorValues(x = c(1, 2), type = "numeric", allowedValues = TRUE),
    "argument 'allowedValues' is of type 'logical', but expected 'numeric'"
  )
  expect_error(
    validateVectorValues(x = c(1, 2), type = "numeric", allowedValues = c("1", "2")),
    "argument 'allowedValues' is of type 'character', but expected 'numeric'"
  )
  expect_error(
    validateVectorValues(x = 1:5, type = "integer", allowedValues = c(1, 3)),
    "argument 'allowedValues' is of type 'numeric', but expected 'integer'"
  )
  expect_error(
    validateVectorValues(x = c(NA_real_), type = "numeric", allowedValues = c(NA), naAllowed = TRUE),
    "argument 'allowedValues' is of type 'logical', but expected 'numeric'"
  )
  expect_error(
    validateVectorValues(x = c("a", "b"), type = "character", allowedValues = c(1, 2, NA)),
    "argument 'allowedValues' is of type 'numeric', but expected 'character'"
  )
  expect_error(
    validateVectorValues(x = as.Date(c(1, 2)), type = "Date", allowedValues = c(1, 2)),
    "argument 'allowedValues' is of type 'numeric', but expected 'Date'"
  )
  expect_error(
    validateVectorValues(x = as.factor(c(1, 2)), type = "factor", allowedValues = c(1, 2)),
    "argument 'allowedValues' is of type 'numeric', but expected 'factor'"
  )
})

test_that("validateVectorValues() identifies values which are not allowed correctly", {
  expect_error(
    validateVectorValues(x = c(1, 2, 3), type = "numeric", allowedValues = c(1, 2)),
    "Value\\(s\\) '3' not in included in allowed values: '1, 2'"
  )
  expect_error(
    validateVectorValues(x = c("a", "b", "z"), type = "character", allowedValues = c("a", "b")),
    "Value\\(s\\) 'z' not in included in allowed values: 'a, b'"
  )
  expect_error(
    validateVectorValues(x = LETTERS[1:25], type = "character", allowedValues = LETTERS[1:10]),
    "Value\\(s\\) 'K, L, M, N, O ...' not in included in allowed values: 'A, B, C, D, E ..."
  )
  expect_error(
    validateVectorValues(x = TRUE, type = "logical", allowedValues = FALSE),
    "Value\\(s\\) 'TRUE' not in included in allowed values: 'FALSE'"
  )
  expect_error(
    validateVectorValues(x = as.factor(c(1, 2, 3)), type = "factor", allowedValues = as.factor(c(1, 2))),
    "Value\\(s\\) '3' not in included in allowed values: '1, 2'"
  )
  expect_error(
    validateVectorValues(x = c(1, NA), type = "numeric", allowedValues = c(1, 2), naAllowed = FALSE),
    "Value\\(s\\) 'NA' not in included in allowed values: '1, 2'"
  )
  expect_error(
    validateVectorValues(x = c(1, NA), type = "numeric", allowedValues = c(1, 2, NA), naAllowed = FALSE),
    "Value\\(s\\) 'NA' not in included in allowed values: '1, 2'"
  )
})

test_that("validateVectorValues() successfully validates when values are allowed", {
  expect_null(
    validateVectorValues(NULL, allowedValues = NULL)
  )
  expect_null(
    validateVectorValues(x = c(1, 2), type = "numeric", allowedValues = NULL)
  )
  expect_null(
    validateVectorValues(x = c(1, 2), type = "numeric", allowedValues = c(1, 2, 3))
  )
  expect_null(
    validateVectorValues(x = c(1, NA), type = "numeric", allowedValues = c(1, 2, 3), naAllowed = TRUE)
  )
  expect_null(
    validateVectorValues(x = c(NA_real_), type = "numeric", allowedValues = c(NA_real_), naAllowed = TRUE)
  )
  expect_null(
    validateVectorValues(x = c(1, 2), type = "numeric", allowedValues = c(1, 2, 3, NA), naAllowed = FALSE)
  )
  expect_null(
    validateVectorValues(x = c("a", "b"), type = "character", allowedValues = c("a", "b", "c"))
  )
  expect_null(
    validateVectorValues(
      x = as.factor(c("a", "b")), type = "factor", allowedValues = as.factor(c("a", "b", "c"))
    )
  )
  expect_null(
    validateVectorValues(x = c(TRUE), type = "logical", allowedValues = c(TRUE, FALSE))
  )
  expect_null(
    validateVectorValues(
      x = as.Date(c("2020-01-01", "2022-01-01")), type = "Date",
      allowedValues = as.Date(c("2020-01-01", "2021-01-01", "2022-01-01"))
    )
  )
})


# validateVector ----------------------------------------------------------

test_that("validateVector() throws an error when 'nullAllowed' argument is not logical", {
  expect_error(
    validateVector(x = NULL, type = "numeric", nullAllowed = "a"),
    "argument 'nullAllowed' is of type 'character', but expected 'logical'"
  )
})
test_that("validateVector() throws an error when `naAllowed` argument is not logical", {
  expect_error(
    validateVector(x = c(1, 2), type = "numeric", naAllowed = 1),
    "argument 'naAllowed' is of type 'double', but expected 'logical'"
  )
})

test_that("validateVector() throws an error when 'type' argument is not specified", {
  expect_error(
    validateVector(x = NULL, nullAllowed = FALSE),
    "The 'type' argument must be specified"
  )
})
test_that("validateVector() throws an error when `type` argument is not valid", {
  expect_error(
    validateVector(x = c(1, 2), type = "invalidType"),
    "argument 'type' is 'invalidType'"
  )
})

test_that("validateVector() detects incorrect vector type", {
  expect_error(
    validateVector(x = c("a", "b"), type = "numeric"),
    "argument 'x' is of type 'character', but expected 'numeric'"
  )
  expect_error(
    validateVector(x = c(1L, 2L), type = "numeric"),
    "argument 'x' is of type 'integer', but expected 'numeric'"
  )
  expect_error(
    validateVector(x = c(NA, NA), type = "numeric", naAllowed = TRUE),
    "argument 'x' is of type 'logical', but expected 'numeric'"
  )
  expect_error(
    validateVector(x = c(1L, 2L), type = "double"),
    "argument 'x' is of type 'integer', but expected 'numeric'"
  )
  expect_error(
    validateVector(x = c(1, 2), type = "character"),
    "argument 'x' is of type 'numeric', but expected 'character'"
  )
  expect_error(
    validateVector(x = as.factor(c(1L, 2L)), type = "integer"),
    "argument 'x' is of type 'factor', but expected 'integer'"
  )
  expect_error(
    validateVector(x = as.Date(c(1, 2)), type = "factor", allowedValues = c(1, 2)),
    "argument 'x' is of type 'Date', but expected 'factor'"
  )
  expect_error(
    validateVector(x = c(TRUE, FALSE), type = "integer"),
    "argument 'x' is of type 'logical', but expected 'integer'"
  )
  expect_error(
    validateVector(x = as.Date(c(1, 2)), type = "POSIXct"),
    "argument 'type' is 'POSIXct', but only .* supported"
  )
})

test_that("validateVector() throws an error when vector is NULL but nullAllowed is FALSE", {
  expect_error(
    validateVector(x = NULL, type = "numeric", nullAllowed = FALSE),
    "argument 'x' is of type 'NULL', but expected 'vector'"
  )
})

test_that("validateVector() throws an error when x has NA but naAllowed is FALSE", {
  expect_error(
    validateVector(x = c(1, NA), type = "numeric", naAllowed = FALSE),
    "NA values are not allowed"
  )
  expect_error(
    validateVector(x = c(1.2, 2.6, NA), type = "numeric", allowedValues = c(1.2, NA), naAllowed = FALSE),
    "NA values are not allowed"
  )
})

test_that("validateVector() returns TRUE when numeric vector meets validation criteria", {
  expect_null(validateVector(x = c(1.2, 2), type = "numeric"))
  expect_null(validateVector(x = c(1.2, 2), type = "numeric", valueRange = c(1, 3)))
  expect_null(validateVector(x = c(1, 3), type = "numeric", valueRange = c(1, 3)))
  expect_null(validateVector(x = c(1), type = "numeric", valueRange = c(1, 1)))
  expect_null(validateVector(x = NULL, type = "numeric", nullAllowed = TRUE))
  expect_null(validateVector(x = c(NA_real_, NA_real_), type = "numeric", naAllowed = TRUE))
})

test_that("validateVector() returns TRUE when integer vector meets validation criteria", {
  expect_null(validateVector(x = 1:5, type = "integer"))
  expect_null(validateVector(x = c(1L, NA), type = "integer", naAllowed = TRUE))
  expect_null(validateVector(x = c(1L, 3L), type = "integer", valueRange = c(1L, 5L)))
  expect_null(validateVector(x = 1:5, type = "integer", allowedValues = 1:10))
  expect_null(validateVector(x = 5L, type = "integer"))
})

test_that("validateVector() returns TRUE when character vector meets validation criteria", {
  expect_null(validateVector(x = c("a", "b"), type = "character"))
  expect_null(validateVector(x = c("1", NA), type = "character", naAllowed = TRUE))
  expect_null(validateVector(x = c("a", "b"), type = "character", allowedValues = c("a", "b", "c")))
  expect_null(validateVector(x = "a", type = "character", allowedValues = c("a")))
  expect_null(validateVector(x = c("a", "d"), type = "character", valueRange = c("a", "z")))
  expect_null(validateVector(x = NULL, type = "character", nullAllowed = TRUE))
})

test_that("validateVector() returns TRUE when logical vector meets validation criteria", {
  expect_null(validateVector(x = c(TRUE, FALSE, TRUE), type = "logical"))
  expect_null(validateVector(x = c(TRUE), type = "logical"))
  expect_null(validateVector(x = c(FALSE), type = "logical", allowedValues = FALSE))
  expect_null(validateVector(x = c(NA, NA), type = "logical", naAllowed = TRUE))
  expect_null(validateVector(x = NULL, type = "logical", nullAllowed = TRUE))
})

test_that("validateVector() returns TRUE when factor vector meets validation criteria", {
  expect_null(validateVector(x = as.factor(c("high", "low")), type = "factor"))
  expect_null(
    validateVector(
      x = factor(c(1, 2), levels = 1:3), type = "factor",
      allowedValues = as.factor(c(1, 2, 3))
    )
  )
})
stop("here")

# isValidOption -----------------------------------------------------------

validOptions <- list(
  optimizationMethod = list(
    type = "character",
    allowedValues = c("gradientDescent", "geneticAlgorithm")
  ),
  includeInteractions = list(
    type = "logical"
  ),
  maxIterations = list(
    type = "integer",
    valueRange = c(1, 1e5),
    nullAllowed = FALSE
  ),
  convergenceThreshold = list(
    type = "numeric",
    valueRange = c(0, 0.1),
    nullAllowed = TRUE
  )
)

defaultOptions <- list(
  optimizationMethod = "gradientDescent",
  includeInteractions = TRUE,
  maxIterations = 10000,
  convergenceThreshold = 0.02
)

test_that("isValidOption() throws an error when 'options' argument is not a list", {
  expect_error(
    isValidOption(options = "a", validOptions = ValidOptions),
    "argument 'options' is of type 'character', but expected 'list'"
  )
})
test_that("isValidOption() throws an error when 'validOptions' argument is not a list", {
  expect_error(
    isValidOption(defaultOptions, validOptions = "a"),
    "argument 'validOptions' is of type 'character', but expected 'list'"
  )
  expect_error(
    isValidOption(options = defaultOptions, validOptions = NULL),
    "argument 'validOptions' is of type 'NULL', but expected 'list'"
  )
})
