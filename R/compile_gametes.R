#' compile_gametes
#'
#' @description This finishes the create of the gametes.
#' @param x the output of engage_in_meiosis()
#'
#' @return a dataframe of gametes
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
#' engage_in_meiosis_output_example<-engage_in_meiosis(exampleexampleData) # Check it out! We can look the gene makeup of eggs and sperm now
#' compile_gametes(engage_in_meiosis_output_example) # Meiosis step completed. Here are all the possible gametes from our breeder mice.

compile_gametes <- function(x) {
  my_list <- list()
  dfforhets <- data.frame(which(x == 0.5, arr.ind = TRUE))
  indexofmouseidsthatarehets <- dfforhets$row
  micetoberepeated <- x$mouseID[indexofmouseidsthatarehets]

  tablemicetoberepeated <- table(micetoberepeated)
  orderedmicetoberepeated <- names(tablemicetoberepeated)
  numberofrepeatesmicetoberepeated <- as.vector(tablemicetoberepeated)
  twotothenumberofrepeatesmicetoberepeated <-
    2 ^ numberofrepeatesmicetoberepeated
  times = 2
  repeateddf <-
    x[rep(x = orderedmicetoberepeated, times = twotothenumberofrepeatesmicetoberepeated), ]

  numberofmouserepeatsinrepeateddf <- repeateddf %>% count(mouseID)
  uniquemouseIDs <- unique(numberofmouserepeatsinrepeateddf$mouseID)

  for (i in uniquemouseIDs) {
    individualmousedf <- subset(repeateddf, repeateddf$mouseID == i)

    indexof.5sinindividual <- which(individualmousedf == .5)
    numberofgenesthatarehet <- rowSums(individualmousedf == 0.5)[1]

    perms <-
      permutations(
        n = 2,
        r = numberofgenesthatarehet,
        v = c(0, 1),
        repeats.allowed = T
      )
    perms <- (as.data.frame(perms))

    colswith.5 <-
      as.data.frame(which(individualmousedf == .5, arr.ind = T))
    uniquecolswith.5 <- unique(colswith.5$col)
    for (k in uniquecolswith.5) {
      for (j in 1:dim(perms)[2]) {
        whichcoltosubset <- uniquecolswith.5[j]
        individualmousedf[whichcoltosubset] <- perms[j]
        my_list[[length(my_list) + 1]] <- individualmousedf
      }

    }
  }
  my_list <- bind_rows(my_list)
  my_list[my_list == 0.5] <- NA
  my_list <- na.omit(my_list)
  my_list <- rbind(my_list, subset(x, x$mouseID %notin% my_list$mouseID))
  my_list$longID <- rownames(my_list)
  return(my_list)
}
