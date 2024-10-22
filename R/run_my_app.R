#' Launch the Shiny App
#'
#' This function launches the Shiny app included in this package.
#' @export
run_my_app <- function() {
  shiny::runApp(system.file("shinyApp", package = "assignment4lihsuan"))
}
