#' fertilize
#'
#' @description Watch as sperm and egg connect and create a life form from the combination of their genetic material.
#' @param malegametes the sperm from sperm_and_eggs() function 
#' @param femalegametes the eggs from sperm_and_eggs() function
#'
#' @return Dataframe of possible pups.
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
#' fertilize(malegametes = sperm,femalegametes = eggs) # create all potential pups from all possible pairings.

fertilize <- function(malegametes = sperm,
                      femalegametes = eggs) {
  listofzygotes <- list()
  for (row1 in 1:nrow(sperm)) {
    for (row2 in 1:nrow(eggs)) {
      spermcolnumerics <- as.character(lapply(sperm, FUN = is.numeric))
      spermindexcolnumerics <- which(spermcolnumerics == T)
      eggscolnumerics <- as.character(lapply(eggs, FUN = is.numeric))
      eggsindexcolnumerics <- which(eggscolnumerics == T)
      spermnumeric <- sperm[spermindexcolnumerics]
      eggsnumeric <- eggs[eggsindexcolnumerics]


      spermindexcolcharacter <- which(spermcolnumerics == F)
      eggsindexcolcharacter <- which(eggscolnumerics == F)
      spermcharacter <- sperm[spermindexcolcharacter]
      eggscharacter <- eggs[eggsindexcolcharacter]

      newzygote <- spermnumeric[row1, ] + eggsnumeric[row2, ]
      momdad <-paste0(spermcharacter[row1, 'mouseID'], 'x', eggscharacter[row2, 'mouseID'])
      newzygote <- cbind(newzygote, momdad)
      listofzygotes[[length(listofzygotes) + 1]] <- newzygote

    }

  }
  listofzygotes <- bind_rows(listofzygotes)
  listofzygotes[listofzygotes == 0] <- 'homoneg'
  listofzygotes[listofzygotes == 1] <- 'het'
  listofzygotes[listofzygotes == 2] <- 'homopos'
  listofzygotes$mom <-
    unlist(lapply(strsplit(
      as.character(listofzygotes$momdad), "x"
    ), '[[', 1))
  listofzygotes$dad <-
    unlist(lapply(strsplit(
      as.character(listofzygotes$momdad), "x"
    ), '[[', 2))
  # fertilizeoutput<<-listofzygotes
  return(listofzygotes)
}
