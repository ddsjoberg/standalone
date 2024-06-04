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

fct_expand <- function(f, ..., after = Inf) {
  f <- levels(f) |> append(values = c(...), after = after)
  return(f)
}

fct_na_value_to_level <- function(f, level = NA) {
  # Convert NA level to a character "NA" if it is NA, otherwise ensure level is a character
  level_char <- if (is.na(level)) "NA" else as.character(level)

  if (!level_char %in% levels(f)) {
    # Add the new level to the factor's levels
    levels(f) <- c(levels(f), level_char)
  }
    inds <- is.na(f)
  if (any(inds)) {
    f[inds] <- level_char
  }

  return(factor(f, levels = levels(f)))
}



# nocov end
# styler: on
