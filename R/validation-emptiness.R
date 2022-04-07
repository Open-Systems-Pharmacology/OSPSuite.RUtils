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

#' Check that the object is not empty
#'
#' @inheritParams isEmpty
#'
#' @return
#'
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
