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

test_that("Checks if Printable subclass cloning works as expected", {
  newPrintable1 <- R6Class(
    "newPrintable1",
    inherit = Printable,
    cloneable = TRUE
  )

  expect_snapshot(newPrintable1$new()$clone())

  newPrintable2 <- R6Class(
    "newPrintable2",
    inherit = Printable,
    cloneable = FALSE
  )

  expect_no_error(newPrintable2$new()$clone())
})
