#' @title Printable
#' @docType class
#'
#' @description
#' Base class that implements some basic properties for printing to console.
#'
#' @importFrom R6 R6Class
#'
#' @examples
#' myPrintable <- R6::R6Class(
#'   "myPrintable",
#'   inherit = Printable,
#'   public = list(
#'     x = NULL,
#'     y = NULL,
#'     print = function() {
#'       private$printClass()
#'       private$printLine("x", self$x)
#'       private$printLine("y", self$y)
#'       invisible(self)
#'     }
#'   )
#' )
#'
#' x <- myPrintable$new()
#' x
#' @export
Printable <- R6::R6Class(
  "Printable",
  cloneable = TRUE,
  private = list(
    printLine = function(entry, value, addTab = TRUE) {
      # Only add ":" if values are provided
      if (!missing(value)) {
        entries <- paste0(entry, ":")
      } else {
        entries <- entry
      }

      # helps to visually distinguish class name from its entries
      if (addTab) {
        entries <- c("  ", entries)
      }

      # This is required to avoid adding "NULL" to all lines where no value is provided
      if (!missing(value)) {
        value <- format(value)
        entries <- c(entries, value, "\n")
      } else {
        entries <- c(entries, "\n")
      }

      cat(entries, sep = " ")
      invisible(self)
    },
    printClass = function() {
      cat(class(self)[1], ": \n", sep = "")
    }
  )
)
