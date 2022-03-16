#' Count number of objects
#'
#' @details
#'
#' If the argument is not a vector, unlike `length()`, this function will not
#' count the number of named bindings in an environment, but only the number of
#' instances of a class.
#'
#' For example, `length(mtcars)` will return 11, but `objCount(mtcars)` will
#' return 1.
#'
#' @param x An object (an atomic vector, a list, or instance(s) of a class).
#'
#' @examples
#'
#' objCount(c(1, 2, 3)) # 3
#' objCount(list("a", "b")) # 2
#' objCount(mtcars) # 1
#'
#' @return Integer representing the count of objects.
#'
#' @export
objCount <- function(x) {
  # `is.vector()` can handle both atomic vectors and lists, i.e.
  # both `is.vector(c(1, 2))` and `is.vector(list(1, 2))` will be `TRUE`.
  #
  # For anything other than a vector, the object count should be 1.
  if (!is.vector(x)) {
    return(1L)
  }

  return(length(x))
}
