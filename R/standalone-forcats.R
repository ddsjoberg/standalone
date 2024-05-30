# ---
# file: standalone-forcats.R
# last-updated: 2024-05-04
# license: https://unlicense.org
# imports:
# ---
#
# This file provides a minimal shim to provide a forcats-like API on top of
# base R functions. They are not drop-in replacements but allow a similar style
# of programming.
#
# ## Changelog
#
# nocov start
# styler: off

fct_infreq <- function(f, ordered = NA) {
  # reorder by frequency
  factor(
    f,
    levels = table(f) |> sort(decreasing = TRUE) |> names(),
    ordered = ifelse(is.na(ordered), is.ordered(f), ordered)
  )
}

fct_inorder <- function(f, ordered = NA) {
  factor(
    f,
    levels = stats::na.omit(unique(f)) |> union(levels(f)),
    ordered = ifelse(is.na(ordered), is.ordered(f), ordered)
  )
}

fct_rev <- function(f) {
  if (!inherits(f, "factor")) f <- factor(f)

  factor(
    f,
    levels = rev(levels(f)),
    ordered = is.ordered(f)
  )
}

fct_expand <- function(factor, ...) {
    new_levels_list <- list(...)
    new_levels <- unlist(new_levels_list, use.names = FALSE)
    expanded_levels <- unique(c(levels(factor), new_levels))
    levels(factor) <- expanded_levels
    return(factor)
  }

fct_na_value_to_level <- function(factor, new_level = NA) {
  f <- fct_expand(factor, new_level)
  new_levels <- levels(f)
  new_levels[is.na(new_levels)] <- new_level
  attr(f, "levels") <- new_levels
  f
}
# nocov end
# styler: on
