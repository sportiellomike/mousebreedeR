#' engageinmeiosis
#'
#' @description Pathway analysis of DESeq2 result or character vector of differentially expressed genes which also plots results.
#' @param x data frame with first columns as genotypes, and last rightmost column as sex column. 

#'
#' @return  First step of compiling the gametes, which is completed by the next function compilegamets.
#' @export
#'
#' @examples
#' engageinmeiosis(exampleData)


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
