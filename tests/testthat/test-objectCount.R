test_that("objectCount returns correct count for atomic vectors", {
  x <- c(1, 2, 3)
  expect_equal(objectCount(x), 3L)

  names(x) <- c("a", "b", "c")
  expect_equal(objectCount(x), 3L)

  attr(x, "rando") <- "random"
  expect_equal(objectCount(x), 3L)

  expect_equal(objectCount(character()), 0L)
})

test_that("objectCount returns correct count for lists", {
  x <- list("a", "b")
  expect_equal(objectCount(x), 2L)

  names(x) <- c("a", "b")
  expect_equal(objectCount(x), 2L)

  attr(x, "rando") <- "random"
  expect_equal(objectCount(x), 2L)

  expect_equal(objectCount(list()), 0L)
})

test_that("objectCount returns correct count for other objects", {
  expect_equal(objectCount(mtcars), 1L)

  myPrintable <- Printable$new()
  expect_equal(objectCount(myPrintable), 1L)

  expect_equal(objectCount(list(myPrintable, myPrintable)), 2L)
})
