% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/spermandeggs.R
\name{spermandeggs}
\alias{spermandeggs}
\title{spermandeggs}
\usage{
spermandeggs(x, sex = "sex")
}
\arguments{
\item{x}{the outpout of compilegametes()}

\item{sex}{the column name in your compilegametesoutput that refers to sex.}
}
\value{
The possible sperm and eggs you could produce.
}
\description{
Pulls out sperm and eggs from the gametes created by compilegametes.
}
\examples{
spermandeggs(x=examplecompilegametesoutput,sex='sex')
}
