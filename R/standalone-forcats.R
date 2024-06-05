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
  new_levels <- as.character(c(...))

  # Determine the unique new levels not already in old_levels
  unique_new_levels <- setdiff(new_levels, old_levels)

  # Adjust the handling of 'after' to allow adding at the beginning
  if (is.infinite(after) || after >= length(old_levels)) {
    # Append new levels at the end if 'after' is Inf or beyond the last level
    final_levels <- c(old_levels, unique_new_levels)
  } else if (after == 0) {
    # Add new levels at the beginning if 'after' is 0
    final_levels <- c(unique_new_levels, old_levels)
  } else {
    # Insert new levels after the specified position
    if(after < 0) {
      stop("The 'after' parameter is out of bounds. It must be at least 0.")
    }
    final_levels <- append(old_levels, unique_new_levels, after = after)
  }

  # Return the factor with updated levels
  return(factor(f, levels = final_levels))
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
