#' Validate if the vector depth is as expected
#'
#' @param x A vector whose depth needs to be checked.
#' @param expectedDepth An integer representing desired vector depth.
#'
#' @description
#'
#' Function parameters that accept a vector argument, the vector with depth
#' greater than 2, which corresponds to a nested list, is rarely desirable.
#'
#' The `hasVectorDepth()` checks if the vector is of desirable depth, while
#' `validateVectorDepth()` validates the same.
#'
#' @details
#'
#' Vector depths can be understood as follows:
#'
#' - `1` = atomic vector (or empty list)
#' - `2` = non-nested list
#' - `> 2` = nested list
#'
#' @return
#'
#' `hasVectorDepth()` returns a logical from comparison of actual versus
#' expected depth.
#'
#' `validateVectorDepth()` produces error if the validation is unsuccessful;
#' otherwise, it returns `NULL`.
#'
#' @examples
#'
#' hasVectorDepth(c(1), 1L) # TRUE
#' hasVectorDepth(list(), 1L) # TRUE
#' hasVectorDepth(list(1), 1L) # FALSE
#'
#' validateVectorDepth(c(1), 1L) # NULL
#' validateVectorDepth(list(), 1L) # NULL
#' validateVectorDepth(list(1), 2L) # NULL
#'
#' # this will produce an error
#' # validateVectorDepth(list(list(1))) # depth is 3
#'
#' @export
hasVectorDepth <- function(x, expectedDepth = 2L) {
  return(purrr::vec_depth(x) == expectedDepth)
}

#' @rdname hasVectorDepth
#' @export
validateVectorDepth <- function(x, expectedDepth = 2L) {
  actualDepth <- purrr::vec_depth(x)
  objectName <- deparse(substitute(x))

  if (actualDepth != expectedDepth) {
    stop(messages$errorWrongVectorDepth(actualDepth, expectedDepth, objectName))
  }

  return()
}
