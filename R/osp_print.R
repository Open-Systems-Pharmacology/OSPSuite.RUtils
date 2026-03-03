#' Print an object's class name
#'
#' @description
#' Prints the class name of an object with nice formatting using cli.
#'
#' @param x An R object
#' @return Invisibly returns the input object
#' @importFrom cli cli_text cli_format_method
#' @export
#'
#' @family print functions
#'
#' @examples
#' # Print class name of a data frame
#' ospPrintClass(iris)
ospPrintClass <- function(x) {
  # Get class name of the object
  class_name <- class(x)[1]

  # Use cli_format_method to capture output and print to stdout
  output <- cli::cli_format_method({
    # Use inline markup for class name formatting
    # .cls style is nice for highlighting named entities like class names
    cli::cli_text("{.cls {class_name}}")
  })
  cat(output, sep = "\n")

  # Return the input invisibly
  invisible(x)
}

#' Print a header with specified level
#'
#' @description
#' Prints a header with the specified level (H1, H2, or H3) using cli.
#'
#' @param text The text to print as a header
#' @param level The header level (1, 2, or 3)
#' @return Invisibly returns NULL
#' @importFrom cli cli_h1 cli_h2 cli_h3
#' @export
#'
#' @family print functions
#'
#' @examples
#' # Print different header levels
#' ospPrintHeader("Main Title", 1)
#' ospPrintHeader("Section Title", 2)
#' ospPrintHeader("Subsection Title", 3)
ospPrintHeader <- function(text, level = 1) {
  # Input validation
  if (!is.numeric(level) || level < 1 || level > 3 || length(level) != 1) {
    stop("'level' must be 1, 2, or 3")
  }

  # Use cli_format_method to capture output and print to stdout
  output <- cli::cli_format_method({
    # Select header function based on level and call it
    switch(
      level,
      cli::cli_h1("{.strong {text}}"),
      cli::cli_h2("{.strong {text}}"),
      cli::cli_h3("{.strong {text}}")
    )
  })
  cat(output, sep = "\n")

  # Return invisibly
  invisible(NULL)
}

#' Helper function to check if a value is considered "empty"
#'
#' Determines if a value is empty (NULL, NA, empty string, empty vector, or empty list)
#'
#' @param val The value to check
#' @return TRUE if the value is considered empty, FALSE otherwise
#' @keywords internal
.isEmpty <- function(val) {
  if (is.null(val)) {
    return(TRUE)
  }
  # Cache length to avoid multiple calls
  len <- length(val)
  # Check for empty containers (works for both atomic vectors and lists)
  if (len == 0) {
    return(TRUE)
  }
  # Check single-element atomic values for NA or empty string
  if (is.atomic(val) && len == 1) {
    return(is.na(val) || identical(val, ""))
  }
  return(FALSE)
}

#' Format a value for display
#'
#' Converts a value into a string representation that properly shows its type
#'
#' @param value The value to format
#' @return A string representation of the value
#' @keywords internal
.formatValue <- function(value) {
  if (is.null(value)) {
    return("NULL")
  }
  if (is.atomic(value) && length(value) == 1 && is.na(value)) {
    return("NA")
  }
  if (is.atomic(value) && length(value) == 1 && identical(value, "")) {
    return("<empty string>")
  }
  if (is.atomic(value) && length(value) == 0) {
    return("<empty vector>")
  }
  if (is.list(value) && length(value) == 0) {
    return("<empty list>")
  }
  if (is.vector(value) && length(value) > 1) {
    return(paste(value, collapse = ", "))
  }
  return(as.character(value))
}

#' Print a list of items with an optional title
#'
#' @description
#' Prints a list of items from a vector or list, with an optional title.
#' Items are indented and prefixed with a dash.
#'
#' @param x A vector or list
#' @param title Optional title to display before the list (default: NULL)
#' @param print_empty Whether to print empty values (NULL, NA, empty string) (default: FALSE)
#' @return Invisibly returns the input object
#' @importFrom cli cli_text cli_ol cli_li cli_end
#' @export
#'
#' @family print functions
#'
#' @examples
#' # Print a simple vector with title
#' vector <- c("A", "B", "C")
#' ospPrintItems(vector, title = "Letters")
#'
#' # Print a named vector with title
#' named_vector <- c(A = 1, B = 2, C = 3)
#' ospPrintItems(named_vector, title = "Letters")
#'
#' # Print a list including empty values
#' list_with_nulls <- list("Min" = NULL, "Max" = 100, "Unit" = NA)
#' ospPrintItems(list_with_nulls, title = "Parameters", print_empty = TRUE)
ospPrintItems <- function(x, title = NULL, print_empty = FALSE) {
  # if x is empty and no title provided, return invisibly
  if (.isEmpty(x) && is.null(title)) {
    return(invisible(x))
  }

  # Single-pass approach: collect items to print and track emptiness simultaneously
  items_to_print <- list()
  all_items_empty <- TRUE
  
  # Process items only if x is not empty
  if (!.isEmpty(x)) {
    has_names <- !is.null(names(x)) && any(names(x) != "")
    
    for (i in seq_along(x)) {
      value <- x[[i]]
      is_empty <- .isEmpty(value)
      
      # Track if we have any non-empty items
      if (!is_empty) {
        all_items_empty <- FALSE
      }
      
      # Collect items to print
      if (!is_empty || print_empty) {
        if (has_names) {
          name <- names(x)[i]
          items_to_print[[length(items_to_print) + 1]] <- list(
            name = name,
            value = value
          )
        } else {
          items_to_print[[length(items_to_print) + 1]] <- list(
            name = NULL,
            value = value
          )
        }
      }
    }
    
    # If no items to print and title is not provided, just return invisibly
    if (all_items_empty && is.null(title) && !print_empty) {
      return(invisible(x))
    }
  }

  # Use cli_format_method to capture output and print to stdout
  output <- cli::cli_format_method({
    # Print title if provided
    if (!is.null(title)) {
      cli::cli_text("{.strong {title}}:")
    }

    # Handle empty containers
    if (.isEmpty(x)) {
      # For empty containers, just print the title (already handled above)
      # No additional content needed
    } else if (all_items_empty && !is.null(title) && !print_empty) {
      # Special case: all items are empty and title is provided
      # When print_empty is FALSE, show the message
      # Start the list
      cli::cli_div(
        theme = list(
          ul = list(
            "margin-left" = 2 # Add indentation
          )
        )
      )
      cli::cli_li("All items are NULL, NA, or empty")
      cli::cli_end()
    } else if (length(items_to_print) > 0) {
      # Process collected items
      # Start the list
      cli::cli_div(
        theme = list(
          ul = list(
            "margin-left" = 2 # Add indentation
          )
        )
      )

      # Print collected items
      for (item in items_to_print) {
        name <- item$name
        value <- item$value
        
        # Format value using format_value function
        formatted_value <- .formatValue(value)
        
        # Apply markup to values
        if (!is.null(name) && !is.na(name) && name != "") {
          cli::cli_li("{name}: {formatted_value}")
        } else {
          # No name, just value
          cli::cli_li("{formatted_value}")
        }
      }

      # End the list
      cli::cli_end()
    }
  })
  cat(output, sep = "\n")

  # Return input invisibly
  invisible(x)
}
