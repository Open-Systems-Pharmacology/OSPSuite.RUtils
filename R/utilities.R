#' Transforms a single .NET object  or a list of .NET Object to their
#' corresponding wrapper class in R. Note that if the object is a single object,
#' NULL will be returned if the .NET object is null. This allows semantic
#' equivalence between .NET and R
#'
#' @param netObject The .NET object instances (single or list) to wrap
#' @param class The class definition that will be used to convert the parameter
#'
#' @return The wrapped object (single or list)
#' @export
toObjectType <- function(netObject, class) {
  if (!is.list(netObject)) {
    return(ifNotNull(netObject, class$new(ref = netObject)))
  }
  sapply(c(netObject), function(x) {
    class$new(ref = x)
  })
}


#' Default value for `NULL`
#'
#'  Convenience function to avoid testing for `NULL`.
#'
#' @return
#' The first object if it is not `NULL` otherwise the second object.
#'
#' @param x,y If `x` is `NULL`, will return `y`; otherwise returns `x`.
#' @export
#' @name op-null-default
#' @examples
#' 1 %||% 2
#' NULL %||% 2
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
#' @return `outputIfNotNull` if condition is not `NULL`, outputIfNull otherwise.
#'
#' @description
#' Check if condition is not `NULL`, if so output outputIfNotNull,
#' otherwise, output outputIfNull
#'
#' @examples
#' ifNotNull(NULL, "x")
#' ifNotNull(NULL, "x", "y")
#' ifNotNull(1 < 2, "x", "y")
#' @export
ifNotNull <- function(condition, outputIfNotNull, outputIfNull = NULL) {
  if (!is.null(condition)) {
    outputIfNotNull
  } else {
    outputIfNull
  }
}

#' Make sure the object is a list
#'
#' @param object To be converted to a list
#'
#' @return If `is.list(object) == TRUE`, returns the `object`, otherwise.
#'   `list(object)`.
#'
#' @examples
#' toList(list("a" = 1, "b" = 2))
#' toList(c("a" = 1, "b" = 2))
#' @export
toList <- function(object) {
  if (is.list(object)) {
    return(object)
  }
  return(list(object))
}
