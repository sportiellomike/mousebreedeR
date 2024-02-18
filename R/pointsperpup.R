#' pointsperpup
#'
#' @description Calculates how many points a potential pup would be worth according to its genotype.
#' @param x summarizepotentialpupoutput
#' @param desiredvector a vector of desired genotype.
#'
#' @return returns the dataframe which now has points per pups.
#' @export
#'
#' @examples
#' pointsperpup(x=examplesummarizepotentialpupoutput,desiredvector=exampledesiredvec)

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
