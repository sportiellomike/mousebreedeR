#' summarize_fertilization
#'
#' @description summarizes the overall picture of fertilization.
#' @param x the output of fertilize()
#'
#' @return Dataframe with columns to summarize the probabalistic outcome of fertilizations, organized per cross and per locus.
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
#' sperm_and_eggs_output_example<-sperm_and_eggs(x=compile_gametes_output_example,sex='sex') # Saves the outputs of which gametes are sperm, and which are eggs.
#' fertilize_output_example<-fertilize(malegametes = sperm,femalegametes = eggs) # create all potential pups from all possible pairings.

#' summarize_fertilization(fertilize_output_example) # look at pups per gene and per pairing


summarize_fertilization <- function(x) {
  summarylist <- list()
  momdadcol <- which(colnames(x) == 'momdad')
  lastgenecol <- momdadcol - 1
  for (q in unique(x$momdad)) {
    y <- subset(x, x$momdad == q)
    for (i in 1:lastgenecol) {
      tableydat <- table(y[i])
      tableydat<-as.list(tableydat)
      tableydat$gene <- colnames(y[i])
      tableydat$momdad <- q
      summarylist[[length(summarylist) + 1]] <- tableydat
    }
  }
  summarylist <- bind_rows(summarylist)
  numericcolsindex <- which(sapply(summarylist, is.numeric))
  charactercolsindex <- which(sapply(summarylist, is.character))
  numericcols <- summarylist[numericcolsindex]

  # replace(numericcols,is.na(numericcols),0)
  numericcols[is.na(numericcols)] = 0
  numericcols$rowsum <- rowSums(numericcols)
  numericcols$freqhomoneg <- numericcols$homoneg / numericcols$rowsum
  numericcols$freqhet <- numericcols$het / numericcols$rowsum
  numericcols$freqhomopos <- numericcols$homopos / numericcols$rowsum
  numericcols$percenthomoneg <- (numericcols$homoneg / numericcols$rowsum)*100
  numericcols$percenthet <- (numericcols$het / numericcols$rowsum)*100
  numericcols$percenthomopos <- (numericcols$homopos / numericcols$rowsum)*100

  charactercols <- summarylist[charactercolsindex]
  summarylist <- cbind(numericcols, charactercols)


  return(summarylist)

}
