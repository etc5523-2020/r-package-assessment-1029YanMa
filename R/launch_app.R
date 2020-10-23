#' run shiny app
#' @export
launch_app <- function() {
  appDir <- system.file("app", package = "cwdcovid19")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `cwdcovid19`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
