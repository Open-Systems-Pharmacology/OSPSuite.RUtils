#' Check if path is absolute
#'
#' @description
#'
#' Relative paths will be detected based on the presence of wildcard
#' character(*) in the path specification.
#'
#' @return
#'
#' Error in case a relative path is found, otherwise no output will be returned.
#'
#' @param path A valid file path name.
#'
#' @examples
#' # no error if path is absolute
#' validatePathIsAbsolute("Organism|path")
#'
#' # error otherwise
#' # validatePathIsAbsolute("Organism|*path")
#' @export
validatePathIsAbsolute <- function(path) {
  wildcardChar <- "*"
  path <- unlist(strsplit(path, ""), use.names = FALSE)

  if (!any(path == wildcardChar)) {
    return()
  }

  stop(messages$errorEntityPathNotAbsolute(paste0(path, collapse = "")))
}
