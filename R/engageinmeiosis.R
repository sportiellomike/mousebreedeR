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
#' engageinmeiosis()


engageinmeiosis <- function(x) {
  x <- addmouseID(x)
  colnumerics <- as.character(lapply(x, FUN = is.numeric))
  indexcolnumerics <- which(colnumerics == T)
  indexcolchar <- which(colnumerics == F)
  gametegenotypes <- x[indexcolnumerics]
  gametemetadata <- x[indexcolchar]

  indexhomopos <- which(gametegenotypes == homopos)
  indexhomoneg <- which(gametegenotypes == homoneg)
  indexhet <- which(gametegenotypes == het)

  meiosedgenotypes <- gametegenotypes / 2
  returndf <- cbind(meiosedgenotypes, gametemetadata)
  rownames(returndf) <- returndf$mouseID
  return(returndf)
}
