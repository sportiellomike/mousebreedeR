#' fluximplied
#'
#' @description Pathway analysis of DESeq2 result or character vector of differentially expressed genes which also plots results.
#' @param inputdat what you are using as your input data, either a dataframe with genes as the rownames, a column for LFC, and a column for padj values
#' @param species either mus or hsa
#' @param geneformat either ENTREZ or symbol
#' @param inputformat either df or vector
#' @param padjcolname the name of the column in your dataframe, if applicable, that stores the padj values
#' @param pcutoff the alpha threshold for your padjustadjust
#'
#' @return If a dataframe was supplied, it should also return a dataframe as well as a bar graph of the enriched pathways.
#' @export
#'
#' @examples
#' canwegetalltheallelesfromonecross()

canwegetalltheallelesfromonecross <-
  function(x, desiredvector = desiredvec) {
    encodegenevalues()
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
      if (isTRUE(any(x[t] == genotypevals))) {
        genecols <- c(genecols, t)
      }
    }
    genecolx<-x[genecols]
    genecolx[genecolx=='homopos']<-'pos'
    genecolx[genecolx=='het']<-'pos'
    genecolx[genecolx=='homoneg']<-'neg'
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
      return('notonecrossforonecopy')
    }
    if (dim(subsettedforoutput)[1] > 0) {
      print('You can make a mouse with at least one copy of each allele you want with one cross.')
      return('onecrossforonecopy')
    }

  }
