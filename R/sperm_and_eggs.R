#' sperm_and_eggs
#'
#' @description Pulls out sperm and eggs from the gametes created by compilegametes.
#' @param x the outpout of compile_gametes()
#' @param sex the column name in your compilegametesoutput that refers to sex.

#'
#' @return The possible sperm and eggs you could produce.
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

#' head(exampleexampleData) # let's take a look at our example data
#' engage_in_meiosis_output_example<-engage_in_meiosis(exampleexampleData) # Check it out! We can look the gene makeup of eggs and sperm now
#' compile_gametes_output_example<-compile_gametes(engage_in_meiosis_output_example) # Meiosis step completed. Here are all the possible gametes from our breeder mice.
#' sperm_and_eggs(x=compile_gametes_output_example,sex='sex') # Saves the outputs of which gametes are sperm, and which are eggs.

sperm_and_eggs <- function(x, sex = 'sex') {
  sperm <- subset(x, x$sex %in% male)
  eggs <- subset(x, x$sex %in% female)
  sperm <<- sperm
  eggs <<- eggs
}
