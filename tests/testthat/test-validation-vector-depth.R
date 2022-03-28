test_that("hasVectorDepth returns TRUE when vector depth of expected length", {
  expect_true(hasVectorDepth(c(1), 1L))
  expect_true(hasVectorDepth(list(), 1L))
})

test_that("hasVectorDepth returns FALSE when vector depth is not of expected length", {
  expect_false(hasVectorDepth(list(1), 1L))
  expect_false(hasVectorDepth(character(), 2L))
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
