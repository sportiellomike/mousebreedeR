#' summarize_potential_pups
#'
#' @description Will describe frequency of all potential pups from all potential crosses.
#' @param x the output of fertilize()
#'
#' @return Dataframe with probability information of each corss, organized to per pup created.
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

#' summarize_potential_pups(fertilize_output_example) # take a look at the distributions of potential pups


summarize_potential_pups <- function(x) {
  summaryduplicateslist <- list()
  for (q in unique(x$momdad)) {
    y <- subset(x, x$momdad == q)
    y$rowsub <- dim(y)[1]
    summarydf <-
      aggregate(list(numduplicates = rep(1, nrow(y))), y, length)
    summarydf$freqchanceonepup <-
      (summarydf$numduplicates / summarydf$rowsub)
    summarydf$percentchanceonepup <-
      (summarydf$numduplicates / summarydf$rowsub) * 100

    summarydf$notthatgenotypeonepup<-abs(1-summarydf$freqchanceonepup)
    # summarydf$notthatgenotypetwopup<-(summarydf$notthatgenotypeonepup)^2
    # summarydf$notthatgenotypethreepup<-(summarydf$notthatgenotypeonepup)^3
    # summarydf$notthatgenotypefourpup<-(summarydf$notthatgenotypeonepup)^4
    # summarydf$notthatgenotypefivepup<-(summarydf$notthatgenotypeonepup)^5
    # summarydf$notthatgenotypesixpup<-(summarydf$notthatgenotypeonepup)^6
    # summarydf$notthatgenotypesevenpup<-(summarydf$notthatgenotypeonepup)^7
    # summarydf$notthatgenotypeeightpup<-(summarydf$notthatgenotypeonepup)^8
    # summarydf$notthatgenotypeninepup<-(summarydf$notthatgenotypeonepup)^9
    # summarydf$notthatgenotypetenpup<-(summarydf$notthatgenotypeonepup)^10

    summaryduplicateslist[[length(summaryduplicateslist) + 1]] <-
      summarydf
  }
  summaryduplicateslist <- bind_rows(summaryduplicateslist)
  return(summaryduplicateslist)
}
