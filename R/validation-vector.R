#' Validate Vector Against Specified Criteria
#'
#' Validates a vector `x` based on specified criteria, including type correctness, value range,
#' allowed values, and handling of `NULL` and `NA` values.
#'
#' @param x Vector to validate.
#' @param type Expected type of elements in `x` ("numeric", "integer", "character",
#'   "factor", "logical", or "Date"). Type "double" is treated as "numeric".
#' @param valueRange Optional vector of length 2 specifying the range of allowed values
#' for `x`, applicable to "numeric", "integer", "character", and "Date" types.
#' @param allowedValues Optional vector specifying a set of allowed values for `x`.
#' @param nullAllowed Logical flag indicating whether `x` can be `NULL`. Defaults to `FALSE`.
#' @param naAllowed Logical flag indicating whether elements in `x` can be `NA`. Defaults to `FALSE`.
#'
#' @details
#' `validateVector` is the primary function for checking a vector against defined validation criteria.
#' It ensures that `x` meets the type, range, and allowed value conditions specified. For more detailed
#' validations related to the value range and allowed values, `validateVectorRange` and
#' `validateVectorValues` functions are utilized respectively.
#'
#' @return
#'
#' @examples
#' validateVector(x = 1:5, type = "integer")
#' validateVector(x = c(1.2, 2.5), type = "numeric", valueRange = c(1, 3))
#' validateVector(x = c("a", "b"), type = "character", allowedValues = c("a", "b", "c"))
#' validateVector(x = as.Date("2020-01-01"), type = "Date", valueRange = as.Date(c("2020-01-01", "2020-12-31")))
#'
#' # Range validation
#' validateVectorRange(c(5, 10), "numeric", c(1, 10)) # NULL
#' validateVectorRange(c("a", "b"), "character", c("a", "c")) # NULL
#' validateVectorRange(as.Date(c("2020-01-01")), "Date", as.Date(c("2020-01-01", "2020-12-31"))) # NULL
#' validateVectorRange(1:3, "integer", c(1L, 5L)) # NULL
#'
#' # Allowed values validation
#' validateVectorValues(c("a", "b"), "character", c("a", "b", "c")) # NULL
#' validateVectorValues(c("a", "b"), "character", c("a", "b", "c")) # NULL
#' validateVectorValues(c(2L, 4L), "integer", c(1L, 2L, 3L, 4L)) # NULL
#' validateVectorValues(c(TRUE), "logical", c(TRUE, FALSE)) # NULL
#'
#' @export
validateVector <- function(x, type = NULL, valueRange = NULL, allowedValues = NULL,
                           nullAllowed = FALSE, naAllowed = FALSE) {
  if (!is.logical(nullAllowed)) {
    stop("errorWrongType")
  }
  if (!is.logical(naAllowed)) {
    stop("errorWrongType")
  }

  if (is.null(type)) {
    stop("errorMissingType")
  }
  if (is.null(x)) {
    if (!nullAllowed) {
      stop("errorWrongType")
    }
    return()
  }

  if (!naAllowed && any(is.na(x))) {
    stop("errorNaNotAllowed")
  }

  validTypes <- c("numeric", "integer", "character", "factor", "logical", "Date")
  type <- if (type == "double") "numeric" else type
  if (!type %in% validTypes) {
    stop("errorTypeNotSupported")
  }

  if (!isOfType(x, type, nullAllowed = FALSE)) {
    stop("errorWrongType")
  }

  validateVectorRange(x, type, valueRange)
  validateVectorValues(x, type, allowedValues, naAllowed)

  return()
}

#' @rdname validateVector
#' @export
validateVectorRange <- function(x, type, valueRange) {
  if (is.null(valueRange)) {
    return()
  }
  validRangeTypes <- c("numeric", "integer", "character", "Date")
  if (type %in% validRangeTypes) {
    if (!isOfType(valueRange, type)) {
      stop("errorWrongType")
    }
    if (length(valueRange) != 2 || valueRange[1] > valueRange[2] ||
        any(is.na(valueRange))) {
      stop("errorValueRange")
    }
    if (any(x < valueRange[1] | x > valueRange[2], na.rm = TRUE)) {
      stop("errorOutOfRange")
    }
  } else {
    stop("errorValueRangeType")
  }

  return()
}

#' @rdname validateVector
#' @export
validateVectorValues <- function(x, type, allowedValues = NULL, naAllowed = FALSE) {
  if (is.null(allowedValues)) {
    return()
  }
  if (!naAllowed) {
    allowedValues <- allowedValues[!is.na(allowedValues)]
  } else {
    allowedValues <- unique(c(allowedValues, NA))
  }

  if (!isOfType(allowedValues, type)) {
    stop("errorWrongType")
  }

  if (!all(x %in% allowedValues)) {
    stop("errorValueNotAllowed")
  }

  return()
}
