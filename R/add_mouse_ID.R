#' add_mouse_ID
#'
#' @description Adds mouseID to the original dataframe provided
#' @param x dataframe to add column to.
#'
#' @return The same data frame with mouseID column.
#' @export
#'
#' @examples
#' add_mouse_ID(exampleexampleData)


add_mouse_ID <- function(x) {
  x$mouseID <- paste0('mouse', 1:dim(x)[1])
  return(x)
}
