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
#' summarizefertilization()


summarizefertilization <- function(x) {
  summarylist <- list()
  momdadcol <- which(colnames(x) == 'momdad')
  lastgenecol <- momdadcol - 1
  for (q in unique(x$momdad)) {
    y <- subset(x, x$momdad == q)
    for (i in 1:lastgenecol) {
      tableydat <- table(y[i])
      tableydat<-as.list(tableydat)
      tableydat$gene <- colnames(y[i])
      tableydat$momdad <- q
      summarylist[[length(summarylist) + 1]] <- tableydat
    }
  }
  summarylist <- bind_rows(summarylist)
  numericcolsindex <- which(sapply(summarylist, is.numeric))
  charactercolsindex <- which(sapply(summarylist, is.character))
  numericcols <- summarylist[numericcolsindex]

  # replace(numericcols,is.na(numericcols),0)
  numericcols[is.na(numericcols)] = 0
  numericcols$rowsum <- rowSums(numericcols)
  numericcols$freqhomoneg <- numericcols$homoneg / numericcols$rowsum
  numericcols$freqhet <- numericcols$het / numericcols$rowsum
  numericcols$freqhomopos <- numericcols$homopos / numericcols$rowsum
  numericcols$percenthomoneg <- (numericcols$homoneg / numericcols$rowsum)*100
  numericcols$percenthet <- (numericcols$het / numericcols$rowsum)*100
  numericcols$percenthomopos <- (numericcols$homopos / numericcols$rowsum)*100

  charactercols <- summarylist[charactercolsindex]
  summarylist <- cbind(numericcols, charactercols)


  return(summarylist)

}
