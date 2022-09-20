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
#' compilegametes()

compilegametes <- function(x) {
  my_list <- list()
  dfforhets <- data.frame(which(x == 0.5, arr.ind = TRUE))
  indexofmouseidsthatarehets <- dfforhets$row
  micetoberepeated <- x$mouseID[indexofmouseidsthatarehets]

  tablemicetoberepeated <- table(micetoberepeated)
  orderedmicetoberepeated <- names(tablemicetoberepeated)
  numberofrepeatesmicetoberepeated <- as.vector(tablemicetoberepeated)
  twotothenumberofrepeatesmicetoberepeated <-
    2 ^ numberofrepeatesmicetoberepeated
  times = 2
  repeateddf <-
    x[rep(x = orderedmicetoberepeated, times = twotothenumberofrepeatesmicetoberepeated), ]

  numberofmouserepeatsinrepeateddf <- repeateddf %>% count(mouseID)
  uniquemouseIDs <- unique(numberofmouserepeatsinrepeateddf$mouseID)

  for (i in uniquemouseIDs) {
    individualmousedf <- subset(repeateddf, repeateddf$mouseID == i)

    indexof.5sinindividual <- which(individualmousedf == .5)
    numberofgenesthatarehet <- rowSums(individualmousedf == 0.5)[1]

    perms <-
      permutations(
        n = 2,
        r = numberofgenesthatarehet,
        v = c(0, 1),
        repeats.allowed = T
      )
    perms <- (as.data.frame(perms))

    colswith.5 <-
      as.data.frame(which(individualmousedf == .5, arr.ind = T))
    uniquecolswith.5 <- unique(colswith.5$col)
    for (k in uniquecolswith.5) {
      for (j in 1:dim(perms)[2]) {
        whichcoltosubset <- uniquecolswith.5[j]
        individualmousedf[whichcoltosubset] <- perms[j]
        my_list[[length(my_list) + 1]] <- individualmousedf
      }

    }
  }
  my_list <- bind_rows(my_list)
  my_list[my_list == 0.5] <- NA
  my_list <- na.omit(my_list)
  my_list <- rbind(my_list, subset(x, x$mouseID %!in% my_list$mouseID))
  my_list$longID <- rownames(my_list)
  return(my_list)
}
