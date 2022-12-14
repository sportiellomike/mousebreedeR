% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/canwemakeexactlywhatwewantwithonecross.R
\name{canwemakeexactlywhatwewantwithonecross}
\alias{canwemakeexactlywhatwewantwithonecross}
\title{canwemakeexactlywhatwewantwithonecross}
\usage{
canwemakeexactlywhatwewantwithonecross(
  x = fertilizeoutput,
  desiredvector = desiredvec
)
}
\arguments{
\item{x}{the result of fertilize()}

\item{desiredvector}{character vector of desired genotype.}
}
\value{
If a dataframe was supplied, it should also return a dataframe as well as a bar graph of the enriched pathways.
}
\description{
Helps the user determine if what they want is even possible to obtain with one cross.
}
\examples{
canwemakeexactlywhatwewantwithonecross()
}
