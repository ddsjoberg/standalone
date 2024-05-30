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

str_squish <- function(string) {
  gsub(x = string, pattern = "\\s+", replacement = " ") |>
    str_trim(side = "both")
}

str_remove <- function (string, pattern) {
  sub (x = string, pattern = pattern, replacement = "")
}

str_remove_all <- function(string, pattern) {
  gsub(x = string, pattern = pattern, replacement = "")
}

str_extract <- function(string, pattern) {
  ifelse(
    str_detect(string, pattern),
    regmatches(x = string, m = regexpr(pattern = pattern, text = string)),
    NA_character_
  )
}

str_detect <- function(string, pattern) {
  grepl(pattern = pattern, x = string)
}

str_replace <- function(string, pattern, replacement){
  sub(x = string, pattern = pattern, replacement = replacement)
}

str_replace_all <- function (string, pattern, replacement){
  gsub(x = string, pattern = pattern, replacement = replacement)
}

### TO FIX
word <- function(string, start=1L, end=start, sep = fixed(" ")) {
  args <- vctrs::vec_recycle_common(string = string, start = start,
                                    end = end)
  string <- args$string
  start <- args$start
  end <- args$end
  breaks <- str_locate_all(string, sep)
  words <- lapply(breaks, invert_match)
  len <- vapply(words, nrow, integer(1))
  neg_start <- !is.na(start) & start < 0L
  start[neg_start] <- start[neg_start] + len[neg_start] + 1L
  neg_end <- !is.na(end) & end < 0L
  end[neg_end] <- end[neg_end] + len[neg_end] + 1L
  start[start > len] <- NA
  end[end > len] <- NA
  start[start < 1L] <- 1
  starts <- mapply(function(word, loc) word[loc, "start"],
                   words, start)
  ends <- mapply(function(word, loc) word[loc, "end"], words,
                 end)
  str_sub(string, starts, ends)
}

str_sub <- function(string, start = 1L, end = 2L){
  substr(x = string, start = start, stop = end)
}

str_sub_all <- function(string, start = 1L, end = 2L){
  lapply(string, function(x) substr(x, start = start, stop = end))
}

str_pad <- function(string, width, side = c("left", "right", "both"), pad = " "){
  format_string <- switch(side,
                          right = paste0("%", width, "s"),
                          left = paste0("%-", width, "s"),
                          both = paste0("%^", width, "s")
  )
  sprintf(format_string, string)
}


# nocov end
# styler: on
