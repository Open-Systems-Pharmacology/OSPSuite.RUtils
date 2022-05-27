test_that("Checks if toList work properly", {
  expect_type(toList(list("a" = 1, "b" = 2)), "list")
  expect_type(toList(c("a" = 1, "b" = 2)), "list")
  expect_type(toList(c("a" = 1, "b" = 2, c("c" = 3))), "list")
})

test_that("Checks if %||% work properly", {
  expect_equal(NULL %||% 2, 2)
  expect_equal(3 %||% 2, 3)
})
