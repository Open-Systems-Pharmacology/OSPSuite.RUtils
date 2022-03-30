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
