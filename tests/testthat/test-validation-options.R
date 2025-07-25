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
    "(argument).*(options).*(is of type).*(character).*(but expected).*(list)"
  )
  expect_error(
    validateIsOption(options = NULL, validOptions = validOptions),
    "(argument).*(options).*(is of type).*(NULL).*(but expected).*(list)"
  )
})

test_that("isValidOption() errors on non-list `validOptions`", {
  expect_error(
    validateIsOption(defaultOptions, validOptions = 1.2),
    "(argument).*(validOptions).*(is of type).*(numeric).*(but expected).*(list)"
  )
  expect_error(
    validateIsOption(options = defaultOptions, validOptions = NULL),
    "(argument).*(validOptions).*(is of type).*(NULL).*(but expected).*(list)"
  )
})

test_that("validateIsOption() errors when option values exceed expected length", {
  testOptions <- modifyList(defaultOptions, list(includeInteractions = c(TRUE, FALSE)))
  expect_error(
    validateIsOption(testOptions, validOptions),
    "(includeInteractions).*(Object).*(should be of length).*(1).*(but is of length).*(2)"
  )
})

test_that("validateIsOption() type mismatches trigger errors", {
  invalidOptions <- modifyList(defaultOptions, list(maxIterations = Inf))
  expect_warning(
    expect_error(
      validateIsOption(invalidOptions, validOptions),
      "(maxIterations).*(argument).*(x).*(is of type).*(numeric).*(but expected).*(integer)"
    )
  )
  invalidOptions <- modifyList(defaultOptions, list(includeInteractions = "notValid"))
  expect_error(
    validateIsOption(invalidOptions, validOptions),
    "(includeInteractions).*(argument).*(x).*(is of type).*(character).*(but expected).*(logical)"
  )
  invalidOptions <- modifyList(defaultOptions, list(convergenceThreshold = "low"))
  expect_error(
    validateIsOption(invalidOptions, validOptions),
    "(argument).*(x).*(is of type).*(character).*(but expected).*(numeric)"
  )
})

test_that("validateIsOption() errors when NA values are present and not allowed", {
  testOptions <- modifyList(defaultOptions, list(maxIterations = NA_integer_))
  expect_error(
    validateIsOption(testOptions, validOptions),
    "(maxIterations).*(NA).*(values are not allowed)"
  )
})

test_that("validateIsOption() flags out-of-range and invalid values", {
  invalidOptions <- modifyList(defaultOptions, list(maxIterations = 1e6L))
  expect_error(
    validateIsOption(invalidOptions, validOptions),
    "(maxIterations).*(Value\\(s\\) out of the allowed range)"
  )
  invalidOptions <- modifyList(defaultOptions, list(convergenceThreshold = 2))
  expect_error(
    validateIsOption(invalidOptions, validOptions),
    "(convergenceThreshold).*(Value\\(s\\) out of the allowed range)"
  )
  invalidOptions <- modifyList(defaultOptions, list(optimizationMethod = "none"))
  expect_error(
    validateIsOption(invalidOptions, validOptions),
    "(optimizationMethod).*(1 value).*(none).*(not included in allowed values)"
  )
})

test_that("validateIsOption() correctly handles NULL values per configuration", {
  invalidOptions <- modifyList(defaultOptions, list(maxIterations = NULL), keep.null = TRUE)
  expect_error(
    validateIsOption(invalidOptions, validOptions),
    "(maxIterations).*(argument).*(x).*(is of type).*(NULL).*(but expected).*(vector)"
  )
  invalidOptions <- modifyList(defaultOptions, list(convergenceThreshold = NULL))
  expect_null(
    validateIsOption(invalidOptions, validOptions)
  )
})


# validateColumns ---------------------------------------------------------

df <- data.frame(
  age = c(32L, NA, 19L, 26L, 47L),
  bmi = c(22.4, NA, 19.5, 27.8, 32.4),
  gender = c("M", "F", "F", "M", "M"),
  bp = factor(c("high", "normal", "low", "normal", "high"),
    levels = c("low", "normal", "high")
  ),
  smoker = c(TRUE, NA, FALSE, FALSE, FALSE)
)

columnSpecs <- list(
  age = list(type = "integer", valueRange = c(0L, 120L), naAllowed = TRUE),
  bmi = list(type = "numeric", valueRange = c(10, 50), naAllowed = TRUE),
  gender = list(type = "character", allowedValues = c("M", "F")),
  bp = list(type = "factor", allowedValues = factor(c("low", "normal", "high"))),
  smoker = list(type = "logical", naAllowed = TRUE)
)

test_that("validateColumns() accepts valid default options", {
  expect_null(
    validateColumns(df, columnSpecs)
  )
})

test_that("validateColumns() accepts valid data frame columns when not each column is defined in columnSpecs", {
  testDf <- df
  testDf$numCores <- 2L
  expect_null(
    validateColumns(testDf, columnSpecs)
  )
})

test_that("validateColumns() throws an error when 'object' argument is not a data frame", {
  expect_error(
    validateColumns(object = "a", columnSpecs = columnSpecs),
    "(argument).*(object).*(is of type).*(character).*(but expected).*(data\\.frame)"
  )
  expect_error(
    validateColumns(object = NULL, columnSpecs = columnSpecs),
    "(argument).*(object).*(is of type).*(NULL).*(but expected).*(data\\.frame)"
  )
})

test_that("validateColumns() throws an error when 'columnSpecs' argument is not a list", {
  expect_error(
    validateColumns(object = df, columnSpecs = 1.2),
    "(argument).*(columnSpecs).*(is of type).*(numeric).*(but expected).*(list)"
  )
  expect_error(
    validateColumns(object = df, columnSpecs = NULL),
    "(argument).*(columnSpecs).*(is of type).*(NULL).*(but expected).*(list)"
  )
})

test_that("validateColumns() identifies columns with wrong type", {
  testDf <- df
  testDf$age <- 23.2
  expect_error(
    validateColumns(testDf, columnSpecs),
    "(age).*(argument).*(x).*(is of type).*(numeric).*(but expected).*(integer)"
  )
  testDf <- df
  testDf$smoker <- "heavy"
  expect_error(
    validateColumns(testDf, columnSpecs),
    "(smoker).*(argument).*(x).*(is of type).*(character).*(but expected).*(logical)"
  )
  testDf <- df
  testDf$bmi <- 22L
  expect_error(
    validateColumns(testDf, columnSpecs),
    "(bmi).*(argument).*(x).*(is of type).*(integer).*(but expected).*(numeric)"
  )
  testDf <- df
  testDf$bp <- "invalid"
  expect_error(
    validateColumns(testDf, columnSpecs),
    "(bp).*(argument).*(x).*(is of type).*(character).*(but expected).*(factor)"
  )
})

test_that("validateColumns() identifies columns outside allowed range or outside allowed values", {
  testDf <- df
  testDf$age <- 200L
  expect_error(
    validateColumns(testDf, columnSpecs),
    "(age).*(Value\\(s\\) out of the allowed range)"
  )
  testDf <- df
  testDf$bmi <- 50.1
  expect_error(
    validateColumns(testDf, columnSpecs),
    "(bmi).*(Value\\(s\\) out of the allowed range)"
  )
  testDf <- df
  testDf$gender <- "Other"
  expect_error(
    validateColumns(testDf, columnSpecs),
    "(gender).*(not included in allowed values).*(M, F)"
  )
  testDf <- df
  testDf$bp <- as.factor("very high")
  expect_error(
    validateColumns(testDf, columnSpecs),
    "(bp).*(not included in allowed values).*(low, normal, high)"
  )
})

test_that("validateColumns() handles NULL values in columns correctly according to columnSpecs", {
  testDf <- df
  testDf$age <- NULL
  expect_error(
    validateColumns(testDf, columnSpecs),
    "(age).*(argument).*(x).*(is of type).*(NULL).*(but expected).*(vector)"
  )

  testDf <- df
  testDf$convergenceThreshold <- rep(NULL, nrow(testDf))
  expect_null(
    validateColumns(testDf, columnSpecs)
  )
})

test_that("validateColumns() handles NA values in 'age' and 'smoker' columns according to updated columnSpecs", {
  testColumnSpecs <- columnSpecs
  testColumnSpecs$age$naAllowed <- FALSE
  expect_error(
    validateColumns(df, testColumnSpecs),
    "(age).*(NA).*(values are not allowed)"
  )
  testColumnSpecs <- columnSpecs
  testColumnSpecs$smoker$naAllowed <- FALSE
  expect_error(
    validateColumns(df, testColumnSpecs),
    "(smoker).*(NA).*(values are not allowed)"
  )
})
