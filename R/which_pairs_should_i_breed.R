#' which_pairs_should_i_breed
#'
#' @description This function assists the user in deciding which breeding scheme will produce the result most likely to give them the mouse of their preferred genotype
#' @param x the output of the points_per_pup function
#' @param desiredvector a character vector of the genotype you want to get to
#'
#' @return the crosses that produce the highest probability of desired pup or pups that are closest to the desired genotype.
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

#' points_per_pup_output_example<-points_per_pup(x=summarize_potential_pups_output,desiredvector=desiredvec)

#' which_pairs_should_i_breed(x=points_per_pup_output_example,desiredvector=desiredvec)

which_pairs_should_i_breed<-function(x = pointsperpupoutput,desiredvector = desiredvec){
  maxpoints<-(max(x$points))
  maxpointindex<-which(x$points == maxpoints)
  maxpointsub<-subset(x,x$points == maxpoints)
  maxpercent<-(max(maxpointsub$percentchanceonepup))
  maxpercentindex<-which(maxpointsub$percentchanceonepup == maxpercent)

  crosseswithmaxpoints<-unique(maxpointsub$momdad)
  crosseswithmaxpointsmaxpercent<-unique(maxpointsub$momdad[maxpercentindex])
  print('These following cross(es) get you closest to your desired mouse, and may even give you your desired mouse:')
  print(crosseswithmaxpoints)
  print('See the table below for probabilities of desired pups.')
  print('The cross(es) that gives you the highest percentage of pups with genotypes most ideal for breeding if your ideal mouse cannot be made in one cross (preferring homopos over het) is:')
  print(crosseswithmaxpointsmaxpercent)
  print('which gives you the following percent chance of making that pup ideal for breeding (preferring homopos over het):')
  print(maxpercent)
  if (can_we_get_all_the_alleles_from_one_cross(x = fertilize_output,desiredvector) == 'notonecrossforonecopy') {
    print('You cannot get all the alleles you want into one mouse with one cross (even as a heterozygote), so you should make crosses from the list above that get as many alleles into the same pup as possible, and eventually cross those pups together.')
  }
  # return(crosseswithmaxpointsmaxpercent)
}
