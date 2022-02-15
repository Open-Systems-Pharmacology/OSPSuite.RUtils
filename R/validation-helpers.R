# type validation helpers ---------------------------------------------

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
#'
#' validateIsOfType(A, "data.frame")
#' validateIsInteger(5)
#' validateIsNumeric(1.2)
#' validateIsCharacter("x")
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
  objectTypes <- .typeNamesFrom(type)

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

validateIsCharacter <- function(object, nullAllowed = FALSE) {
  validateIsOfType(object, "character", nullAllowed)
}

#' @rdname validateIsOfType
#' @export

validateIsString <- validateIsCharacter

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

  if (is.list(object)) {
    object <- unlist(object)
  }

  # if it's an actual integer (e.g. 5L)
  if (is.integer(object)) {
    return()
  }

  # making sure we check for numeric values before calling floor
  # e.g. `5` is numeric but can be considered integer for our purposes
  if (is.numeric(object) && all(floor(object) == object, na.rm = TRUE)) {
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

# Path validation helpers ---------------------------------------------

#' Check if path is absolute
#'
#' @description
#'
#' Relative paths will be detected based on the presence of wildcard
#' character(*) in the path specification.
#'
#' @return
#'
#' Error in case a relative path is found, otherwise no output will be returned.
#'
#' @param path A valid file path name.
#'
#' @examples
#' # no error if path is absolute
#' validatePathIsAbsolute("Organism|path")
#'
#' # error otherwise
#' # validatePathIsAbsolute("Organism|*path")
#' @export

validatePathIsAbsolute <- function(path) {
  wildcardChar <- "*"
  path <- unlist(strsplit(path, ""), use.names = FALSE)

  if (!any(path == wildcardChar)) {
    return()
  }

  stop(messages$errorEntityPathNotAbsolute(path))
}

# Inclusion validation helpers ---------------------------------------------

#' Check if values are included
#'
#' @inheritParams isIncluded
#' @inheritParams validateEnumValue
#'
#' @examples
#'
#' A <- data.frame(
#'   col1 = c(1, 2, 3),
#'   col2 = c(4, 5, 6),
#'   col3 = c(7, 8, 9)
#' )
#'
#' # will return NULL if child value is included in parent value set
#' validateIsIncluded("col3", names(A))
#'
#' @return
#'
#' Returns `NULL` if child value is included in parent value set, otherwise
#' error is signaled.
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

# Enum validation helpers ---------------------------------------------

#' Check if `value` is in the given `enum`. If not, stops with an error.
#'
#' @param enum `enum` where the `value` should be contained.
#' @param value A value to search for in the `enum`.
#' @param nullAllowed If `TRUE`, `value` can be `NULL` and the test always
#'   passes. If `FALSE` (default), `NULL` is not accepted and the test fails.
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

  enumKey <- enumGetKey(enum, value)

  if (any(names(enum) == enumKey)) {
    return()
  }

  stop(messages$errorValueNotInEnum(enum, value))
}

# Length validation helpers ---------------------------------------------

#' Check if objects have expected length
#'
#' @rdname validateIsOfLength
#' @inheritParams isOfLength
#'
#' @return
#' If validations are successful, `NULL` is returned. Otherwise, error is
#' signaled.
#'
#' @examples
#' # returns `NULL` if of objects are of specified length
#' validateIsOfLength(list(1, 2), 2L)
#'
#' # error otherwise
#' # validateIsOfLength(c("3", "4"), 3L)
#' @export

validateIsOfLength <- function(object, nbElements) {
  if (isOfLength(object, nbElements)) {
    return()
  }

  stop(messages$errorWrongLength(object, nbElements))
}


#' Check if all objects are of same length
#'
#' @inheritParams isSameLength
#'
#' @inherit validateIsOfLength return return
#'
#' @examples
#' # returns `NULL` if of objects are of same length
#' validateIsSameLength(list(1, 2), c("3", "4"))
#'
#' # error otherwise
#' # validateIsSameLength(list(1, 2), c("3", "4"), c(FALSE))
#' @export

validateIsSameLength <- function(...) {
  if (isSameLength(...)) {
    return()
  }

  # Name of the arguments
  argnames <- sys.call()
  arguments <- paste(lapply(argnames[-1], as.character), collapse = ", ")

  stop(messages$errorDifferentLength(arguments))
}

#' Check if objects is not empty
#'
#' @inheritParams isOfLength
#'
#' @return
#' If validations are successful, `NULL` is returned. Otherwise, error is
#' signaled.
#'
#' @examples
#' # returns `NULL` if of objects are of specified length
#' validateIsNotEmpty(list(1, 2))
#'
#' # error otherwise
#' # validateIsNotEmpty(NULL)
#' @export

validateIsNotEmpty <- function(object) {
  if (!isEmpty(object)) {
    return()
  }

  objectName <- deparse(substitute(object))

  stop(messages$errorEmpty(objectName))
}

# Dimension validation helpers ---------------------------------------------

#' Check if quantity can be represented in the unit
#'
#' @param quantity `Quantity` object
#' @param unit Unit name to check for
#'
#' @return
#' If validations are successful, `NULL` is returned. Otherwise, error is
#' signaled.
#' @export
validateHasUnit <- function(quantity, unit) {
  validateIsOfType(quantity, Quantity)
  validateIsString(unit)
  if (quantity$hasUnit(unit)) {
    return()
  }
  stop(messages$errorUnitNotDefined(quantity$name, quantity$dimension, unit))
}
