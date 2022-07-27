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
`%||%` <- purrr::`%||%`

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

#' Convert special constants to `NA` of desired type
#'
#' @details
#'
#' Special constants (`NULL`, `Inf`, `-Inf`, `NaN`,  `NA`) will be converted to
#' `NA` of desired type.
#'
#' @param x A single element.
#' @inheritParams flattenList
#'
#' @examples
#'
#' toMissingOfType(NA, type = "real")
#' toMissingOfType(NULL, type = "integer")
#'
#' @export
toMissingOfType <- function(x, type) {
  # all unexpected values will be converted to `NA` of a desired type
  if (is.null(x) || is.na(x) || is.nan(x) || is.infinite(x)) {
    x <- switch(type,
      "character" = NA_character_,
      "numeric" = ,
      "real" = ,
      "double" = NA_real_,
      "integer" = NA_integer_,
      "complex" = NA_complex_,
      "logical" = NA,
      stop("Incorrect type entered.")
    )
  }

  return(x)
}

#' Flatten a list to an atomic vector of desired type
#'
#' @param x A list or an atomic vector. If the latter, no change will be made.
#' @param type Type of atomic vector to be returned.
#'
#' @details
#'
#' The `type` argument will decide which variant from `purrr::flatten()` family
#' is used to flatten the list.
#'
#' @examples
#'
#' flattenList(list(1, 2, 3, NA), type = "numeric")
#' flattenList(list(TRUE, FALSE, NA), type = "integer")
#'
#' @return An atomic vector of desired type.
#'
#' @export
flattenList <- function(x, type) {
  if (!is.null(dim(x))) {
    stop(messages$errorOnlyVectorAllowed())
  }

  if (is.list(x)) {
    x <- switch(type,
      "character" = purrr::flatten_chr(x),
      "numeric" = ,
      "real" = ,
      "double" = purrr::flatten_dbl(x),
      "integer" = purrr::flatten_int(x),
      "logical" = purrr::flatten_lgl(x),
      purrr::flatten(x)
    )
  }

  return(x)
}
