#' Runs the shiny app for sambaR
#' @importFrom  shiny runApp
#' @export
runExample <- function() {
  appDir <- system.file("shiny-examples", "sambaR", 
                        package = "sambaR")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `mypackage`.", call. = FALSE)
  }
  shiny::runApp(appDir)
}
