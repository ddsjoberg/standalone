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
  if (!inherits(f, "factor")) f <- factor(f)

  old_levels <- levels(f)
  new_levels <-
    old_levels |>
    append(values = setdiff(c(...), old_levels), after = after)
  factor(f, levels = new_levels)
}

fct_na_value_to_level <- function(f, level = NA) {
  if (is.na(level)) {
    # Use addNA to add NA as a level
    f <- addNA(f)
  } else {
    # Convert NA to the specified level
    f[is.na(f)] <- level
  }
  return(f)
}



# nocov end
# styler: on
