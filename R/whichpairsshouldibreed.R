#' whichpairsshouldibreed
#'
#' @description This function assists the user in deciding which breeding scheme will produce the result most likely to give them the mouse of their preferred genotype
#' @param x the output of the pointsperpup function
#' @param desiredvector a character vector of the genotype you want to get to
#'
#' @return the crosses that produce the highest probability of desired pup or pups that are closest to the desired genotype.
#' @export
#'
#' @examples
#' whichpairsshouldibreed(x=examplepointsperpupoutput,desiredvector=exampledesiredvec)

whichpairsshouldibreed<-function(x=pointsperpupoutput,desiredvector=desiredvec){
  maxpoints<-(max(x$points))
  maxpointindex<-which(x$points==maxpoints)
  maxpointsub<-subset(x,x$points==maxpoints)
  maxpercent<-(max(maxpointsub$percentchanceonepup))
  maxpercentindex<-which(maxpointsub$percentchanceonepup==maxpercent)

  crosseswithmaxpoints<-unique(maxpointsub$momdad)
  crosseswithmaxpointsmaxpercent<-unique(maxpointsub$momdad[maxpercentindex])
  print('These following cross(es) get you closest to your desired mouse, and may even give you your desired mouse:')
  print(crosseswithmaxpoints)
  print('The cross(es) that gives you the highest percentage of pups with that closest genotype is:')
  print(crosseswithmaxpointsmaxpercent)
  print('which gives you the following percent chance of making that pup:')
  print(maxpercent)
  if (canwegetalltheallelesfromonecross(x = fertilizeoutput,desiredvector)=='notonecrossforonecopy') {
    print('You cannot get all the alleles you want into one mouse with one cross (even as a heterozygote), so you should make crosses from the list above that get as many alleles into the same pup as possible, and eventually cross those pups together.')
  }
  return(crosseswithmaxpointsmaxpercent)
}
