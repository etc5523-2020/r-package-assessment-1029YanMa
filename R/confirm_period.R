#' run the confirmd cases plot of the shiny app
#' @export
launch_confirm_period <- function() {
  appDir <- system.file("confirm_period", package = "cwdcovid19")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `cwdcovid19`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
