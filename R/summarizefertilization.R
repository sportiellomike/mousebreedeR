#' summarizefertilization
#'
#' @description summarizes the overall picture of fertilization.
#' @param x the output of fertilize()
#'
#' @return If a dataframe was supplied, it should also return a dataframe as well as a bar graph of the enriched pathways.
#' @export
#'
#' @examples
#' summarizefertilization(fertilizeoutput)


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
