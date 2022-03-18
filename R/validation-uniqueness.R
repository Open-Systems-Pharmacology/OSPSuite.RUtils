#' Check that an array of values does not include any duplicate
#'
#' @param values An array of values
#' @param na.rm Logical to decide if missing values should be removed from the
#'   duplicate checking. Note that duplicate `NA` values are flagged if
#'   `na.rm=FALSE`.
#'
#' @return Logical assessing if all values are unique.
#'
#' @examples
#' hasOnlyDistinctValues(c("x", "y"))
#' hasOnlyDistinctValues(c("x", "y", "x"))
#' hasOnlyDistinctValues(c("x", NA, "y", NA), na.rm = FALSE)
#' hasOnlyDistinctValues(c("x", NA, "y", NA), na.rm = TRUE)
#'
#' @export
hasOnlyDistinctValues <- function(values, na.rm = TRUE) {
  if (na.rm) {
    values <- values[!is.na(values)]
  }

  return(!any(duplicated(values)))
}
