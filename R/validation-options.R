#' Validate Common Spec Parameters
#'
#' @keywords internal
#' @noRd
.validateSpecParams <- function(nullAllowed, naAllowed, expectedLength) {
  validateIsLogical(nullAllowed)
  validateIsLogical(naAllowed)
  if (!is.null(expectedLength)) {
    validateIsInteger(expectedLength)
    if (expectedLength < 1) {
      stop(messages$errorExpectedLengthPositive(), call. = FALSE)
    }
  }
}

#' Validate Min/Max Range Parameters
#'
#' @keywords internal
#' @noRd
.validateMinMax <- function(min, max, type) {
  # Validate min parameter
  if (!is.null(min)) {
    if (anyNA(min)) {
      stop(messages$errorWrongType("min", "NA", type), call. = FALSE)
    }
    if (type == "integer") {
      validateIsInteger(min)
    } else if (type == "numeric") {
      validateIsNumeric(min)
    }
  }

  # Validate max parameter
  if (!is.null(max)) {
    if (anyNA(max)) {
      stop(messages$errorWrongType("max", "NA", type), call. = FALSE)
    }
    if (type == "integer") {
      validateIsInteger(max)
    } else if (type == "numeric") {
      validateIsNumeric(max)
    }
  }

  # Compare min and max only if both are non-NULL
  if (!is.null(min) && !is.null(max) && min > max) {
    stop(messages$errorMinMaxInvalid(min, max), call. = FALSE)
  }
}

#' Create Integer Option Specification
#'
#' @param min Minimum allowed value (inclusive). Defaults to `NULL` (no minimum).
#' @param max Maximum allowed value (inclusive). Defaults to `NULL` (no maximum).
#' @param nullAllowed Logical flag indicating whether `NULL` is permitted. Defaults to `FALSE`.
#' @param naAllowed Logical flag indicating whether `NA` values are permitted. Defaults to `FALSE`.
#' @param expectedLength Expected length of the option value. Use `NULL` for any length,
#'   `1` for scalar (default), or a positive integer for specific length.
#'
#' @return An S3 object of class `optionSpec_integer` and `optionSpec`.
#'
#' @export
integerOption <- function(min = NULL, max = NULL,
                         nullAllowed = FALSE, naAllowed = FALSE,
                         expectedLength = 1) {
  .validateSpecParams(nullAllowed, naAllowed, expectedLength)
  .validateMinMax(min, max, "integer")

  spec <- list(
    type = "integer",
    valueRange = if (!is.null(min) || !is.null(max)) c(min, max) else NULL,
    nullAllowed = nullAllowed,
    naAllowed = naAllowed,
    expectedLength = expectedLength
  )

  class(spec) <- c("optionSpec_integer", "optionSpec")
  spec
}

#' Create Numeric Option Specification
#'
#' @inheritParams integerOption
#'
#' @return An S3 object of class `optionSpec_numeric` and `optionSpec`.
#'
#' @export
numericOption <- function(min = NULL, max = NULL,
                         nullAllowed = FALSE, naAllowed = FALSE,
                         expectedLength = 1) {
  .validateSpecParams(nullAllowed, naAllowed, expectedLength)
  .validateMinMax(min, max, "numeric")

  spec <- list(
    type = "numeric",
    valueRange = if (!is.null(min) || !is.null(max)) c(min, max) else NULL,
    nullAllowed = nullAllowed,
    naAllowed = naAllowed,
    expectedLength = expectedLength
  )

  class(spec) <- c("optionSpec_numeric", "optionSpec")
  spec
}

#' Create Character Option Specification
#'
#' @param allowedValues Vector of permitted values. Defaults to `NULL` (any value allowed).
#' @inheritParams integerOption
#'
#' @return An S3 object of class `optionSpec_character` and `optionSpec`.
#'
#' @export
characterOption <- function(allowedValues = NULL,
                           nullAllowed = FALSE, naAllowed = FALSE,
                           expectedLength = 1) {
  .validateSpecParams(nullAllowed, naAllowed, expectedLength)

  if (!is.null(allowedValues)) {
    validateIsCharacter(allowedValues)
    if (length(allowedValues) == 0) {
      stop(messages$errorAllowedValuesEmpty())
    }
    if (anyNA(allowedValues)) {
      stop(messages$errorAllowedValuesEmpty(
        "allowedValues cannot contain NA. Use naAllowed = TRUE instead."
      ))
    }
  }

  spec <- list(
    type = "character",
    allowedValues = allowedValues,
    nullAllowed = nullAllowed,
    naAllowed = naAllowed,
    expectedLength = expectedLength
  )

  class(spec) <- c("optionSpec_character", "optionSpec")
  spec
}

#' Create Logical Option Specification
#'
#' @inheritParams integerOption
#'
#' @return An S3 object of class `optionSpec_logical` and `optionSpec`.
#'
#' @export
logicalOption <- function(nullAllowed = FALSE, naAllowed = FALSE,
                         expectedLength = 1) {
  .validateSpecParams(nullAllowed, naAllowed, expectedLength)

  spec <- list(
    type = "logical",
    nullAllowed = nullAllowed,
    naAllowed = naAllowed,
    expectedLength = expectedLength
  )

  class(spec) <- c("optionSpec_logical", "optionSpec")
  spec
}


#' Validate Options Against Specified Valid Options
#'
#' This function checks if the given options adhere to specified valid options.
#' It validates each option's type, value range, allowed values, and handles `NULL` and
#' `NA` values according to the configuration provided in `validOptions`. It
#' automatically converts numeric options to integers when possible and specified
#' so by `validOptions` for validation and issues a warning.
#'
#'
#' @param options A list of options to validate.
#' @param validOptions A list specifying the valid configurations for each option in `options`.
#' Each entry in `validOptions` should be a list containing the `type`, `allowedValues`,
#' `valueRange`, `nullAllowed`, and `naAllowed` parameters for the option it corresponds to.
#'
#' @details
#' The function iterates through each option in `validOptions`, retrieves the corresponding
#' value from `options`, and validates it using `validateVector`.
#' The validation covers:
#' - Type correctness according to `type`, with automatic conversion for numeric to
#' integer where appropriate.
#' - Whether the value is within the specified `valueRange` (if applicable).
#' - Whether the value is among the `allowedValues` (if specified).
#' - Handling of `NULL` and `NA` based on `nullAllowed` and `naAllowed` flags.
#'
#' @return
#' Does not return a value explicitly. Completes without error if all options are
#' valid according to `validOptions`. If any validation fails, it stops and generates
#' a descriptive error message, reporting all failures if multiple validations fail.
#'
#' @examples
#' options <- list(
#'   optimizationMethod = "genetic_algorithm",
#'   includeInteractions = TRUE,
#'   maxIterations = 1000L,
#'   convergenceThreshold = 0.02
#' )
#'
#' validOptions <- list(
#'   optimizationMethod = list(
#'     type = "character", allowedValues = c("gradient_descent", "genetic_algorithm")
#'   ),
#'   includeInteractions = list(type = "logical"),
#'   maxIterations = list(type = "integer", valueRange = c(1L, 10000L)),
#'   convergenceThreshold = list(type = "numeric", valueRange = c(0, 1))
#' )
#'
#' validateIsOption(options, validOptions)
#'
#' @export
validateIsOption <- function(options, validOptions) {
  if (!is.list(options)) {
    stop(messages$errorWrongType("options", class(options)[1], "list"))
  }
  if (!is.list(validOptions)) {
    stop(messages$errorWrongType("validOptions", class(validOptions)[1], "list"))
  }

  results <- list()
  for (optionName in names(validOptions)) {
    optionConfig <- validOptions[[optionName]]
    optionValue <- options[[optionName]]

    if (isOfType(optionValue, "numeric") && optionConfig$type == "integer") {
      if (isTRUE(all.equal(optionValue, as.integer(optionValue)))) {
        warning(messages$errorWrongType(
          "optionValue", class(optionValue)[1], optionConfig$type,
          " \n Numeric value automatically converted to integer for validation."
        ))
        optionValue <- as.integer(optionValue)
      }
    }

    if (!is.null(optionValue) && length(optionValue) != 1) {
      results[[optionName]] <- paste(
        optionName, "error: ",
        messages$errorWrongLength(optionValue, 1)
      )
      next
    }

    results[[optionName]] <- tryCatch(
      {
        validateVector(
          x = optionValue,
          type = optionConfig$type,
          allowedValues = optionConfig$allowedValues,
          valueRange = if (!is.null(optionConfig$valueRange)) optionConfig$valueRange else NULL,
          nullAllowed = optionConfig$nullAllowed %||% FALSE,
          naAllowed = optionConfig$naAllowed %||% FALSE
        )
      },
      error = function(e) {
        paste(optionName, "error:", e$message)
      }
    )
  }

  passed <- sapply(results, isTRUE)
  if (!all(passed)) {
    errorMessages <- sapply(names(results)[!passed], function(x) results[[x]])
    stop(paste(unlist(errorMessages), collapse = "\n"))
  }

  return()
}

#' Validate Data Frame Columns Against Specified Validations
#'
#' This function checks if the columns of a given data frame adhere to specified
#' validations defined in `columnSpecs`. It validates each column's type, value range,
#' allowed values, and handles `NULL` and `NA` values based on the configurations
#' provided in `columnSpecs`.
#'
#' @param object #' @param object A data frame, tibble, or data.table whose columns
#' are to be validated.

#' @param columnSpecs A list specifying the valid configurations for each column in `object`.
#'   Each entry in `columnSpecs` should be a list containing the `type`, `allowedValues`,
#'   `valueRange`, `nullAllowed`, and `naAllowed` parameters for the column it corresponds to.
#'
#' @details
#' The function iterates through each column name in `columnSpecs`, retrieves the corresponding
#' column from `object`, and validates it using `validateVector`. The validation includes:
#' - Type correctness according to `type`.
#' - Whether the column values are within the specified `valueRange` (if applicable).
#' - Whether the column values are among the `allowedValues` (if specified).
#' - Handling of `NULL` and `NA` based on `nullAllowed` and `naAllowed` flags.
#'
#' @return
#' The function does not explicitly return a value. It completes without error if all columns
#' are valid according to `columnSpecs`. If any validation fails, it generates a descriptive
#' error message, reporting all failures if multiple validations fail.
#'
#' @examples
#' df <- data.frame(
#'   age = c(25L, 30L, NA),
#'   BMI = c(22.5, 27.3, 24.9),
#'   gender = c("M", "F", "F"),
#'   smoker = c(TRUE, FALSE, NA)
#' )
#'
#' columnSpecs <- list(
#'   age = list(type = "integer", valueRange = c(18L, 65L), naAllowed = TRUE),
#'   BMI = list(type = "numeric", valueRange = c(15.0, 40.0), naAllowed = TRUE),
#'   gender = list(type = "character", allowedValues = c("M", "F"), naAllowed = TRUE),
#'   smoker = list(type = "logical", naAllowed = TRUE)
#' )
#'
#' validateColumns(df, columnSpecs)
#'
#' @export
validateColumns <- function(object, columnSpecs) {
  if (!is.data.frame(object)) {
    stop(messages$errorWrongType("object", class(object)[1], "data.frame"))
  }
  if (!is.list(columnSpecs)) {
    stop(messages$errorWrongType("columnSpecs", class(columnSpecs)[1], "list"))
  }

  columnsList <- as.list(object)

  results <- list()
  for (columnName in names(columnSpecs)) {
    columnConfig <- columnSpecs[[columnName]]
    columnValue <- columnsList[[columnName]]

    results[[columnName]] <- tryCatch(
      {
        validateVector(
          x = columnValue,
          type = columnConfig$type,
          allowedValues = columnConfig$allowedValues,
          valueRange = if (!is.null(columnConfig$valueRange)) columnConfig$valueRange else NULL,
          nullAllowed = columnConfig$nullAllowed %||% FALSE,
          naAllowed = columnConfig$naAllowed %||% FALSE
        )
      },
      error = function(e) {
        paste(columnName, "error:", e$message)
      }
    )
  }

  passed <- sapply(results, isTRUE)
  if (!all(passed)) {
    errorMessages <- sapply(names(results)[!passed], function(x) results[[x]])
    stop(paste(unlist(errorMessages), collapse = "\n"))
  }

  return()
}
