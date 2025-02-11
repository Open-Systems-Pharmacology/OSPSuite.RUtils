testDir <- "test-logging"

test_that("Elapsed time provide appropriate time", {
  t0 <- tic()
  Sys.sleep(2)
  # rounded elapsed time can be higher than 2 seconds
  expect_match(getElapsedTime(t0, unit = "s"), "2")
  expect_match(getElapsedTime(t0, unit = "s"), "s")
  expect_type(t0, "double")
})

test_that("Time stamp provides a date", {
  expect_type(timeStamp(), "character")
  expect_match(timeStamp(), "^\\d{2}\\/\\d{2}\\/\\d{4}")
})


test_that("Setting and getting Logging folder work appropriately", {
  expect_null(getLogFolder())
  expect_invisible(setLogFolder(testDir))
  expect_equal(testDir, getLogFolder())
})

test_that("logError logs an error in log-error.txt", {
  expect_output(logError("This is an error"), "This is an error")
  expect_true(file.exists(file.path(testDir, "log-error.txt")))
  expect_match(
    paste(readLines(file.path(testDir, "log-error.txt")), collapse = " "),
    "This is an error"
  )
})

test_that("logInfo logs an information in log-info.txt", {
  expect_output(logInfo("This is an information"), "This is an information")
  expect_true(file.exists(file.path(testDir, "log-info.txt")))
  expect_match(
    paste(readLines(file.path(testDir, "log-info.txt")), collapse = " "),
    "This is an information"
  )
})

test_that("logDebug logs silently a debugging note in log-debug.txt", {
  expect_silent(logDebug("This is a debugging note"))
  expect_true(file.exists(file.path(testDir, "log-debug.txt")))
  expect_match(
    paste(readLines(file.path(testDir, "log-debug.txt")), collapse = " "),
    "This is a debugging note"
  )
})

test_that("logCatch catches errors and warnings in log-error.txt", {
  expect_output(
    logCatch({
      warning("This warning was caught")
    }),
    "This warning was caught"
  )
  expect_output(
    expect_error(
      logCatch({
        stop("This error was caught")
      }),
      "This error was caught"
    ),
    "This error was caught"
  )
  expect_match(
    paste(readLines(file.path(testDir, "log-error.txt")), collapse = " "),
    "This warning was caught"
  )
  expect_match(
    paste(readLines(file.path(testDir, "log-error.txt")), collapse = " "),
    "This error was caught"
  )
})

test_that("logCatch stop logging after error is found", {
  expect_null(getLogFolder())
})

test_that("showLogMessages provides a data.frame of the logs", {
  expect_type(showLogMessages(), "list")
  expect_equal(ncol(showLogMessages()), 3)
  expect_equal(nrow(showLogMessages()), 5)
})

setLogFolder(testDir)
test_that("logCatch masking works as expected", {
  expect_invisible(setInfoMasking("masked info"))
  expect_invisible(setWarningMasking("masked warning"))
  expect_invisible(setErrorMasking("masked error"))

  expect_silent(logCatch({
    message("masked info")
  }))
  expect_silent(logCatch({
    warning("masked warning")
  }))
  expect_match(
    paste(readLines(file.path(testDir, "log-debug.txt")), collapse = " "),
    "masked info"
  )
  expect_match(
    paste(readLines(file.path(testDir, "log-debug.txt")), collapse = " "),
    "masked info"
  )
  expect_match(
    paste(readLines(file.path(testDir, "log-debug.txt")), collapse = " "),
    "masked warning"
  )
  expect_output(logCatch({
    warning("masked warning")
    message("masked message")
    warning("shown warning")
    message("shown message")
  }), "shown message")

  expect_match(
    paste(readLines(file.path(testDir, "log-info.txt")), collapse = " "),
    "shown message"
  )
  expect_match(
    paste(readLines(file.path(testDir, "log-error.txt")), collapse = " "),
    "shown warning"
  )
})

testDir2 <- file.path(testDir, "newDir")
test_that("saveLogs saves the current logs in new directory", {
  saveLogs(testDir2)
  expect_true(file.exists(file.path(testDir2, "log-error.txt")))
  expect_true(file.exists(file.path(testDir2, "log-info.txt")))
  expect_true(file.exists(file.path(testDir2, "log-debug.txt")))
})

test_that("saveLogsToJson saves the current logs in a json file", {
  saveLogsToJson(file.path(testDir2, "logs.json"))
  expect_true(file.exists(file.path(testDir2, "logs.json")))
})

test_that("resetLogs resets logging system", {
  resetLogs()
  expect_null(showLogMessages())
})

test_that("highlight does not deform displayed message", {
  expect_output(cat(highlight("a")), "a")
})

unlink(testDir, recursive = TRUE)
