test_that("isPathAbsolute returns TRUE for absolute paths", {
  expect_true(isPathAbsolute(""))
  expect_true(isPathAbsolute("Organism|path"))
  expect_true(isPathAbsolute("Organism|path|subpath"))
})

test_that("isPathAbsolute returns FALSE for relative paths with wildcard", {
  expect_false(isPathAbsolute("*"))
  expect_false(isPathAbsolute("Organism|*path"))
  expect_false(isPathAbsolute("*path|subpath"))
})

test_that("validateIsPathAbsolute accepts an empty string", {
  expect_null(validateIsPathAbsolute(""))
  expect_error(validateIsPathAbsolute("*"))
})

test_that("validateIsPathAbsolute accepts a path without wildcard", {
  path <- "Organism|path"
  expect_error(validateIsPathAbsolute(path), NA)
})

test_that("validateIsPathAbsolute throws an error for a path with a wildcard", {
  path <- "Organism|*path"
  expect_error(
    validateIsPathAbsolute(path),
    "(Only absolute paths).*(without the wildcard).*(are allowed, but the given path is).*(Organism|\\*path)"
  )
})

test_that("validatePathIsAbsolute (alias) accepts an empty string", {
  expect_null(validatePathIsAbsolute(""))
  expect_error(validatePathIsAbsolute("*"))
})

test_that("validatePathIsAbsolute (alias) accepts a path without wildcard", {
  path <- "Organism|path"
  expect_error(validatePathIsAbsolute(path), NA)
})

test_that("validatePathIsAbsolute (alias) throws an error for a path with a wildcard", {
  path <- "Organism|*path"
  expect_error(
    validatePathIsAbsolute(path),
    "(Only absolute paths).*(without the wildcard).*(are allowed, but the given path is).*(Organism|\\*path)"
  )
})
