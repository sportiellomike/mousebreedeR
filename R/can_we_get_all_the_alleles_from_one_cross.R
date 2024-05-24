#' can_we_get_all_the_alleles_from_one_cross
#'
#' @description This function will tell you if multiple crosses will be required to get the desired mouse.
#' @param x the output of fertilize()
#' @param desiredvector a character vector of the desired genotype
#'
#' @return If a dataframe was supplied, it should also return a dataframe as well as a bar graph of the enriched pathways.
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

#' can_we_get_all_the_alleles_from_one_cross(x=fertilize_output_example,desiredvector=desiredvec)

can_we_get_all_the_alleles_from_one_cross <-
  function(x, desiredvector = desiredvec) {
    newdesiredvector <- c()
    for (v in desiredvector) {
      ifelse(
        v %in% homopos |
          v %in% het,
        newdesiredvector <-
          c(newdesiredvector, 'pos'),
        newdesiredvector <- c(newdesiredvector, 'neg')
      )
    }
    genecols <- c()
    for (t in colnames(x)) {
      if (isTRUE(any(x[t] == genotypevalschar))) {
        genecols <- c(genecols, t)
      }
    }
    genecolx<-x[genecols]
    genecolx[genecolx == 'homopos']<-'pos'
    genecolx[genecolx == 'het']<-'pos'
    genecolx[genecolx == 'homoneg']<-'neg'
    subsettedforoutput <- genecolx
    for (q in genecols) {
      index <- which(genecols %in% q)
      subsettedforoutput <-
        subset(subsettedforoutput,
               subsettedforoutput[q] == newdesiredvector[index])
    }
    if (dim(subsettedforoutput)[1] == 0) {
      print(
        'With the genotypes you provided in your desiredvector, it is impossible to put at least one copy in every position in one cross.'
      )
      return(invisible('notonecrossforonecopy'))
    }
    if (dim(subsettedforoutput)[1] > 0) {
      print('You can make a mouse with at least one copy of each allele you want with one cross.')
      return(invisible('onecrossforonecopy'))
    }

  }
