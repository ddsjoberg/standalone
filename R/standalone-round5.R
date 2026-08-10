# ---
# repo: insightsengineering/standalone
# file: standalone-round5.R
# last-updated: 2026-02-26
# license: https://unlicense.org
# imports:
# ---
#
# This file provides the the round5() function from the cards package to allow
# use without full dependency on the cards package (or the janitor package that
# inspired the cards::round5() function.
#
# ## Changelog
#
#
# nocov start
# styler: off

round5 <- function(x, digits = 0) {
  trunc(abs(x) * 10^digits + 0.5 + sqrt(.Machine$double.eps)) /
    10^digits *
    sign(as.numeric(x))
}

# nocov end
# styler: on
