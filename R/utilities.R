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


#' Convert special constants to `NA` of desired type
#'
#' @details
#'
#' Special constants (`NULL`, `Inf`, `-Inf`, `NaN`,  `NA`) will be converted to
#' `NA` of desired type.
#'
#' This function is **not** vectorized, and therefore only scalar values should
#' be entered.
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

# TODO:
#
# Depending on what is decided in issue
# https://github.com/Open-Systems-Pharmacology/OSPSuite-R/issues/1091, change
# defaults for `base` for `.log_safe`.
#' Computes logarithm of a number or of a vector of numbers and handles zeros while
#' substituting all values below `epsilon` by `epsilon`.
#'
#' @param x A numeric or a vector of numerics.
#' @param base a positive or complex number: the base with respect to which logarithms are computed. Defaults to e = exp(1).
#' @param epsilon A very small number which is considered as threshold below which
#' all values are treated as `epsilon`. Allows computation of `log` close to 0.
#' Default value is `getOSPSuiteUtilsSetting("LOG_SAFE_EPSILON")`.
#'
#' @return `log(x, base = base)` for `x > epsilon`, or `log(epsilon, base = base)`,
#' or `NA_real_` for `NA` elements.
#' @export
#'
#' @examples
#' inputVector <- c(NA, 1, 5, 0, -1)
#' log_safe(inputVector)
log_safe <- function(x, base = exp(1), epsilon = ospsuiteUtilsEnv$LOG_SAFE_EPSILON) {
  x <- sapply(X = x, function(element) {
    element <- ospsuite.utils::toMissingOfType(element, type = "double")
    if (is.na(element)) {
      return(NA_real_)
    } else if (element < epsilon) {
      return(log(epsilon, base = base))
    } else {
      return(log(element, base = base))
    }
  })

  return(x)
}
