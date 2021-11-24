test_that("Checks if Printable prints properly", {
  myPrintable <- R6::R6Class(
    "myPrintable",
    inherit = Printable,
    public = list(
      x = NULL,
      y = NULL,
      print = function() {
        private$printClass()
        private$printLine("x", self$x)
        private$printLine("y", self$y)
        invisible(self)
      }
    )
  )

  x <- myPrintable$new()
  expect_snapshot(x, cran = TRUE)
})
