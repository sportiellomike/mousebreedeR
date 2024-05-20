#' add_points
#'
#' @description Part of the internal functions to determine how much points a pup is worth.
#' @param x dataframe to assess points
#' @param desiredvector character vector of desired genotype.
#'
#' @return the number of points
#' @export
#'
#' @examples
#' add_points(x,desiredvector=exampledesiredvec)

add_points<-function(x,desiredvector=desiredvec){
  desiredvector[desiredvector == 'homopos']<-2
  desiredvector[desiredvector == 'het']<-1
  desiredvector[desiredvector == 'homoneg']<-0
  desiredvector<-as.numeric(desiredvector)
  length(desiredvector)
  pointsvector<-c()
  for (k in 1:length(desiredvector)) {
    if (x[k] == desiredvector[k]) {
      pointstoaddtovector<-100
      pointsvector <- c(pointsvector, pointstoaddtovector)
    }
    if (x[k]-desiredvector[k] == -1) {
      pointstoaddtovector<-50
      pointsvector <- c(pointsvector, pointstoaddtovector)
    }
    if (x[k]-desiredvector[k] == 1) {
      pointstoaddtovector<-50
      pointsvector <- c(pointsvector, pointstoaddtovector)
    }
    if (abs(x[k]-desiredvector[k]) == 2) {
      pointstoaddtovector<-0
      pointsvector <- c(pointsvector, pointstoaddtovector)

    }

  }
  sumpointsvector<-sum(pointsvector)
  return(sumpointsvector)
}
