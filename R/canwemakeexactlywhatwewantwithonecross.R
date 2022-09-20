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
#' canwemakeexactlywhatwewantwithonecross()

canwemakeexactlywhatwewantwithonecross <-
  function(fertilizeoutput = x,
           desiredvector = desiredvec) {
    encodegenevalues()
    genotypevals <- c(homopos, homoneg, het)
    # genotypevals %in% x[1]
    # x$gene1 %in% genotypevals
    # any(x[t]==genotypevals)

    genecols <- c()

    for (t in colnames(x)) {
      if (isTRUE(any(x[t] == genotypevals))) {
        genecols <- c(genecols, t)
      }
    }
    subsettedfertoutput <- x
    # for (q in genecols) {
    #   for (v in desiredvector) {
    #     # subsetcol <- genecols[q]
    #     print(v)
    #     subsettedfertoutput<-subset(subsettedfertoutput, subsettedfertoutput[q] == v)
    #   }
    # }

    for (q in genecols) {
      index <- which(genecols %in% q)
      subsettedfertoutput <-
        subset(subsettedfertoutput,
               subsettedfertoutput[q] == desiredvector[index])
    }
    if (dim(subsettedfertoutput)[1] == 0) {
      print(
        'With the genotypees you provided, it is impossible to make the mouse you want with one cross.'
      )
      return('notonecross')
    }
    if (dim(subsettedfertoutput)[1] > 0) {
      print('You can make the mouse you want with one cross.')
      return('onecross')
    }
  }
