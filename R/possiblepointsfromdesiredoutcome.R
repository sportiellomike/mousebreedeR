#' possiblepointsfromdesiredoutcome
#'
#' @description Calculates how many points any pup could be worth based on how many points your desired pup could be worth.
#' @param desiredvector character vector of desired genotype.
#'
#' @return The number of possible points your desired pup is worth.
#' @export
#'
#' @examples
#' possiblepointsfromdesiredoutcome(desiredvector = desiredvec)

possiblepointsfromdesiredoutcome<-function(desiredvector = desiredvec){
  possiblepoints<-length(desiredvector)*100
  return(possiblepoints)
}
