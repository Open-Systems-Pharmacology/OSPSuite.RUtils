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
