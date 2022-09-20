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
#' pointsperpup()

pointsperpup<-function(x,desiredvector=desiredvec){
  genecols <- c()
  for (t in colnames(x)) {
    if (isTRUE(any(x[t] == genotypevalschar))) {
      genecols <- c(genecols, t)
    }
  }
  genecolx<-x[genecols]
  genecolx[genecolx=='homopos']<-2
  genecolx[genecolx=='het']<-1
  genecolx[genecolx=='homoneg']<-0
  genecolx <- as.data.frame(lapply(genecolx,as.numeric))
  genecolx$possiblepoints<- apply(X=genecolx,MARGIN = 1,possiblepointsfromdesiredoutcome)
  genecolx$points <- apply(X=genecolx,MARGIN = 1,addpoints)
  genecolx$normalizedpoints<- 100*(genecolx$points / genecolx$possiblepoints)
  y<-cbind(genecolx,x[,!names(x)%in%genecols])
  return(y)


}
