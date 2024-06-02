
# standalone

<!-- badges: start -->
[![R-CMD-check](https://github.com/ddsjoberg/standalone/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ddsjoberg/standalone/actions/workflows/R-CMD-check.yaml)
[![Codecov test coverage](https://codecov.io/gh/ddsjoberg/standalone/branch/main/graph/badge.svg)](https://app.codecov.io/gh/ddsjoberg/standalone?branch=main)
<!-- badges: end -->

The goal of standalone is to provide standalone scripts that are useful for the development of R packages.
The standalone package **will not** be a dependency of the package you are developing.
You don't even need to install it to use the standalone scripts housed in this repo.


## Example

To copy a standalone script with useful checks against user inputs, run:

``` r
usethis::use_standalone("ddsjoberg/standalone", file = "checks")
```

