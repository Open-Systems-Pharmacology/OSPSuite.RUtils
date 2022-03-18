#' Check if the provided path has required extension
#'
#' @param file A name of the file or full path.
#' @param extension A required extension of the file.
#'
#' @return `TRUE` if the file name (or full path) includes the extension.
#'
#' @examples
#' isFileExtension("enum.R", "R") # TRUE
#' isFileExtension("enum.R", "pkml") # FALSE
#'
#' @export
isFileExtension <- function(file, extension) {
  extension <- c(extension)
  file_ext <- .fileExtension(file)
  file_ext %in% extension
}
