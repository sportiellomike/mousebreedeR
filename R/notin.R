#' %notin%
#'
#' @description Negates %in%
#'
#' @return negated %in%
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


#' c(3,4,5) %in% c(4,5,6)
#' c(3,4,5) %notin% c(4,5,6)

`%notin%` <- Negate(`%in%`)
