#' @name op-null-default
#' @title Default value for `NULL`
#'
#' @description
#' Convenience function to avoid testing for `NULL`.
#'
#' @return
#' The first object if it is not `NULL` otherwise the second object.
#'
#' @param x,y If `x` is `NULL`, will return `y`; otherwise returns `x`.
#'
#' @examples
#' 1 %||% 2
#' NULL %||% 2
#'
#' @export
`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}

#' Shortkey checking if argument 1 is not `NULL`, output the argument 2 if not
#' null, or output argument 3 otherwise
#'
#' @param condition argument 1
#' @param outputIfNotNull argument 2
#' @param outputIfNull argument 3
#'
#' @return
#' `outputIfNotNull` if condition is not `NULL`, `outputIfNull` otherwise.
#'
#' @description
#' Check if condition is not `NULL`, if so output `outputIfNotNull`,
#' otherwise, output `outputIfNull`.
#'
#' @examples
#' ifNotNull(NULL, "x")
#' ifNotNull(NULL, "x", "y")
#' ifNotNull(1 < 2, "x", "y")
#'
#' @export
ifNotNull <- function(condition, outputIfNotNull, outputIfNull = NULL) {
  if (!is.null(condition)) {
    return(outputIfNotNull)
  }

  return(outputIfNull)
}

#' Make sure the object is a list
#'
#' @param object Object to be converted to a list.
#'
#' @return
#' If `is.list(object) == TRUE`, returns the `object`; otherwise, `list(object)`.
#'
#' @examples
#' toList(list("a" = 1, "b" = 2))
#' toList(c("a" = 1, "b" = 2))
#'
#' @export
toList <- function(object) {
  if (is.list(object)) {
    return(object)
  }

  return(list(object))
}
