#' @keywords internal
.inheritType <- function(x, type, nullAllowed = FALSE) {
  if (is.null(x) && nullAllowed) {
    return(TRUE)
  }

  inherits(x, type)
}

#' @keywords internal
.isBaseType <- function(x) {
  baseTypes <- c("character", "logical", "integer", "double")

  if (typeof(x) %in% baseTypes) {
    return(TRUE)
  }

  return(FALSE)
}

#' @keywords internal
.typeNamesFrom <- function(type) {
  type <- c(type)
  sapply(type, function(t) ifelse(is.character(t), t, t$classname))
}

#' @keywords internal
.fileExtension <- function(file) {
  # if file has no extension, return empty string
  if (!grepl("\\.", basename(file)) || grepl("\\.$", basename(file))) {
    return("")
  }

  ex <- strsplit(basename(file), split = "\\.")[[1]]

  return(utils::tail(ex, 1))
}
