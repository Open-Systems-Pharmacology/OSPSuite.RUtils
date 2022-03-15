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
