testDir <- "test-logging"
testLogSystem <- ospsuite.utils:::Logging$new()

test_that("record method logs appropriately and store messages", {
  expect_output(
    testLogSystem$record(
      "This is an error",
      LogTypes$Error
    ),
    "This is an error"
  )
  expect_output(
    testLogSystem$record(
      "This is an information",
      LogTypes$Info
    ),
    "This is an information"
  )
  expect_silent(
    testLogSystem$record(
      "This is a debugging note",
      LogTypes$Debug
    )
  )
  expect_length(testLogSystem$messages, 3)
})

test_that("showMessages method display messages", {
  expect_type(testLogSystem$showMessages(), "list")
  expect_equal(ncol(testLogSystem$showMessages()), 3)
  expect_equal(nrow(testLogSystem$showMessages()), 3)
})

test_that("write method saves the current logs in new directory", {
  testLogSystem$folder <- testDir
  testLogSystem$write()
  expect_true(file.exists(file.path(testDir, "log-error.txt")))
  expect_true(file.exists(file.path(testDir, "log-info.txt")))
  expect_true(file.exists(file.path(testDir, "log-debug.txt")))
})

test_that("writeAsJson method saves the current logs in a json file", {
  testLogSystem$writeAsJson(file.path(testDir, "logs.json"))
  expect_true(file.exists(file.path(testDir, "logs.json")))
})

test_that("resetLogs resets logging system", {
  testLogSystem$reset()
  expect_length(testLogSystem$messages, 0)
  expect_null(testLogSystem$folder)
})

unlink(testDir, recursive = TRUE)
