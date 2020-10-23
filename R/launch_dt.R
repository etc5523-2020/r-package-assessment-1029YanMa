#' run datatable of the shiny app
#' @export
launch_dt <- function() {
  appDir <- system.file("dtcountry", package = "cwdcovid19")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `cwdcovid19`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
