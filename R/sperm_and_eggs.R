#' sperm_and_eggs
#'
#' @description Pulls out sperm and eggs from the gametes created by compilegametes.
#' @param x the outpout of compile_gametes()
#' @param sex the column name in your compilegametesoutput that refers to sex.

#'
#' @return The possible sperm and eggs you could produce.
#' @export
#'
#' @examples
#' sperm_and_eggs(x=examplecompilegametesoutput,sex='sex')

sperm_and_eggs <- function(x, sex = 'sex') {
  sperm <- subset(x, x$sex %in% male)
  eggs <- subset(x, x$sex %in% female)
  sperm <<- sperm
  eggs <<- eggs
}
