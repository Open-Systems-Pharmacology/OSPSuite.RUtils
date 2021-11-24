test_that("Checks if utilities work properly", {
  expect_null(ifNotNull(NULL, "x"))
  expect_equal(ifNotNull(NULL, "x", "y"), "y")
  expect_equal(ifNotNull(1 < 2, "x", "y"), "x")

  expect_type(toList(list("a" = 1, "b" = 2)), "list")
  expect_type(toList(c("a" = 1, "b" = 2)), "list")
  expect_type(toList(c("a" = 1, "b" = 2, c("c" = 3))), "list")

  expect_equal(NULL %||% 2, 2)
  expect_equal(3 %||% 2, 3)
})
