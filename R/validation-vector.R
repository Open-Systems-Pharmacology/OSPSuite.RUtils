#' @rdname validateVector
#' @export
validateVectorRange <- function(x, type, valueRange) {
  if (is.null(valueRange)) {
    return()
  }
  validRangeTypes <- c("numeric", "integer", "character", "Date")
  if (type %in% validRangeTypes) {
    if (!isOfType(valueRange, type)) {
      stop("errorWrongType")
    }
    if (length(valueRange) != 2 || valueRange[1] > valueRange[2] ||
        any(is.na(valueRange))) {
      stop("errorValueRange")
    }
    if (any(x < valueRange[1] | x > valueRange[2], na.rm = TRUE)) {
      stop("errorOutOfRange")
    }
  } else {
    stop("errorValueRangeType")
  }

  return()
}
