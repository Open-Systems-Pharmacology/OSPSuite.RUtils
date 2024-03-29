% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utilities.R
\name{flattenList}
\alias{flattenList}
\title{Flatten a list to an atomic vector of desired type}
\usage{
flattenList(x, type)
}
\arguments{
\item{x}{A list or an atomic vector. If the latter, no change will be made.}

\item{type}{Type of atomic vector to be returned.}
}
\value{
An atomic vector of desired type.
}
\description{
Flatten a list to an atomic vector of desired type
}
\details{
The \code{type} argument will decide which variant from \code{purrr::flatten()} family
is used to flatten the list.
}
\examples{

flattenList(list(1, 2, 3, NA), type = "numeric")
flattenList(list(TRUE, FALSE, NA), type = "integer")

}
