#' points_per_pup
#'
#' @description Calculates how many points a potential pup would be worth according to its genotype.
#' @param x summarizepotentialpupoutput
#' @param desiredvector a vector of desired genotype.
#'
#' @return returns the dataframe which now has points per pups.
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

#' desiredvec<-c('het','het','het','het') # the genotype of your desired mouse
#' summarize_potential_pups_output<-summarize_potential_pups(fertilize_output_example) # take a look at the distributions of potential pups

#' points_per_pup(x=summarize_potential_pups_output,desiredvector=desiredvec)

points_per_pup<-function(x,desiredvector = desiredvec){
  genecols <- c()
  for (t in colnames(x)) {
    if (isTRUE(any(x[t] == genotypevalschar))) {
      genecols <- c(genecols, t)
    }
  }
  genecolx<-x[genecols]
  genecolx[genecolx == 'homopos']<-2
  genecolx[genecolx == 'het']<-1
  genecolx[genecolx == 'homoneg']<-0
  genecolx <- as.data.frame(lapply(genecolx,as.numeric))
  genecolx$possiblepoints<- apply(X = genecolx,MARGIN = 1,possible_points_from_desired_outcome)
  genecolx$points <- apply(X = genecolx,MARGIN = 1,add_points)
  genecolx$normalizedpoints<- 100*(genecolx$points / genecolx$possiblepoints)
  y<-cbind(genecolx,x[,!names(x)%in%genecols])
  return(y)


}
