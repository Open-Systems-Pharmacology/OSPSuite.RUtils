# is or has helpers ---------------------------------------------

#' Check if the provided object is of certain type
#'
#' @param object An object or an atomic vector or a list of objects.
#' @param type A single string or a vector of string representation or class of
#'   the type that should be checked for.
#' @param nullAllowed Boolean flag if `NULL` is accepted for the `object`. If
#'   `TRUE`, `NULL` always returns `TRUE`, otherwise `NULL` returns `FALSE`.
#'   Default is `FALSE`.
#'
#' @return `TRUE` if the object or all objects inside the list are of the given
#'   type. Only the first level of the given list is considered.
#'
#' @examples
#' # checking type of a single object
#' df <- data.frame(x = c(1, 2, 3))
#' isOfType(df, "data.frame")
#' @export

isOfType <- function(object, type, nullAllowed = FALSE) {
  if (is.null(object)) {
    return(nullAllowed)
  }

  type <- .typeNamesFrom(type)

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
#' @examples
#' A <- data.frame(
#'   col1 = c(1, 2, 3),
#'   col2 = c(4, 5, 6),
#'   col3 = c(7, 8, 9)
#' )
#' isIncluded("col3", names(A))
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
#'
#' @examples
#' isSameLength(mtcars, ToothGrowth)
#' isSameLength(mtcars, mtcars)
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
#'
#' @examples
#' df <- data.frame(x = c(1, 2, 3))
#' isOfLength(df, 1)
#' isOfLength(df, 3)
#' @export

isOfLength <- function(object, nbElements) {
  return(length(object) == nbElements)
}

#' Check if the provided path has required extension
#'
#' @param file file or path name to be checked
#' @param extension extension of the file required after "."
#'
#' @return `TRUE` if the path includes the extension.
#'
#' @examples
#' # TRUE
#' isFileExtension("enum.R", "R")
#'
#' # FALSE
#' isFileExtension("enum.R", "pkml")
#' @export

isFileExtension <- function(file, extension) {
  extension <- c(extension)
  file_ext <- .fileExtension(file)
  file_ext %in% extension
}

#' Check that an array of values does not include any duplicate
#'
#' @param values An array of values
#' @param na.rm Logical to decide if missing values should be removed from the duplicate checking.
#' Note that duplicate `NA` values are flagged if `na.rm=FALSE`.
#'
#' @return Logical assessing if all values are unique
#'
#' @examples
#' hasUniqueValues(c("x", "y"))
#' hasUniqueValues(c("x", "y", "x"))
#' hasUniqueValues(c("x", NA, "y", NA), na.rm = FALSE)
#' hasUniqueValues(c("x", NA, "y", NA), na.rm = TRUE)
#' @export

hasUniqueValues <- function(values, na.rm = TRUE) {
  if (na.rm) {
    values <- values[!is.na(values)]
  }

  return(!any(duplicated(values)))
}


# utilities ---------------------------------------------

#' @keywords internal

.typeNamesFrom <- function(type) {
  type <- c(type)

  sapply(type, function(t) {
    if (is.character(t)) {
      return(t)
    }

    return(t$classname)
  })
}

#' @keywords internal

.fileExtension <- function(file) {
  ex <- strsplit(basename(file), split = "\\.")[[1]]
  return(utils::tail(ex, 1))
}
