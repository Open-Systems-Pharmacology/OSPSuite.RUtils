test_that("objCount returns correct count for atomic vectors", {
  expect_equal(objCount(c(1, 2, 3)), 3)
  expect_equal(objCount(character()), 0L)
})

test_that("objCount returns correct count for lists", {
  expect_equal(objCount(list("a", "b")), 2L)
  expect_equal(objCount(list()), 0L)
})

test_that("objCount returns correct count for other objects", {
  expect_equal(objCount(mtcars), 1L)

  myPrintable <- Printable$new()
  expect_equal(objCount(myPrintable), 1L)

  expect_equal(objCount(list(myPrintable, myPrintable)), 2L)
})
