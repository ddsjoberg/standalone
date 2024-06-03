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

str_remove <- function (string, pattern, fixed = FALSE) {
  sub (x = string, pattern = pattern, replacement = "", fixed = fixed)
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

str_replace <- function(string, pattern, replacement, fixed = FALSE){
  sub(x = string, pattern = pattern, replacement = replacement, fixed = fixed)
}

str_replace_all <- function (string, pattern, replacement, fixed = FALSE){
  gsub(x = string, pattern = pattern, replacement = replacement, fixed = fixed)
}

word <- function(string, start, end = start, sep = fixed(" ") , fixed = FALSE) {
  words <- strsplit(string, "\\s+")[[1]]
  if (start < 1 || end > length(words) || start > end) {
    return(NA)
  } else {
    extracted_words <- words[start:end]
    return(paste(extracted_words, collapse = " "))
  }
}

str_sub <- function(string, start = 1L, end = -1L){
  str_length <- nchar(string)

  # Adjust start and end indices for negative values
  if (start < 0) {
    start <- str_length + start + 1
  }
  if (end < 0) {
    end <- str_length + end + 1
  }

  substr(x = string, start = start, stop = end)
}

str_sub_all <- function(string, start = 1L, end = -1L){
  lapply(string, function(x) substr(x, start = start, stop = end))
}

str_pad <- function(string, width, side = c("left", "right", "both"), pad = " ", use_width = TRUE){
    side <- match.arg(side, c("left", "right", "both"))

    format_string <- ifelse(side == "right", paste0("%-", width, "s"),
                            ifelse(side == "left", paste0("%", width, "s"),
                                   paste0("%^", width, "s")))

    padded_strings <- mapply(function(fmt, str) {
      sprintf(fmt, str)
    }, format_string, string, SIMPLIFY = TRUE)

    return(unname(padded_strings))
}

# nocov end
# styler: on
