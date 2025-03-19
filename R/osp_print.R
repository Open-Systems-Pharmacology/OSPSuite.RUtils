#' Print an object's class name
#'
#' @description
#' Prints the class name of an object with nice formatting using cli.
#'
#' @param x An R object
#' @return Invisibly returns the input object
#' @importFrom cli cli_text
#' @export
#'
#' @family print functions
#'
#' @examples
#' # Print class name of a data frame
#' osp_print_class(iris)
osp_print_class <- function(x) {
  # Get class name of the object
  class_name <- class(x)[1]

  # Use inline markup for class name formatting
  # .cls style is nice for highlighting named entities like class names
  cli::cli_text("{.cls {class_name}}")

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
#' osp_print_header("Main Title", 1)
#' osp_print_header("Section Title", 2)
#' osp_print_header("Subsection Title", 3)
osp_print_header <- function(text, level = 1) {
  # Input validation
  if (!is.numeric(level) || level < 1 || level > 3 || length(level) != 1) {
    stop("'level' must be 1, 2, or 3")
  }

  # Select header function based on level
  header_func <- switch(level,
    cli::cli_h1,
    cli::cli_h2,
    cli::cli_h3
  )

  # Use .strong markup for header text to make it stand out more
  # Headers already have formatting but additional markup can enhance them
  header_func("{.strong {text}}")

  # Return invisibly
  invisible(NULL)
}

#' Print a list of items with an optional title
#'
#' @description
#' Prints a list of items from a vector or list, with an optional title.
#' Items are indented and prefixed with a dash.
#'
#' @param x A vector or list
#' @param title Optional title to display before the list (default: NULL)
#' @param print_empty Whether to print empty values (NULL, NA, or empty string) (default: FALSE)
#' @return Invisibly returns the input object
#' @importFrom cli cli_text cli_ol cli_li cli_end
#' @export
#'
#' @family print functions
#'
#' @examples
#' # Print a simple vector with title
#' vector <- c("A", "B", "C")
#' osp_print_items(vector, title = "Letters")
#'
#' # Print a named vector with title
#' named_vector <- c(A = 1, B = 2, C = 3)
#' osp_print_items(named_vector, title = "Letters")
#'
#' # Print a list including empty values
#' list_with_nulls <- list("Min" = NULL, "Max" = 100, "Unit" = NA)
#' osp_print_items(list_with_nulls, title = "Parameters", print_empty = TRUE)
osp_print_items <- function(x, title = NULL, print_empty = FALSE) {
  # Print title if provided
  if (!is.null(title)) {
    cli::cli_text("{.strong {title}}:")
  }

  # Helper function to check if a value is considered "empty" (NULL, NA, or "")
  is_empty_value <- function(val) {
    if (is.null(val)) {
      return(TRUE)
    }
    if (is.atomic(val) && length(val) == 1) {
      return(is.na(val) || identical(val, ""))
    }
    return(FALSE)
  }
  
  # Count items that will be printed and check if all are "empty"
  items_to_print <- 0
  all_items_empty <- TRUE
  
  # Check all items first
  for (i in seq_along(x)) {
    value <- x[[i]]
    if (!is_empty_value(value)) {
      all_items_empty <- FALSE
      items_to_print <- items_to_print + 1
    } else if (print_empty) {
      items_to_print <- items_to_print + 1
    }
  }
  
  # Special case: all items are empty and title is provided
  if (all_items_empty && !is.null(title) && length(x) > 0) {
    # When print_empty is FALSE, show the message
    if (!print_empty) {
      # Start the list
      cli::cli_div(theme = list(ul = list(
        "margin-left" = 2 # Add indentation
      )))
      
      list_id <- cli::cli_ul()
      cli::cli_li("All items are NULL, NA, or empty")
      cli::cli_end(list_id)
      cli::cli_end()
      
      return(invisible(x))
    }
    # When print_empty is TRUE, we'll list each empty item individually below
  }
  
  # If no items to print with print_empty=FALSE, just return invisibly
  if (items_to_print == 0) {
    return(invisible(x))
  }

  # Start the list
  cli::cli_div(theme = list(ul = list(
    "margin-left" = 2 # Add indentation
  )))

  list_id <- cli::cli_ul()

  # If input is a named vector/list
  if (!is.null(names(x)) && any(names(x) != "")) {
    # For each item in the list
    for (i in seq_along(x)) {
      name <- names(x)[i]
      value <- x[[i]]

      # Skip empty values if print_empty is FALSE
      if (is_empty_value(value) && !print_empty) {
        next
      }

      # Format value properly based on its type
      if (is.null(value)) {
        # Explicitly print "NULL" for NULL values
        formatted_value <- "NULL"
      } else if (is.atomic(value) && length(value) == 1 && is.na(value)) {
        # Explicitly print "NA" for NA values
        formatted_value <- "NA"
      } else if (is.atomic(value) && length(value) == 1 && identical(value, "")) {
        # Explicitly print "<empty string>" for empty strings
        formatted_value <- "<empty string>"
      } else if (is.vector(value) && length(value) > 1) {
        # Format vectors nicely
        formatted_value <- paste(value, collapse = ", ")
      } else {
        formatted_value <- value
      }

      # Apply markup to values
      if (!is.na(name) && name != "") {
        cli::cli_li("{name}: {formatted_value}")
      } else {
        # No name, just value
        cli::cli_li("{formatted_value}")
      }
    }
  } else {
    # For unnamed vectors or lists
    for (i in seq_along(x)) {
      value <- x[[i]]

      # Skip empty values if print_empty is FALSE
      if (is_empty_value(value) && !print_empty) {
        next
      }

      # Format value properly based on its type
      if (is.null(value)) {
        # Explicitly print "NULL" for NULL values
        formatted_value <- "NULL"
      } else if (is.atomic(value) && length(value) == 1 && is.na(value)) {
        # Explicitly print "NA" for NA values
        formatted_value <- "NA"
      } else if (is.atomic(value) && length(value) == 1 && identical(value, "")) {
        # Explicitly print "<empty string>" for empty strings
        formatted_value <- "<empty string>"
      } else if (is.vector(value) && length(value) > 1) {
        # Format vectors nicely
        formatted_value <- paste(value, collapse = ", ")
      } else {
        formatted_value <- value
      }

      # Apply markup to values if specified
      cli::cli_li("{formatted_value}")
    }
  }

  # End the list
  cli::cli_end(list_id)
  cli::cli_end()

  # Return input invisibly
  invisible(x)
}
