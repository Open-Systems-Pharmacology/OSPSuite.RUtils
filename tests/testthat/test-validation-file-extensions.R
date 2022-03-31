test_that("isFileExtension returns `TRUE` if extension is as expected", {
  expect_true(isFileExtension("enum.R", "R"))
  expect_true(isFileExtension("DESCRIPTION", ""))
  expect_true(isFileExtension("foo.", ""))
  expect_true(isFileExtension("C:/Users/.gitignore", "gitignore"))
})

test_that("isFileExtension returns `FALSE` if extension is unexpected", {
  expect_false(isFileExtension("enum.R", "pkml"))
  expect_false(isFileExtension("DESCRIPTION", "R"))
})
