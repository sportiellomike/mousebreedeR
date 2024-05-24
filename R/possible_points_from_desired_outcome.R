#' possible_points_from_desired_outcome
#'
#' @description Calculates how many points any pup could be worth based on how many points your desired pup could be worth.
#' @param desiredvector character vector of desired genotype.
#'
#' @return The number of possible points your desired pup is worth.
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

#' desiredvec<-c('het','het','het','het') # the genotype of your desired mouse
#' possible_points_from_desired_outcome(desiredvector = exampledesiredvec) # to use in scoring system

possible_points_from_desired_outcome<-function(desiredvector = desiredvec){
  possiblepoints<-length(desiredvector)*100
  return(possiblepoints)
}
