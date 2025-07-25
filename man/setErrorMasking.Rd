% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utilities-logger.R
\name{setErrorMasking}
\alias{setErrorMasking}
\title{setErrorMasking}
\usage{
setErrorMasking(patterns)
}
\arguments{
\item{patterns}{Character patterns to identify with \code{grepl()} when masking messages}
}
\description{
Mask error trace messages
}
\examples{
\dontrun{
setErrorMasking(c("tryCatch", "withCallingHandlers"))
}
}
\keyword{logging}
