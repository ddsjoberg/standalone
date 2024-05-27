# ---
# file: standalone-stringr.R
# last-updated: 2024-01-24
# license: https://unlicense.org
# imports: rlang
# ---
#
# This file provides a minimal shim to provide a stringr-like API on top of
# base R functions. They are not drop-in replacements but allow a similar style
# of programming.
#
# ## Changelog
#
# nocov start
# styler: off

str_trim <- function(string, side = c("both", "left", "right")) {
  side <- rlang::arg_match(side)
  trimws(x = string, which = side, whitespace = "[ \t\r\n]")
}

str_squish <- function(string, fixed = FALSE) {
  gsub(x = string, pattern = "\\s+", replacement = " ", fixed = fixed) |>
    str_trim(side = "both")
}

str_remove_all <- function(string, pattern, fixed = FALSE) {
  gsub(x = string, pattern = pattern, replacement = "", fixed = fixed)
}

str_extract <- function(string, pattern, fixed = FALSE) {
  ifelse(
    str_detect(string, pattern, fixed = fixed),
    regmatches(x = string, m = regexpr(pattern = pattern, text = string, fixed = fixed)),
    NA_character_
  )
}

str_detect <- function(string, pattern, fixed = FALSE) {
  grepl(pattern = pattern, x = string, fixed = fixed)
}

# nocov end
# styler: on
