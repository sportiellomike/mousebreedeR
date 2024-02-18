#' addmouseID
#'
#' @description Adds mouseID to the original dataframe provided
#' @param x dataframe to add column to.
#'
#' @return The same data frame with mouseID column.
#' @export
#'
#' @examples
#' addmouseID(examplexampleData)


addmouseID <- function(x) {
  x$mouseID <- paste0('mouse', 1:dim(x)[1])
  return(x)
}
