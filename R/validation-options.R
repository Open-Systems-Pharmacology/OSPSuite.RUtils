#' Validate Options Against Specified Valid Options
#'
#' This function checks if the given options adhere to specified valid options.
#' It validates each option's type, value range, allowed values, and handles `NULL` and
#' `NA` values according to the configuration provided in `validOptions`.
#'
#' @param options A list of options to validate.
#' @param validOptions A list that specifies valid configurations for each option in `options`.
#' Each entry in `validOptions` should be a list containing the `type`, `allowedValues`,
#' `valueRange`, `nullAllowed`, and `naAllowed` parameters for the option it corresponds to.
#'
#' @details
#' The function iterates through each option in `validOptions`, retrieves the corresponding
#' value from `options`, and validates it using `validateVector`.
#' The validation covers:
#' - Type correctness according to `type`.
#' - Whether the value is within the specified `valueRange` (if applicable).
#' - Whether the value is among the `allowedValues` (if specified).
#' - Handling of `NULL` and `NA` based on `nullAllowed` and `naAllowed` flags.
#'
#' @return
#' The function does not explicitly return a value. If all options are valid according
#' to `validOptions`, the function completes without error. If any validation fails,
#' a descriptive error message is generated, compiling and reporting all failures if
#' multiple validations fail.
#'
#' @examples
#' options <- list(
#'   optimizationMethod = "genetic_algorithm",
#'   includeInteractions = TRUE,
#'   maxIterations = 1000
#' )
#'
#' validOptions <- list(
#'   optimizationMethod = list(type = "character", allowedValues = c("gradient_descent", "genetic_algorithm")),
#'   includeInteractions = list(type = "logical"),
#'   maxIterations = list(type = "integer", valueRange = c(1, 10000))
#' )
#'
#' isValidOption(options, validOptions)
#'
#' @export
validateIsOption <- function(options, validOptions) {
  if (length(options) == 0) {
    return()
  }
  validateIsOfType(options, "list")
  validateIsOfType(validOptions, "list")

  results <- list()
  for (optionName in names(validOptions)) {
    optionConfig <- validOptions[[optionName]]
    optionValue <- options[[optionName]]

    if (!is.null(optionValue) && length(optionValue) != 1) {
      results[[optionName]] <- paste(
        optionName, "error: ",
        messages$errorWrongLength(1, length(optionValue))
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
