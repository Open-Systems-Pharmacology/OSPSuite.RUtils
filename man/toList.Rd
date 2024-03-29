% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utilities.R
\name{toList}
\alias{toList}
\title{Make sure the object is a list}
\usage{
toList(object)
}
\arguments{
\item{object}{Object to be converted to a list.}
}
\value{
If \code{is.list(object) == TRUE}, returns the \code{object}; otherwise, \code{list(object)}.
}
\description{
Make sure the object is a list
}
\examples{
toList(list("a" = 1, "b" = 2))
toList(c("a" = 1, "b" = 2))

}
