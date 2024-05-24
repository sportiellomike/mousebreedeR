#' add_mouse_ID
#'
#' @description Adds mouseID to the original dataframe provided
#' @param x dataframe to add column to.
#'
#' @return The same data frame with mouseID column.
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
#' head(exampleexampleData) # let's take a look at some example data before we run add_mouse_ID()
#' add_mouse_ID(exampleexampleData) # check it out! We have a new column!


add_mouse_ID <- function(x) {
  x$mouseID <- paste0('mouse', 1:dim(x)[1])
  return(x)
}
