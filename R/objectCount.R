#' Count number of objects
#'
#' @details
#'
#' If the argument is not a vector, unlike `length()`, this function will not
#' count the number of named bindings in an environment, but only the number of
#' instances of a class.
#'
#' For example, `length(mtcars)` will return 11, but `objectCount(mtcars)` will
#' return 1.
#'
#' @param x An object (an atomic vector, a list, or instance(s) of a class).
#'
#' @examples
#'
#' objectCount(c(1, 2, 3)) # 3
#' objectCount(list("a", "b")) # 2
#' objectCount(mtcars) # 1
#' objectCount(list(iris, mtcars)) # 2
#'
#' @return Integer representing the count of objects.
#'
#' @export
objectCount <- function(x) {
  # *WARNING*: Do not use `is.vector()` to check for a vector.
  # It returns `FALSE` if `x` is a vector but has attributes other than names.
  #
  # For anything other than a vector, the object count should be 1.
  if (!is.null(dim(x)) || R6::is.R6(x) || is.environment(x)) {
    return(1L)
  }

  return(length(x))
}
