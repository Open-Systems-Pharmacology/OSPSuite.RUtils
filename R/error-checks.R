# is or has helpers ---------------------------------------------

#' Check if the provided object is of certain type
#'
#' @param object An object or a list of objects.
#' @param type String representation or Class of the type that should be checked
#'   for.
#' @param nullAllowed Boolean flag if `NULL` is accepted for the `object`. If
#'   `TRUE`, `NULL` always returns `TRUE`, otherwise `NULL` returns `FALSE`.
#'   Default is `FALSE`.
#'
#' @return TRUE if the object or all objects inside the list are of the given
#'   type. Only the first level of the given list is considered.
#' @export
isOfType <- function(object, type, nullAllowed = FALSE) {
  if (is.null(object)) {
    return(nullAllowed)
  }

  type <- typeNamesFrom(type)
  inheritType <- function(x) {
    if (is.null(x) && nullAllowed) {
      return(TRUE)
    }
    inherits(x, type)
  }
  if (inheritType(object)) {
    return(TRUE)
  }

  object <- c(object)
  all(sapply(object, inheritType))
}

#' Check if input is included in a list
#'
#' @param values Vector of values
#' @param parentValues Vector of values
#'
#' @return `TRUE` if the values are inside the parent values.
#' @export
isIncluded <- function(values, parentValues) {
  if (is.null(values)) {
    return(FALSE)
  }
  if (length(values) == 0) {
    return(FALSE)
  }
  return(as.logical(min(values %in% parentValues)))
}

#' Check if two objects are of same length
#' @param ... Objects to compare.
#' @export
isSameLength <- function(...) {
  args <- list(...)
  nrOfLengths <- length(unique(lengths(args)))

  return(nrOfLengths == 1)
}

#' Check if the provided object has `nbElements` elements
#'
#' @param object An object or a list of objects
#' @param nbElements number of elements that are supposed in object
#'
#' @return `TRUE` if the object or all objects inside the list have `nbElements.`
#' Only the first level of the given list is considered.
#' @export
isOfLength <- function(object, nbElements) {
  return(length(object) == nbElements)
}

#' Check if the provided path has required extension
#'
#' @param file file or path name to be checked
#' @param extension extension of the file required after "."
#'
#' @return TRUE if the path includes the extension
#' @export

isFileExtension <- function(file, extension) {
  extension <- c(extension)
  file_ext <- fileExtension(file)
  file_ext %in% extension
}

#' Remove duplicate values from data
#' @param data A dataframe.
#' @param na.rm Logical to decide if missing values should be removed.
#' @export

hasUniqueValues <- function(data, na.rm = TRUE) {
  # na.rm is the usual tidyverse input to remove NA values
  if (na.rm) {
    data <- data[!is.na(data)]
  }
  return(!any(duplicated(data)))
}


# validation helpers ---------------------------------------------

#' Check if the provided object is of certain type. If not, stop with an error.
#'
#' @inheritParams isOfType
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

#' Check if `value` is in the given {enum}. If not, stops with an error.
#'
#' @param enum `enum` where the `value` should be contained
#' @param value `value` to search for in the `enum`
#' @param nullAllowed If TRUE, `value` can be `NULL` and the test always passes.
#' If `FALSE` (default), NULL is not accepted and the test fails.
#' @export
validateEnumValue <- function(value, enum, nullAllowed = FALSE) {
  if (is.null(value)) {
    if (nullAllowed) {
      return()
    }
    stop(messages$errorEnumValueUndefined(enum))
  }

  enumKey <- getEnumKey(enum, value)
  if (any(names(enum) == enumKey)) {
    return()
  }

  stop(messages$errorValueNotInEnum(enum, enumKey))
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


# utilities ---------------------------------------------

typeNamesFrom <- function(type) {
  type <- c(type)
  sapply(type, function(t) {
    if (is.character(t)) {
      return(t)
    }
    t$classname
  })
}

fileExtension <- function(file) {
  ex <- strsplit(basename(file), split = "\\.")[[1]]
  return(utils::tail(ex, 1))
}
