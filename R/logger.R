#' @title timeStamp
#' @description Print time stamp
#' @export
#' @examples
#' timeStamp()
timeStamp <- function() {
  return(format(Sys.time(), "%d/%m/%Y - %H:%M:%S"))
}

#' @title msgHeader
#' @description Message header displaying log level and time stamp
#' @param logLevel Log level as a character string (DEBUG, INFO, SUCCESS, WARN, ERROR, FATAL)
#' @return A formatted string with the log level and timestamp
#' @keywords internal
#' @importFrom glue glue
msgHeader <- function(logLevel) {
  glue::glue(
    switch(
      logLevel,
      "DEBUG" = "Debug",
      "INFO" = cli::col_blue("Info"),
      "SUCCESS" = cli::col_green("Info"),
      "WARN" = cli::col_yellow("Warning"),
      "ERROR" = cli::col_red("Error"),
      "FATAL" = cli::col_red("Error")
    ),
    " [{timeStamp()}]: "
  )
}

#' @title cliFormat
#' @description
#' Format text into cli inline format
#' Allows evaluation of expressions within the text before submitting to logs
#' @param ... Characters to format
#' @param .envir Environment in which to evaluate the expressions
#' @return A formatted character string
#' @export
#' @importFrom cli format_inline
cliFormat <- function(..., .envir = parent.frame()) {
  cli::format_inline(paste(..., sep = "\n"), .envir = .envir)
}

#' @title cliFromLevel
#' @description Get appropriate cli function based on log level
#' @param logLevel Log level as a character string (DEBUG, INFO, SUCCESS, WARN, ERROR, FATAL)
#' @return A function
#' @keywords internal
#' @import cli
cliFromLevel <- function(logLevel) {
  switch(
    logLevel,
    "INFO" = cli::cli_alert_info,
    "SUCCESS" = cli::cli_alert_success,
    "WARN" = cli::cli_alert_warning,
    "ERROR" = cli::cli_alert_danger
  )
}

#' @title consoleLayout
#' @description
#' Function that will display pretty log messages on console
#' @inheritParams logger::layout_glue
#' @keywords internal
consoleLayout <- function(
  level,
  msg,
  namespace = NA_character_,
  .logcall = sys.call(),
  .topcall = sys.call(-1),
  .topenv = parent.frame()
) {
  logger::fail_on_missing_package("cli")
  logLevel <- attr(level, "level")
  # Main message - split and use vectorized approach
  # strsplit always returns a list with at least one element (empty string if msg is empty)
  msg <- strsplit(msg, "\n", fixed = TRUE)[[1]]
  cliFunction <- cliFromLevel(logLevel)
  cliFunction(c("{msgHeader(logLevel)} ", msg[1]))

  # Following messages - use vectorized approach if multiple messages
  if (length(msg) > 1) {
    for (msgIndications in msg[-1]) {
      cli::cli_alert(msgIndications)
    }
  }
  return()
}

#' @title fileLayout
#' @description
#' Function that will display pretty log messages on console
#' @inheritParams logger::layout_glue
#' @importFrom crayon strip_style
#' @keywords internal
fileLayout <- function(
  level,
  msg,
  namespace = NA_character_,
  .logcall = sys.call(),
  .topcall = sys.call(-1),
  .topenv = parent.frame()
) {
  crayon::strip_style(
    logger::layout_glue(
      level = level,
      msg = paste(sapply(msg, cli::format_inline), collapse = "\n"),
      namespace = namespace,
      .logcall = .logcall,
      .topcall = .topcall,
      .topenv = .topenv
    )
  )
}

#' @title shouldMaskMessage
#' @description Check if a message should be masked based on patterns
#' @param message The message text to check
#' @param patterns Vector of patterns to match against
#' @return Logical indicating if message should be masked
#' @keywords internal
shouldMaskMessage <- function(message, patterns) {
  if (is.null(patterns) || length(patterns) == 0) {
    return(FALSE)
  }
  
  # Early exit: check if any pattern matches
  for (pattern in patterns) {
    if (grepl(pattern, message, ignore.case = TRUE)) {
      return(TRUE)
    }
  }
  
  return(FALSE)
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
        logError(errorCondition$message)
        logInfo("Error trace", type = "alert")
        calls <- sys.calls()
        maskingPatterns <- ospsuiteUtilsEnv$logging$errorMasking
        
        # Pre-allocate vector with maximum possible size
        errorTrace <- character(length(calls))
        traceIndex <- 0L
        
        for (call in calls) {
          textCall <- deparse(call, nlines = 1)
          
          # Early exit: check if any pattern matches
          callNotDisplayed <- FALSE
          if (!is.null(maskingPatterns)) {
            for (pattern in maskingPatterns) {
              if (grepl(pattern, textCall, ignore.case = TRUE)) {
                callNotDisplayed <- TRUE
                break
              }
            }
          }
          
          if (!callNotDisplayed) {
            traceIndex <- traceIndex + 1L
            errorTrace[traceIndex] <- gsub(pattern = "(\\{)|(\\})", replacement = "", textCall)
          }
        }
        
        # Trim to actual size
        if (traceIndex > 0L) {
          errorTrace <- errorTrace[1:traceIndex]
        } else {
          errorTrace <- character(0)
        }
        
        logInfo(errorTrace, type = "ol")
        stop(errorCondition$message)
      },
      # For warnings: display warning unless masked.
      # In which case, save them in log-debug.
      warning = function(warningCondition) {
        callNotDisplayed <- shouldMaskMessage(
          warningCondition$message,
          ospsuiteUtilsEnv$logging$warningMasking
        )
        
        if (callNotDisplayed) {
          logDebug(warningCondition$message)
        } else {
          logWarning(warningCondition$message)
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
        if (is.null(messageCondition$call)) {
          return()
        }
        # Remove unwanted messages especially from ggplot
        # In case, include them in log debug
        callNotDisplayed <- shouldMaskMessage(
          messageCondition$message,
          ospsuiteUtilsEnv$logging$infoMasking
        )
        
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
      cli::cli_abort(errorCondition$message, call = NULL)
    }
  )
}
