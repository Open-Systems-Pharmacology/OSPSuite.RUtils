% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/osp_print.R
\name{ospPrintItems}
\alias{ospPrintItems}
\title{Print a list of items with an optional title}
\usage{
ospPrintItems(x, title = NULL, print_empty = FALSE)
}
\arguments{
\item{x}{A vector or list}

\item{title}{Optional title to display before the list (default: NULL)}

\item{print_empty}{Whether to print empty values (NULL, NA, empty string) (default: FALSE)}
}
\value{
Invisibly returns the input object
}
\description{
Prints a list of items from a vector or list, with an optional title.
Items are indented and prefixed with a dash.
}
\examples{
# Print a simple vector with title
vector <- c("A", "B", "C")
ospPrintItems(vector, title = "Letters")

# Print a named vector with title
named_vector <- c(A = 1, B = 2, C = 3)
ospPrintItems(named_vector, title = "Letters")

# Print a list including empty values
list_with_nulls <- list("Min" = NULL, "Max" = 100, "Unit" = NA)
ospPrintItems(list_with_nulls, title = "Parameters", print_empty = TRUE)
}
\seealso{
Other print functions: 
\code{\link{ospPrintClass}()},
\code{\link{ospPrintHeader}()}
}
\concept{print functions}
