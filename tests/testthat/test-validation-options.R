# validateIsOption --------------------------------------------------------

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
    valueRange = c(1L, 1e5L),
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
  maxIterations = 10000L,
  convergenceThreshold = 0.02
)

test_that("validateIsOption() handles valid options correctly", {
  expect_null(
    validateIsOption(defaultOptions, validOptions)
  )
})

test_that("validateIsOption() auto-converts numerics to integers with warning", {
  testOptions <- modifyList(defaultOptions, list(numCores = 1))
  expect_null(
    validateIsOption(testOptions, validOptions)
  )
})

test_that("validateIsOption() auto-converts numerics to integers with warning", {
  testOptions <- modifyList(defaultOptions, list(maxIterations = 1000))
  expect_warning(
    validateIsOption(testOptions, validOptions),
    "Numeric value automatically converted to integer for validation"
  )
})

test_that("validateIsOption() errors on non-list 'options'", {
  expect_error(
    validateIsOption(options = "a", validOptions = validOptions),
    "argument 'options' is of type 'character', but expected 'list'"
  )
  expect_error(
    validateIsOption(options = NULL, validOptions = validOptions),
    "argument 'options' is of type 'NULL', but expected 'list'"
  )
})

test_that("isValidOption() errors on non-list `validOptions`", {
  expect_error(
    validateIsOption(defaultOptions, validOptions = 1.2),
    "argument 'validOptions' is of type 'numeric', but expected 'list'"
  )
  expect_error(
    validateIsOption(options = defaultOptions, validOptions = NULL),
    "argument 'validOptions' is of type 'NULL', but expected 'list'"
  )
})

test_that("validateIsOption() errors when option values exceed expected length", {
  testOptions <- modifyList(defaultOptions, list(includeInteractions = c(TRUE, FALSE)))
  expect_error(
    validateIsOption(testOptions, validOptions),
    "includeInteractions .* Object should be of length '1', but is of length '2'"
  )
})

test_that("validateIsOption() type mismatches trigger errors", {
  invalidOptions <- modifyList(defaultOptions, list(maxIterations = Inf))
  expect_warning(
    expect_error(
      validateIsOption(invalidOptions, validOptions),
      "maxIterations .* argument 'x' is of type 'numeric', but expected 'integer'"
    )
  )
  invalidOptions <- modifyList(defaultOptions, list(includeInteractions = "notValid"))
  expect_error(
    validateIsOption(invalidOptions, validOptions),
    "includeInteractions .* argument 'x' is of type 'character', but expected 'logical'"
  )
  invalidOptions <- modifyList(defaultOptions, list(convergenceThreshold = "low"))
  expect_error(
    validateIsOption(invalidOptions, validOptions),
    "argument 'x' is of type 'character', but expected 'numeric'"
  )
})

test_that("validateIsOption() errors when NA values are present and not allowed", {
  testOptions <- modifyList(defaultOptions, list(maxIterations = NA_integer_))
  expect_error(
    validateIsOption(testOptions, validOptions),
    "maxIterations .* NA values are not allowed"
  )
})

test_that("validateIsOption() flags out-of-range and invalid values", {
  invalidOptions <- modifyList(defaultOptions, list(maxIterations = 1e6L))
  expect_error(
    validateIsOption(invalidOptions, validOptions),
    "maxIterations .* Value\\(s\\) out of the allowed range"
  )
  invalidOptions <- modifyList(defaultOptions, list(convergenceThreshold = 2))
  expect_error(
    validateIsOption(invalidOptions, validOptions),
    "convergenceThreshold .* Value\\(s\\) out of the allowed range"
  )
  invalidOptions <- modifyList(defaultOptions, list(optimizationMethod = "none"))
  expect_error(
    validateIsOption(invalidOptions, validOptions),
    "optimizationMethod .* Value\\(s\\) 'none' not included in allowed values"
  )
})

test_that("validateIsOption() correctly handles NULL values per configuration", {
  invalidOptions <- modifyList(defaultOptions, list(maxIterations = NULL), keep.null = TRUE)
  expect_error(
    validateIsOption(invalidOptions, validOptions),
    "maxIterations .* argument 'x' is of type 'NULL', but expected 'vector'"
  )
  invalidOptions <- modifyList(defaultOptions, list(convergenceThreshold = NULL))
  expect_null(
    validateIsOption(invalidOptions, validOptions)
  )
})
