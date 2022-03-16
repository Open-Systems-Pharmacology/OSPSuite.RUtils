test_that("objectCount returns correct count for atomic vectors", {
  expect_equal(objectCount(c(1, 2, 3)), 3)
  expect_equal(objectCount(character()), 0L)
})

test_that("objectCount returns correct count for lists", {
  expect_equal(objectCount(list("a", "b")), 2L)
  expect_equal(objectCount(list()), 0L)
})

test_that("objectCount returns correct count for other objects", {
  expect_equal(objectCount(mtcars), 1L)

  myPrintable <- Printable$new()
  expect_equal(objectCount(myPrintable), 1L)

  expect_equal(objectCount(list(myPrintable, myPrintable)), 2L)
})
