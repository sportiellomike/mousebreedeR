#' canwemakeexactlywhatwewantwithonecross
#'
#' @description Helps the user determine if what they want is even possible to obtain with one cross.
#' @param x the result of fertilize()
#' @param desiredvector character vector of desired genotype.
#'
#' @return If a dataframe was supplied, it should also return a dataframe as well as a bar graph of the enriched pathways.
#' @export
#'
#' @examples
#' canwemakeexactlywhatwewantwithonecross()

canwemakeexactlywhatwewantwithonecross <-
  function(x = fertilizeoutput,
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
