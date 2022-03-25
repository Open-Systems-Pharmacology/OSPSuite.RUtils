test_that("isVectorDepth returns TRUE when vector depth of expected length", {
  expect_true(isVectorDepth(c(1), 1L))
  expect_true(isVectorDepth(list(), 1L))
})

test_that("isVectorDepth returns FALSE when vector depth is not of expected length", {
  expect_false(isVectorDepth(list(1), 1L))
  expect_false(isVectorDepth(character(), 2L))
})

test_that("validateVectorDepth returns NULL when vector depth of expected length", {
  expect_null(validateVectorDepth(c(1), 1L))
  expect_null(validateVectorDepth(list(), 1L))
  expect_null(validateVectorDepth(list(1)))
})

test_that("validateIsInteger produces error when vector depth is not of expected length", {
  myVec <- list(list(1))

  expect_error(
    validateVectorDepth(myVec),
    messages$errorWrongVectorDepth(purrr::vec_depth(myVec), 2L, "myVec")
  )
})
