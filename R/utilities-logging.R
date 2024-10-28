#' @title tic
#' @description Trigger time tracker
#' @return System time
#' @export
#' @examples
#' tic()
#'
tic <- function() {
  return(Sys.time())
}

#' @title getElapsedTime
#' @description Get elapsed time between `tic` trigger and now
#' @param tic Start time
#' @param unit display unit of elapsed time
#' @return Character displaying elapsed time in `unit`
#' @export
#' @examples
#' t0 <- tic()
#' Sys.sleep(2)
#' # Get elapsed time in seconds
#' getElapsedTime(t0, "s")
#' # Get elapsed time in minutes
#' getElapsedTime(t0, "min")
getElapsedTime <- function(tic, unit = "min") {
  elapsedTime <- difftime(
    Sys.time(),
    tic,
    # Use switch to map between difftime and ospsuite units
    units = switch(unit,
      "h" = "hours",
      "min" = "mins",
      "s" = "secs",
      unit
    )
  )
  return(paste(round(elapsedTime, 1), unit))
}

#' @title timeStamp
#' @description Print time stamp
#' @export
#' @examples
#' timeStamp()
timeStamp <- function() {
  return(format(Sys.time(), "%d/%m/%Y - %H:%M:%S"))
}

#' @title resetLogs
#' @description Reset/empty messages of global logging system
#' @param folder Folder where logs are saved
#' @export
#' @keywords logging
#' @examples
#' resetLogs()
resetLogs <- function(folder = NULL) {
  ospsuiteUtilsEnv$logging$reset(folder)
  return(invisible())
}

#' @title setLogFolder
#' @description Set folder where logs are saved
#' @param folder Folder where logs are saved
#' @export
#' @keywords logging
#' @examples
#' # Set log folder to a temporary directory
#' setLogFolder(tempdir())
#'
#' # Set logFolder to `NULL`, cancel saving of logs
#' setLogFolder()
#'
setLogFolder <- function(folder = NULL) {
  ospsuiteUtilsEnv$logging$folder <- folder
  return(invisible())
}

#' @title getLogFolder
#' @description Get folder where logs are saved
#' @export
#' @keywords logging
#' @examples
#' # Set/get log folder to a temporary directory
#' setLogFolder(tempdir())
#' getLogFolder()
#'
#' # Set/get logFolder to `NULL`, cancel saving of logs
#' setLogFolder()
#' getLogFolder()
getLogFolder <- function() {
  return(ospsuiteUtilsEnv$logging$folder)
}

#' @title saveLogsToJson
#' @description Save workflow logs to a json file
#' @param jsonFile Path of json file saving log messages
#' @export
#' @keywords logging
#' @examples \dontrun{
#' saveLogsToJson("logs.json")
#' }
saveLogsToJson <- function(jsonFile) {
  validateIsFileExtension(jsonFile, "json")
  ospsuiteUtilsEnv$logging$writeAsJson(jsonFile)
  return(invisible())
}

#' @title saveLogs
#' @description Save workflow logs to their respective files
#' @param folder Directory into which logs will be saved
#' @export
#' @keywords logging
#' @examples \dontrun{
#' saveLogsToJson(getwd())
#' }
saveLogs <- function(folder = NULL) {
  if (!is.null(folder)) {
    setLogFolder(folder)
  }
  ospsuiteUtilsEnv$logging$write()
  return(invisible())
}

#' @title showLogMessages
#' @description Display log messages as a data.frame
#' @param logTypes Select specific logs in `LogTypes` that will be displayed in the data.frame.
#' @export
#' @keywords logging
#' @examples
#' # Record some information
#' logInfo("This is an info message")
#' logError("This is an error message")
#' # Show all log messages
#' showLogMessages()
showLogMessages <- function(logTypes = LogTypes) {
  validateIsIncluded(logTypes, LogTypes)
  return(ospsuiteUtilsEnv$logging$showMessages(logTypes))
}

#' @title highlight
#' @description Highlight text in console
#' @param text Text to highlight
#' @export
#' @examples
#' cat(paste("This is an", highlight("highlight")))
highlight <- function(text) {
  return(crayon::cyan$bold$italic(as.character(text)))
}

#' @title logError
#' @description Save error messages into a log error file
#' @param message message to save in log file
#' @param printConsole logical to print error on console
#' @export
#' @keywords logging
#' @examples
#' logError("This is an error message")
logError <- function(message, printConsole = NULL) {
  ospsuiteUtilsEnv$logging$record(
    message,
    logType = LogTypes$Error,
    display = printConsole
  )
  return(invisible())
}

#' @title logDebug
#' @description Save intermediate messages into a log debug file
#' @param message message to save in log file
#' @param printConsole logical to print error on console
#' @export
#' @keywords logging
#' @examples
#' logDebug("This is a debug message")
logDebug <- function(message, printConsole = NULL) {
  ospsuiteUtilsEnv$logging$record(
    message,
    logType = LogTypes$Debug,
    display = printConsole
  )
  return(invisible())
}

#' @title logInfo
#' @description Save info messages into a log info file
#' @param message message to save in log file
#' @param printConsole logical to print error on console
#' @export
#' @keywords logging
#' @examples
#' logInfo("This is an info message")
logInfo <- function(message, printConsole = NULL) {
  ospsuiteUtilsEnv$logging$record(
    message,
    logType = LogTypes$Info,
    display = printConsole
  )
  return(invisible())
}

#' @title logCatch
#' @description Catch errors, log and display meaningful information
#' @param expr Evaluated code chunks
#' @export
#' @keywords logging
#' @examples
#' # Catch and display warning message
#' logCatch({
#'   warning("This is a warning message")
#' })
logCatch <- function(expr) {
  tryCatch(
    withCallingHandlers(
      expr,
      # For errors: display error trace and mask unwanted information from it
      error = function(errorCondition) {
        calls <- sys.calls()
        errorTrace <- crayon::yellow$bold("Error Trace")
        for (call in calls) {
          textCall <- deparse(call, nlines = 1)
          callNotDisplayed <- any(sapply(
            ospsuiteUtilsEnv$logging$callNotDisplayed$error,
            FUN = function(pattern) {
              grepl(textCall, pattern = pattern, ignore.case = TRUE)
            }
          ))
          if (callNotDisplayed) {
            next
          }
          tabs <- paste0(rep(" ", length(errorTrace)), collapse = "")
          errorTrace <- c(errorTrace, paste0(tabs, "\u21aa ", textCall))
        }
        errorMessage <- c(errorCondition$message, errorTrace)
        logError(errorMessage)
        stop(errorCondition$message)
      },
      # For warnings: display warning unless masked.
      # In which case, save them in log-debug.
      warning = function(warningCondition) {
        callNotDisplayed <- any(sapply(
          ospsuiteUtilsEnv$logging$callNotDisplayed$warning,
          FUN = function(pattern) {
            grepl(warningCondition$message, pattern = pattern, ignore.case = TRUE)
          }
        ))
        if (callNotDisplayed) {
          logDebug(warningCondition$message)
        } else {
          logError(warningCondition$message)
        }
        # invokeRestart("muffleWarning") prevents the unwanted  display of the message
        # as an actual warning written in red on the console
        # However, if the restart is not found, this ends up with an error
        # tryInvokeRestart could have been used instead but appeared only on R.version 4.0.0
        try({
          invokeRestart("muffleWarning")
        })
      },
      # For messages: display message unless masked.
      # In which case, save them in log-debug.
      message = function(messageCondition) {
        # Remove unwanted messages especially from ggplot
        # In case, include them in log debug
        callNotDisplayed <- any(sapply(
          ospsuiteUtilsEnv$logging$callNotDisplayed$message,
          FUN = function(pattern) {
            grepl(messageCondition$message, pattern = pattern, ignore.case = TRUE)
          }
        ))
        if (callNotDisplayed) {
          logDebug(messageCondition$message)
        } else {
          logInfo(messageCondition$message)
        }
        # Allows logCatch to go on after catching a message
        try({
          invokeRestart("muffleMessage")
        })
      }
    ),
    error = function(errorCondition) {
      # Prevent logging new messages in old log files after crash
      setLogFolder()
      stop(errorCondition$message, call. = FALSE)
    }
  )
}

#' @title setErrorMasking
#' @description Mask error trace messages
#' @param patterns
#' Character patterns to identify with `grepl()` when masking messages
#' @export
#' @keywords logging
#' @examples
#' setErrorMasking(c("tryCatch", "withCallingHandlers"))
setErrorMasking <- function(patterns) {
  ospsuiteUtilsEnv$logging$callNotDisplayed$error <- patterns
  return(invisible())
}

#' @title setWarningMasking
#' @description Mask warning messages
#' @param patterns
#' Character patterns to identify with `grepl()` when masking messages
#' @export
#' @keywords logging
#' @examples
#' # Mask ggplot2 warning message when missing values are found
#' setWarningMasking("rows containing missing values")
setWarningMasking <- function(patterns) {
  ospsuiteUtilsEnv$logging$callNotDisplayed$warning <- patterns
  return(invisible())
}

#' @title setInfoMasking
#' @description Mask info messages
#' @param patterns
#' Character patterns to identify with `grepl()` when masking messages
#' @export
#' @keywords logging
#' @examples
#' # Mask ggplot2 message when line is used with 1 value per group
#' setInfoMasking("Each group consists of only one observation")
setInfoMasking <- function(patterns) {
  ospsuiteUtilsEnv$logging$callNotDisplayed$message <- patterns
  return(invisible())
}

# Define default values for error masking
setErrorMasking(patterns = c(
  "logCatch",
  "qualificationCatch",
  "stop",
  "tryCatch",
  "withCallingHandlers",
  "simpleError",
  "eval\\(ei, envir\\)"
))
