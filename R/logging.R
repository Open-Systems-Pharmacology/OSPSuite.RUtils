#' @title LogTypes
#' @description List of log types for recording workflow information
#' @export
#' @examples
#' LogTypes
#'
LogTypes <- enum(c("Info", "Error", "Debug"))

#' @title Logging
#' @description R6 class managing logging system
#' @keywords internal
Logging <- R6::R6Class(
  "Logging",
  cloneable = FALSE,
  public = list(
    #' @field messages Array of messages to log.
    #' Each element of `messages` is a list
    #' that includes `time`, `type` and `text` of message to log.
    messages = list(),
    #' @field folder Folder where log files are saved
    folder = NULL,
    #' @field display Named list of logical values
    #' defining whether message should be displayed on console
    display = list(Error = TRUE, Info = TRUE, Debug = FALSE),
    #' @field callNotDisplayed Named list of keywords for which 
    #' error, warning or message conditions will be masked
    callNotDisplayed = list(error = NULL, warning = NULL, message = NULL),

    #' @description
    #' Record a message to log, display if necessary
    #' Add an `Info` message to log
    #' @param text content of the `Info` message
    #' @param logType description
    #' @param display Logical setting if message is displayed on console
    record = function(text, logType = LogTypes$Info, display = NULL) {
      message <- self$textToMessage(text = text, logType = logType)
      self$printMessage(message, display = display)
      self$saveMessage(message)
      self$addMessage(message)
      return(invisible())
    },

    #' @description
    #' Add meta data to `text` to create an informative message to log
    #' with a flag for its `logType` (`"Info"`, `"Error"`, or `"Debug"`)
    #' @param text content of the message
    #' @param logType type of message. A value enum `LogTypes`.
    textToMessage = function(text, logType) {
      list(
        time = timeStamp(),
        type = logType,
        text = text
      )
    },

    #' @description
    #' Add a message to the list of logged `messages`
    #' @param message content of the message
    addMessage = function(message) {
      message$text <- crayon::strip_style(message$text)
      self$messages[[length(self$messages) + 1]] <- message
    },

    #' @description
    #' Display logged `messages` as a data.frame
    #' Can be filtered according to `logTypes` (`"Info"`, `"Error"`, and/or `"Debug"`)
    #' @param logTypes types of message (`"Info"`, `"Error"`, or `"Debug"`)
    showMessages = function(logTypes = LogTypes) {
      messagesTable <- do.call(
        rbind,
        lapply(
          self$messages,
          function(message) {
            message$text <- paste(message$text, collapse = "<br>")
            as.data.frame(message)
          }
        )
      )
      selectedMessages <- messagesTable$type %in% logTypes
      return(messagesTable[selectedMessages, ])
    },

    #' @description
    #' Print the log messages on R/RStudio console
    #' @param message Message to print
    #' @param display Logical setting if message is displayed on console
    printMessage = function(message, display = NULL) {
      toPrintOnConsole <- display %||% self$display[[message$type]]
      if (!toPrintOnConsole) {
        return(invisible())
      }
      # Start with message time stamp,
      # Then display message with appropriate colors
      cat(paste0(message$time, "\n"))
      cat(switch(message$type,
        "Error" = crayon::yellow$bold("! Warning: "),
        "Info" = crayon::green$bold("i Info: "),
        "Debug" = crayon::blue$bold("# Note: ")
      ))
      # Each line is separated with an arrow of logtype color
      cat(
        message$text,
        sep = switch(message$type,
          "Error" = crayon::yellow$bold("\n\u279d "),
          "Info" = crayon::green$bold("\n\u279d "),
          "Debug" = crayon::blue$bold("\n\u279d ")
        )
      )
      return(invisible())
    },

    #' @description
    #' Write a message in its log file
    #' @param message Message to print
    saveMessage = function(message) {
      if (is.null(self$folder)) {
        return(invisible())
      }
      if (!file.exists(self$folder)) {
        dir.create(self$folder, showWarnings = FALSE, recursive = TRUE)
      }
      logFile <- switch(message$type,
        "Info" = file.path(self$folder, private$.logInfo),
        "Error" = file.path(self$folder, private$.logError),
        "Debug" = file.path(self$folder, private$.logDebug)
      )
      fileObject <- file(logFile, encoding = "UTF-8", open = "at")
      write(message$time, file = fileObject, append = TRUE)
      write(crayon::strip_style(message$text), file = fileObject, append = TRUE, sep = "\n")
      close(fileObject)
      return(invisible())
    },

    #' @description
    #' Write the log messages in a json log file
    #' @param fileName Name of json log file
    writeAsJson = function(fileName) {
      write(
        jsonlite::toJSON(self$messages, auto_unbox = TRUE, pretty = TRUE),
        file = fileName
      )
      return(invisible())
    },

    #' @description
    #' Write the log messages in txt log files
    write = function() {
      for (message in self$messages) {
        self$saveMessage(message)
      }
      return(invisible())
    },

    #' @description
    #' Reset/empty log messages
    #' @param folder Folder where logs are saved
    reset = function(folder = NULL) {
      self$messages <- list()
      self$folder <- folder
      return(invisible())
    }
  ),
  private = list(
    .logInfo = "log-info.txt",
    .logError = "log-error.txt",
    .logDebug = "log-debug.txt"
  )
)
