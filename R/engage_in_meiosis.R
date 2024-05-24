#' engage_in_meiosis
#'
#' @description The creation of gametes is one of the most beautiful adaptations in all biology. Watch it unfold.
#' @param x data frame with first columns as genotypes, and last rightmost column as sex column. Genotype columns should be numeric, and sex column should be M for male or F for female.

#'
#' @return  First step of compiling the gametes, which is completed by the next function compilegamets.
#' @export
#'
#' @examples
#' library(shiny)
#' library(shinythemes)
#' library(mousebreedeR)
#' library(dqrng)
#' library(dplyr)
#' library(gtools)
#' library(ggplot2)
#' library(reshape2)
#' library(viridis)
#' library(ggpubr)
#' 
#' head(exampleexampleData) # let's take a look at our example data
#' engage_in_meiosis(exampleexampleData) # Check it out! We have begun the process of engaging in meiosis.


engage_in_meiosis <- function(x) {
  x <- add_mouse_ID(x)
  colnumerics <- as.character(lapply(x, FUN = is.numeric))
  indexcolnumerics <- which(colnumerics == T)
  indexcolchar <- which(colnumerics == F)
  gametegenotypes <- x[indexcolnumerics]
  gametemetadata <- x[indexcolchar]

  indexhomopos <- which(gametegenotypes == homopos)
  indexhomoneg <- which(gametegenotypes == homoneg)
  indexhet <- which(gametegenotypes == het)

  meiosedgenotypes <- gametegenotypes / 2
  returndf <- cbind(meiosedgenotypes, gametemetadata)
  rownames(returndf) <- returndf$mouseID
  return(returndf)
}
