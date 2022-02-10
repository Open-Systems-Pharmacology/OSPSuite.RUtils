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

#' Check if a vector of values is included in another vector of values
#'
#' @param values A vector of values.
#' @param parentValues A vector of values where `values` are checked for
#'   inclusion.
#'
#' @return
#'
#' Returns `TRUE` if the value or **all** `values` (if it's a vector) are
#' present in the `parentValues`; `FALSE` otherwise.
#'
#' @examples
#' # check if a column is present in dataframe
#' A <- data.frame(
#'   col1 = c(1, 2, 3),
#'   col2 = c(4, 5, 6),
#'   col3 = c(7, 8, 9)
#' )
#' isIncluded("col3", names(A)) # TRUE
#'
#' # check if single element is present in a vector (atomic or non-atomic)
#' isIncluded("x", list("w", "x", 1, 2)) # TRUE
#' isIncluded("x", c("w", "a", "y")) # FALSE
#'
#' # check if **all** values (if it's a vector) are contained in parent values
#' isIncluded(c("x", "y"), c("a", "y", "b", "x")) # TRUE
#' isIncluded(list("x", 1), list("a", "b", "x", 1)) # TRUE
#' isIncluded(c("x", "y"), c("a", "b", "x")) # FALSE
#' isIncluded(list("x", 1), list("a", "b", "x")) # FALSE
#' @export
isIncluded <- function(values, parentValues) {
  values <- c(values)

  hasObject <- any(mapply(function(x) {
    is.object(x) | is.environment(x)
  }, values))

  if (hasObject) {
    stop("Only vectors of base object types are allowed.", call. = FALSE)
  }

  if (is.null(values) || length(values) == 0) {
    return(FALSE)
  }

  as.logical(min(values %in% parentValues))
}

#' Check if objects are of same length
#' @param ... Objects to compare.
#'
#' @examples
#' # compare length of only 2 objects
#' isSameLength(mtcars, ToothGrowth) # FALSE
#' isSameLength(cars, BOD) # TRUE
#'
#' # or more number of objects
#' isSameLength(c(1, 2), c(TRUE, FALSE), c("x", "y")) # TRUE
#' isSameLength(list(1, 2), list(TRUE, FALSE), list("x")) # FALSE
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

#' Check if the provided object is empty
#'
#' @param object An object or an atomic vector or a list of objects.
#'
#' @return `TRUE` if the object is empty.
#'
#' @examples
#' # Empty list or data.frame
#' isEmpty(NULL)
#' isEmpty(numeric())
#' isEmpty(list())
#' isEmpty(data.frame())
#' 
#' # Accounts for filtering of arrays and data.frame
#' df <- data.frame(x = c(1, 2, 3), y = c(4, 5, 6))
#' isEmpty(df)
#' isEmpty(df$x[FALSE])
#' isEmpty(df[FALSE,])
#' 
#' @export

isEmpty <- function(object) {
  if(class(object)[1] %in% "data.frame") {
    return(nrow(object)==0)
  }
  return(isOfLength(object, 0))
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
#' hasOnlyDistinctValues(c("x", "y"))
#' hasOnlyDistinctValues(c("x", "y", "x"))
#' hasOnlyDistinctValues(c("x", NA, "y", NA), na.rm = FALSE)
#' hasOnlyDistinctValues(c("x", NA, "y", NA), na.rm = TRUE)
#' @export

hasOnlyDistinctValues <- function(values, na.rm = TRUE) {
  if (na.rm) {
    values <- values[!is.na(values)]
  }

  return(!any(duplicated(values)))
}

#' @rdname hasOnlyDistinctValues
#' @export

hasUniqueValues <- hasOnlyDistinctValues

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
