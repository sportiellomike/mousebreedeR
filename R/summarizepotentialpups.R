#' summarizepotentialpups
#'
#' @description Will describe frequency of all potential pups from all potential crosses.
#' @param x the output of fertilize()
#'
#' @return If a dataframe was supplied, it should also return a dataframe as well as a bar graph of the enriched pathways.
#' @export
#'
#' @examples
#' summarizepotentialpups(fertilizeoutput)


summarizepotentialpups <- function(x) {
  summaryduplicateslist <- list()
  for (q in unique(x$momdad)) {
    y <- subset(x, x$momdad == q)
    y$rowsub <- dim(y)[1]
    summarydf <-
      aggregate(list(numduplicates = rep(1, nrow(y))), y, length)
    summarydf$freqchanceonepup <-
      (summarydf$numduplicates / summarydf$rowsub)
    summarydf$percentchanceonepup <-
      (summarydf$numduplicates / summarydf$rowsub) * 100

    summarydf$notthatgenotypeonepup<-abs(1-summarydf$freqchanceonepup)
    # summarydf$notthatgenotypetwopup<-(summarydf$notthatgenotypeonepup)^2
    # summarydf$notthatgenotypethreepup<-(summarydf$notthatgenotypeonepup)^3
    # summarydf$notthatgenotypefourpup<-(summarydf$notthatgenotypeonepup)^4
    # summarydf$notthatgenotypefivepup<-(summarydf$notthatgenotypeonepup)^5
    # summarydf$notthatgenotypesixpup<-(summarydf$notthatgenotypeonepup)^6
    # summarydf$notthatgenotypesevenpup<-(summarydf$notthatgenotypeonepup)^7
    # summarydf$notthatgenotypeeightpup<-(summarydf$notthatgenotypeonepup)^8
    # summarydf$notthatgenotypeninepup<-(summarydf$notthatgenotypeonepup)^9
    # summarydf$notthatgenotypetenpup<-(summarydf$notthatgenotypeonepup)^10

    summaryduplicateslist[[length(summaryduplicateslist) + 1]] <-
      summarydf
  }
  summaryduplicateslist <- bind_rows(summaryduplicateslist)
  return(summaryduplicateslist)
}
