#' Transforms a single .NET object  or a list of .NET Object to their corresponding wrapper class in R.
#' Note that if the object is a single object, NULL will be returned if the .NET object is null. This allows semantic equivalence between .NET and R
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
#'  Convenience function to avoid testing for null. It returns the first object
#'  if it is not null otherwise the second object
#'
#' @param x,y If `x` is NULL, will return `y`; otherwise returns `x`.
#' @export
#' @name op-null-default
#' @examples
#' 1 %||% 2
#' NULL %||% 2
`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}


#' Shortkey checking if argument 1 is not null,
#' output the argument 2 if not null, or output argument 3 otherwise
#'
#' @title ifnotnull
#' @param condition argument 1
#' @param outputIfNotNull argument 2
#' @param outputIfNull argument 3
#' @return outputIfNotNull if condition is not null, outputIfNull otherwise
#' @description
#' Check if condition is not null, if so output outputIfNotNull,
#' otherwise, output outputIfNull
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
#' @return If `is.list(object) == TRUE`, returns the `object`, otherwise `list(object)`
#' @export
toList <- function(object) {
  if (is.list(object)) {
    return(object)
  }
  return(list(object))
}
