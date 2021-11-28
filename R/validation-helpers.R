# validation helpers ---------------------------------------------

#' Check if the provided object is of certain type. If not, stop with an error.
#'
#' @return `NULL` if the entered object is of expected type, otherwise produces
#'   error. Also accepts `NULL` as an input if `nullAllowed` argument is set to
#'   `TRUE`.
#'
#' @inheritParams isOfType
#'
#' @examples
#' A <- data.frame(
#'   col1 = c(1, 2, 3),
#'   col2 = c(4, 5, 6),
#'   col3 = c(7, 8, 9)
#' )
#' validateIsSameLength(A, A)
#' validateIsIncluded("col3", names(A))
#' validateIsInteger(5)
#' validateIsNumeric(1.2)
#' validateIsString("x")
#' validateIsLogical(TRUE)
#' @export
validateIsOfType <- function(object, type, nullAllowed = FALSE) {
  type <- c(type)

  # special case for integer to ensure that we call the special method
  if (length(type) == 1 && type[1] == "integer") {
    return(validateIsInteger(object, nullAllowed = nullAllowed))
  }

  if (isOfType(object, type, nullAllowed)) {
    return()
  }

  # Name of the variable in the calling function
  objectName <- deparse(substitute(object))
  objectTypes <- typeNamesFrom(type)

  # There might be no call stack available if called from terminal
  callStack <- as.character(sys.call(-1)[[1]])
  # Object name is one frame further for functions such as ValidateIsNumeric
  if ((length(callStack) > 0) && grepl(pattern = "validateIs", x = callStack)) {
    objectName <- deparse(substitute(object, sys.frame(-1)))
  }

  stop(messages$errorWrongType(objectName, class(object)[1], objectTypes))
}

#' @rdname validateIsOfType
#' @inheritParams isOfType
#' @export

validateIsString <- function(object, nullAllowed = FALSE) {
  validateIsOfType(object, "character", nullAllowed)
}

#' @rdname validateIsOfType
#' @inheritParams isOfType
#' @export

validateIsNumeric <- function(object, nullAllowed = FALSE) {
  # Only NA values. It is numeric
  if (all(is.na(object)) && !any(is.null(object))) {
    return()
  }

  validateIsOfType(object, c("numeric", "integer"), nullAllowed)
}

#' @rdname validateIsOfType
#' @inheritParams isOfType
#'
#' @export

validateIsInteger <- function(object, nullAllowed = FALSE) {
  if (nullAllowed && is.null(object)) {
    return()
  }

  # Making sure we check for numeric values before calling floor
  if (inherits(object, "numeric") && all(floor(object) == object, na.rm = TRUE)) {
    return()
  }

  # Name of the variable in the calling function
  objectName <- deparse(substitute(object))
  objectTypes <- "integer"

  stop(messages$errorWrongType(objectName, class(object)[1], objectTypes))
}

#' @rdname validateIsOfType
#' @inheritParams isOfType
#' @export

validateIsLogical <- function(object, nullAllowed = FALSE) {
  validateIsOfType(object, "logical", nullAllowed)
}


#' @rdname validateIsOfType
#' @param  ... Name of the variable in the calling function
#' @export

validateIsSameLength <- function(...) {
  if (isSameLength(...)) {
    return()
  }
  # Name of the variable in the calling function
  objectName <- deparse(substitute(list(...)))

  # Name of the arguments
  argnames <- sys.call()
  arguments <- paste(lapply(argnames[-1], as.character), collapse = ", ")

  stop(messages$errorDifferentLength(arguments))
}

#' @rdname validateIsOfType
#' @inheritParams isOfLength
#' @export
validateIsOfLength <- function(object, nbElements) {
  if (isOfLength(object, nbElements)) {
    return()
  }
  stop(messages$errorWrongLength(object, nbElements))
}

#' @rdname validateIsOfType
#' @param path A valid file path name.
#' @export

validatePathIsAbsolute <- function(path) {
  wildcardChar <- "*"
  if (any(unlist(strsplit(path, ""), use.names = FALSE) == wildcardChar)) {
    stop(messages$errorEntityPathNotAbsolute(path))
  }
}

#' @rdname validateIsOfType
#' @inheritParams isIncluded
#'
#' @export
validateIsIncluded <- function(values, parentValues, nullAllowed = FALSE) {
  if (nullAllowed && is.null(values)) {
    return()
  }

  if (isIncluded(values, parentValues)) {
    return()
  }

  stop(messages$errorNotIncluded(values, parentValues))
}

#' Check if `value` is in the given `enum`. If not, stops with an error.
#'
#' @param enum `enum` where the `value` should be contained
#' @param value `value` to search for in the `enum`
#' @param nullAllowed If TRUE, `value` can be `NULL` and the test always passes.
#' If `FALSE` (default), NULL is not accepted and the test fails.
#'
#' @examples
#' Symbol <- enum(c(Diamond = 1, Triangle = 2, Circle = 2))
#' validateEnumValue(1, Symbol)
#' @export
validateEnumValue <- function(value, enum, nullAllowed = FALSE) {
  if (is.null(value)) {
    if (nullAllowed) {
      return()
    }
    stop(messages$errorEnumValueUndefined(value))
  }

  enumKey <- getEnumKey(enum, value)
  if (any(names(enum) == enumKey)) {
    return()
  }

  stop(messages$errorValueNotInEnum(enum, value))
}
