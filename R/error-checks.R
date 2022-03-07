#' Check if the provided object is of certain type
#'
#' @param object An object or an atomic vector or a list of objects.
#' @param type A single string or a vector of string representation or class of
#'   the type that should be checked for.
#' @param nullAllowed Boolean flag if `NULL` is accepted for the `object`. If
#'   `TRUE`, `NULL` always returns `TRUE`, otherwise `NULL` returns `FALSE`.
#'   Default is `FALSE`.
#'
#' @return
#' `TRUE` if the object or all objects inside the list are of the given
#'   type.
#'
#' @note
#' Only the first level of the given list is considered.
#'
#' @examples
#' # checking type of a single object
#' df <- data.frame(x = c(1, 2, 3))
#' isOfType(df, "data.frame")
#' @export
isOfType <- function(object, type, nullAllowed = FALSE) {
  if (!is.logical(nullAllowed)) {
    stop(
      messages$errorWrongType("nullAllowed", typeof(nullAllowed), "logical"),
      call. = FALSE
    )
  }

  if (is.null(object)) {
    return(nullAllowed)
  }

  type <- .typeNamesFrom(type)

  if (.inheritType(object, type, nullAllowed)) {
    return(TRUE)
  }

  object <- c(object)

  all(sapply(object, .inheritType, type, nullAllowed))
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

  hasObject <- any(mapply(function(x) !.isBaseType(x), values))

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
#' @return
#' `TRUE` if the object or all objects inside the list have `nbElements.`
#'
#' @note
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
#' @param file A name of the file or full path.
#' @param extension A required extension of the file.
#'
#' @return `TRUE` if the file name (or full path) includes the extension.
#'
#' @examples
#' isFileExtension("enum.R", "R") # TRUE
#' isFileExtension("enum.R", "pkml") # FALSE
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
#' # empty list or data.frame
#' isEmpty(NULL)
#' isEmpty(numeric())
#' isEmpty(list())
#' isEmpty(data.frame())
#'
#' # accounts for filtering of arrays and data.frame
#' df <- data.frame(x = c(1, 2, 3), y = c(4, 5, 6))
#' isEmpty(df)
#' isEmpty(df$x[FALSE])
#' isEmpty(df[FALSE, ])
#' @export
isEmpty <- function(object) {
  if (is.data.frame(object)) {
    return(nrow(object) == 0)
  }
  return(isOfLength(object, 0))
}

#' Check if a string or any of the vector of strings is empty
#'
#' @param x A string or a vector of strings.
#'
#' @details If any `NA`s are present, they will be considered as empty strings.
#'
#' @return `TRUE` if any of strings are empty.
#'
#' @examples
#'
#' hasEmptyString(c("x", "y")) # FALSE
#' hasEmptyString(list("x", "y")) # FALSE
#' hasEmptyString("   abc   ") # FALSE
#' hasEmptyString(c("", "y")) # TRUE
#' hasEmptyString(list("", "y")) # TRUE
#' hasEmptyString(NA) # TRUE
#' hasEmptyString(character(0)) # TRUE
#' hasEmptyString(c(NA, "x", "y")) # TRUE
#'
#' @export
hasEmptyString <- function(x) {
  length(x) == 0L || any(is.na(x)) || any(nchar(x) == 0L)
}

#' Check that an array of values does not include any duplicate
#'
#' @param values An array of values
#' @param na.rm Logical to decide if missing values should be removed from the
#'   duplicate checking. Note that duplicate `NA` values are flagged if
#'   `na.rm=FALSE`.
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

# utilities -------------------------------------

#' @keywords internal
.inheritType <- function(x, type, nullAllowed = FALSE) {
  if (is.null(x) && nullAllowed) {
    return(TRUE)
  }

  inherits(x, type)
}

#' @keywords internal
.isBaseType <- function(x) {
  baseTypes <- c("character", "logical", "integer", "double")

  if (typeof(x) %in% baseTypes) {
    return(TRUE)
  }

  return(FALSE)
}

#' @keywords internal
.typeNamesFrom <- function(type) {
  type <- c(type)
  sapply(type, function(t) ifelse(is.character(t), t, t$classname))
}

#' @keywords internal
.fileExtension <- function(file) {
  # if file has no extension, return empty string
  if (!grepl("\\.", basename(file)) || grepl("\\.$", basename(file))) {
    return("")
  }

  ex <- strsplit(basename(file), split = "\\.")[[1]]
  return(utils::tail(ex, 1))
}
