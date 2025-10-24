# Helper functions --------------------------------------------------------

test_that(".validateSpecParams() validates nullAllowed", {
  expect_error(
    .validateSpecParams("yes", FALSE, 1),
    regexp = messages$errorWrongType("nullAllowed", typeof("yes"), "logical"),
    fixed = TRUE
  )
  expect_silent(.validateSpecParams(TRUE, FALSE, 1))
})

test_that(".validateSpecParams() validates naAllowed", {
  expect_error(
    .validateSpecParams(FALSE, "no", 1),
    regexp = messages$errorWrongType("naAllowed", typeof("no"), "logical"),
    fixed = TRUE
  )
  expect_silent(.validateSpecParams(FALSE, TRUE, 1))
})

test_that(".validateSpecParams() validates expectedLength", {
  expect_error(
    .validateSpecParams(FALSE, FALSE, 0),
    regexp = messages$errorExpectedLengthPositive(),
    fixed = TRUE
  )
  expect_error(
    .validateSpecParams(FALSE, FALSE, 1.5),
    regexp = messages$errorWrongType("expectedLength", class(1.5)[1], "integer"),
    fixed = TRUE
  )
  expect_silent(.validateSpecParams(FALSE, FALSE, 1))
  expect_silent(.validateSpecParams(FALSE, FALSE, NULL))
})

test_that(".validateMinMax() handles NULL/NULL edge case", {
  expect_silent(.validateMinMax(NULL, NULL, "integer"))
  expect_silent(.validateMinMax(NULL, NULL, "numeric"))
})

test_that(".validateMinMax() rejects NA values", {
  expect_error(
    .validateMinMax(NA, NULL, "integer"),
    regexp = messages$errorWrongType("min", "NA", "integer"),
    fixed = TRUE
  )
  expect_error(
    .validateMinMax(NULL, NA, "integer"),
    regexp = messages$errorWrongType("max", "NA", "integer"),
    fixed = TRUE
  )
  expect_error(
    .validateMinMax(NA_integer_, NULL, "integer"),
    regexp = messages$errorWrongType("min", "NA", "integer"),
    fixed = TRUE
  )
  expect_error(
    .validateMinMax(NA_real_, NULL, "numeric"),
    regexp = messages$errorWrongType("min", "NA", "numeric"),
    fixed = TRUE
  )
  expect_error(
    .validateMinMax(NA, NA, "integer"),
    regexp = messages$errorWrongType("min", "NA", "integer"),
    fixed = TRUE
  )
})

test_that(".validateMinMax() validates min greater max", {
  expect_error(
    .validateMinMax(10L, 1L, "integer"),
    regexp = messages$errorMinMaxInvalid(10L, 1L),
    fixed = TRUE
  )
  expect_error(
    .validateMinMax(10.5, 1.5, "numeric"),
    regexp = messages$errorMinMaxInvalid(10.5, 1.5),
    fixed = TRUE
  )
  expect_silent(.validateMinMax(1L, 10L, "integer"))
  expect_silent(.validateMinMax(1L, 1L, "integer"))
})


# Spec constructors -------------------------------------------------------

test_that("integerOption() creates valid spec", {
  spec <- integerOption(min = 1L, max = 10L)
  expect_s3_class(spec, "optionSpec_integer")
  expect_s3_class(spec, "optionSpec")
  expect_equal(spec$type, "integer")
  expect_equal(spec$valueRange, c(1L, 10L))
  expect_equal(spec$nullAllowed, FALSE)
  expect_equal(spec$naAllowed, FALSE)
  expect_equal(spec$expectedLength, 1)
})

test_that("integerOption() validates inputs", {
  expect_error(
    integerOption(nullAllowed = "yes"),
    regexp = messages$errorWrongType("nullAllowed", typeof("yes"), "logical"),
    fixed = TRUE
  )
  expect_error(
    integerOption(expectedLength = 0),
    regexp = messages$errorExpectedLengthPositive(),
    fixed = TRUE
  )
  expect_error(
    integerOption(expectedLength = 1.5),
    regexp = messages$errorWrongType("expectedLength", class(1.5)[1], "integer"),
    fixed = TRUE
  )
  expect_error(
    integerOption(min = 10L, max = 1L),
    regexp = messages$errorMinMaxInvalid(10L, 1L),
    fixed = TRUE
  )
})

test_that("numericOption() creates valid spec", {
  spec <- numericOption(min = 0, max = 1)
  expect_s3_class(spec, "optionSpec_numeric")
  expect_s3_class(spec, "optionSpec")
  expect_equal(spec$type, "numeric")
  expect_equal(spec$valueRange, c(0, 1))
})

test_that("characterOption() creates valid spec", {
  spec <- characterOption(allowedValues = c("a", "b"))
  expect_s3_class(spec, "optionSpec_character")
  expect_s3_class(spec, "optionSpec")
  expect_equal(spec$type, "character")
  expect_equal(spec$allowedValues, c("a", "b"))
})

test_that("characterOption() validates allowedValues", {
  expect_error(
    characterOption(allowedValues = 123),
    regexp = messages$errorWrongType("allowedValues", class(123)[1], "character"),
    fixed = TRUE
  )
  expect_error(
    characterOption(allowedValues = character(0)),
    regexp = messages$errorAllowedValuesEmpty(),
    fixed = TRUE
  )
})

test_that("characterOption() rejects NA in allowedValues", {
  expect_error(
    characterOption(allowedValues = c("a", "b", NA)),
    "allowedValues cannot contain NA"
  )
  expect_error(
    characterOption(allowedValues = c("a", "b", NA)),
    "naAllowed = TRUE"
  )
  expect_error(
    characterOption(allowedValues = c(NA_character_)),
    "NA"
  )
})

test_that("characterOption() correct usage with NA", {
  spec <- characterOption(allowedValues = c("a", "b"), naAllowed = TRUE)
  expect_equal(spec$allowedValues, c("a", "b"))
  expect_true(spec$naAllowed)

  spec2 <- characterOption(allowedValues = NULL, naAllowed = TRUE)
  expect_null(spec2$allowedValues)
  expect_true(spec2$naAllowed)
})

test_that("logicalOption() creates valid spec", {
  spec <- logicalOption()
  expect_s3_class(spec, "optionSpec_logical")
  expect_s3_class(spec, "optionSpec")
  expect_equal(spec$type, "logical")
  expect_equal(spec$nullAllowed, FALSE)
})


# Spec normalization ------------------------------------------------------

test_that(".normalizeSpec() passes through new optionSpec objects unchanged", {
  newSpec <- integerOption(min = 1L, max = 10L)
  normalized <- .normalizeSpec(newSpec)
  expect_identical(newSpec, normalized)
})

test_that(".normalizeSpec() converts old integer list format correctly", {
  oldSpec <- list(type = "integer", valueRange = c(1L, 10L))
  newSpec <- .normalizeSpec(oldSpec, "testOption")
  expect_s3_class(newSpec, "optionSpec_integer")
  expect_s3_class(newSpec, "optionSpec")
  expect_equal(newSpec$valueRange, c(1L, 10L))
  expect_equal(newSpec$expectedLength, 1)
})

test_that(".normalizeSpec() converts old numeric list format correctly", {
  oldSpec <- list(type = "numeric", valueRange = c(0, 1))
  newSpec <- .normalizeSpec(oldSpec)
  expect_s3_class(newSpec, "optionSpec_numeric")
  expect_equal(newSpec$valueRange, c(0, 1))
})

test_that(".normalizeSpec() converts old character list format correctly", {
  oldSpec <- list(type = "character", allowedValues = c("a", "b"))
  newSpec <- .normalizeSpec(oldSpec)
  expect_s3_class(newSpec, "optionSpec_character")
  expect_equal(newSpec$allowedValues, c("a", "b"))
})

test_that(".normalizeSpec() converts old logical list format correctly", {
  oldSpec <- list(type = "logical", nullAllowed = TRUE)
  newSpec <- .normalizeSpec(oldSpec)
  expect_s3_class(newSpec, "optionSpec_logical")
  expect_true(newSpec$nullAllowed)
})

test_that(".normalizeSpec() handles missing optional fields with defaults", {
  oldSpec <- list(type = "integer")
  newSpec <- .normalizeSpec(oldSpec)
  expect_equal(newSpec$nullAllowed, FALSE)
  expect_equal(newSpec$naAllowed, FALSE)
  expect_equal(newSpec$expectedLength, 1)
})

test_that(".normalizeSpec() errors when spec is not a list", {
  expect_error(
    .normalizeSpec("invalid", "testOption"),
    regexp = messages$errorSpecNotList("testOption"),
    fixed = TRUE
  )
  expect_error(
    .normalizeSpec(123),
    regexp = messages$errorSpecNotList(),
    fixed = TRUE
  )
})

test_that(".normalizeSpec() errors when type field is missing", {
  oldSpec <- list(valueRange = c(1L, 10L))
  expect_error(
    .normalizeSpec(oldSpec, "testOption"),
    regexp = messages$errorSpecMissingType("testOption"),
    fixed = TRUE
  )
})

test_that(".normalizeSpec() errors on invalid type", {
  oldSpec <- list(type = "invalid")
  expect_error(
    .normalizeSpec(oldSpec, "testOption"),
    regexp = messages$errorInvalidSpecType("invalid", "testOption"),
    fixed = TRUE
  )
})


# S3 validation methods ---------------------------------------------------

test_that(".validateValue.optionSpec() checks expectedLength", {
  spec <- integerOption(min = 1L, max = 10L, expectedLength = 1)
  expect_error(
    .validateValue(c(1L, 2L), spec, "test"),
    regexp = messages$errorWrongLength(c(1L, 2L), 1, "test"),
    fixed = TRUE
  )
  expect_silent(.validateValue(5L, spec, "test"))
})

test_that(".validateValue.optionSpec() validates with NULL expectedLength", {
  spec <- integerOption(min = 1L, max = 10L, expectedLength = NULL)
  expect_silent(.validateValue(c(1L, 2L, 3L), spec, "test"))
  expect_silent(.validateValue(5L, spec, "test"))
})

test_that(".validateValue.optionSpec_integer() auto-converts numeric with warning", {
  spec <- integerOption(min = 1L, max = 10L)

  # Should warn and convert
  expect_warning(
    .validateValue(5.0, spec, "myOption"),
    regexp = messages$warningNumericToIntegerConversion("myOption"),
    fixed = TRUE
  )

  # Should not warn for actual integer
  expect_silent(.validateValue(5L, spec, "myOption"))
})

test_that(".validateValue.optionSpec_integer() rejects non-convertible numeric", {
  spec <- integerOption(min = 1L, max = 10L)

  # Should fail if numeric doesn't convert cleanly (5.5 can't be integer)
  expect_error(
    .validateValue(5.5, spec, "test"),
    regexp = messages$errorWrongType("x", class(5.5)[1], "integer"),
    fixed = TRUE
  )
})


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