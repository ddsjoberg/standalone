#' Copy Standalone Script
#'
#' Copy a standalone script from within this package or from the rlang
#' package into your local package.
#'
#' @param script (`string`)\cr
#'   named of the script to copy. The names follow the pattern `<pkgname>-<script_name>`.
#'   Must be one of `r shQuote(names(standalone::lst_scripts))`.
#'   See below for details.
#' @param destdir directory where the script will be saved. Default is `"./R"`
#'
#' @details
#' These are the standalone scripts available and their location.
#'
#' ```{r echo=FALSE}
#' standalone::lst_scripts |>
#'   purrr::iwalk(~cat(.y,": ", .x, "\n", sep = ""))
#' ```
#'
#' @return NULL
#' @export
#'
#' @examplesIf FALSE
#' copy_standalone_script("standalone-checks")
copy_standalone_script <- function(script, destdir = "./R") {
  # get script alias
  script_name <- rlang::arg_match(script, values = names(standalone::lst_scripts))
  destdir_and_filename <- fs::path(destdir, basename(standalone::lst_scripts[[script_name]]))

  # read script from GH
  chr_script <- readr::read_lines(file = standalone::lst_scripts[[script_name]])

  if (!fs::dir_exists(dirname(destdir))) {
    cli::cli_abort("Destination directory {.path {destdir}} does not exist.")
  }

  # check if file already exists
  if (fs::file_exists(destdir_and_filename)) {
    cli::cli_text("File {.path {destdir_and_filename}} already exists. Would you like to replace it?")
    if (interactive()) {
      response <- utils::menu(choices = c("Yes", "No"))
    }
    if (response == 2L || !interactive()) {
      return(invisible())
    }
  }

  # write script to local destination
  readr::write_lines(chr_script, file = destdir_and_filename)
}
