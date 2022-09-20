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
#' fertilize()

fertilize <- function(malegametes = sperm,
                      femalegametes = eggs) {
  listofzygotes <- list()
  for (row1 in 1:nrow(sperm)) {
    for (row2 in 1:nrow(eggs)) {
      spermcolnumerics <- as.character(lapply(sperm, FUN = is.numeric))
      spermindexcolnumerics <- which(spermcolnumerics == T)
      eggscolnumerics <- as.character(lapply(eggs, FUN = is.numeric))
      eggsindexcolnumerics <- which(eggscolnumerics == T)
      spermnumeric <- sperm[spermindexcolnumerics]
      eggsnumeric <- eggs[eggsindexcolnumerics]


      spermindexcolcharacter <- which(spermcolnumerics == F)
      eggsindexcolcharacter <- which(eggscolnumerics == F)
      spermcharacter <- sperm[spermindexcolcharacter]
      eggscharacter <- eggs[eggsindexcolcharacter]

      newzygote <- spermnumeric[row1, ] + eggsnumeric[row2, ]
      momdad <-paste0(spermcharacter[row1, 'mouseID'], 'x', eggscharacter[row2, 'mouseID'])
      newzygote <- cbind(newzygote, momdad)
      listofzygotes[[length(listofzygotes) + 1]] <- newzygote

    }

  }
  listofzygotes <- bind_rows(listofzygotes)
  listofzygotes[listofzygotes == 0] <- 'homoneg'
  listofzygotes[listofzygotes == 1] <- 'het'
  listofzygotes[listofzygotes == 2] <- 'homopos'
  listofzygotes$mom <-
    unlist(lapply(strsplit(
      as.character(listofzygotes$momdad), "x"
    ), '[[', 1))
  listofzygotes$dad <-
    unlist(lapply(strsplit(
      as.character(listofzygotes$momdad), "x"
    ), '[[', 2))
  fertilizeoutput<<-listofzygotes
  return(listofzygotes)
}
