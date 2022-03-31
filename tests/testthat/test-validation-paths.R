test_that("validatePathIsAbsolute accepts an empty string", {
  expect_null(validatePathIsAbsolute(""))
  expect_error(validatePathIsAbsolute("*"))
})

test_that("validatePathIsAbsolute accepts a path without wildcard", {
  path <- "Organism|path"
  expect_error(validatePathIsAbsolute(path), NA)
})

test_that("validatePathIsAbsolute throws an error for a path with a wildcard", {
  path <- "Organism|*path"
  expect_error(
    validatePathIsAbsolute(path),
    messages$errorEntityPathNotAbsolute(path)
  )
})
