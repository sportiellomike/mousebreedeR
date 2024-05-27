#' shiny_mousebreedeR
#'
#' @description Use the interactive shiny app to run the mousebreedeR software.
#'
#' @examples
#' shiny_mousebreedeR()
#'

shiny_mousebreedeR <- function() {
  appfile <- system.file("app.R", package = "mousebreedeR")
  shiny::runApp(appfile)
}
