% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/validation-type.R
\name{isOfType}
\alias{isOfType}
\title{Check if the provided object is of certain type}
\usage{
isOfType(object, type, nullAllowed = FALSE)
}
\arguments{
\item{object}{An object or an atomic vector or a list of objects.}

\item{type}{A single string or a vector of string representation or class of
the type that should be checked for.}

\item{nullAllowed}{Boolean flag if \code{NULL} is accepted for the \code{object}. If
\code{TRUE}, \code{NULL} always returns \code{TRUE}, otherwise \code{NULL} returns \code{FALSE}.
Default is \code{FALSE}.}
}
\value{
\code{TRUE} if the object or all objects inside the list are of the given type.
}
\description{
Check if the provided object is of certain type
}
\note{
Only the first level of the given list is considered.
}
\examples{
# checking type of a single object
df <- data.frame(x = c(1, 2, 3))
isOfType(df, "data.frame")
}
