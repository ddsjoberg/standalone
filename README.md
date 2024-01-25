
# standalone

<!-- badges: start -->
[![R-CMD-check](https://github.com/ddsjoberg/standalone/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ddsjoberg/standalone/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of standalone is to provide standalone scripts that are useful for the
development of R packages. While you need to install this package to use the
interface, the standalone package does not need to be a dependency of the 
package you are developing.

## Installation

You can install **standalone** from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ddsjoberg/standalone")
```

## Example

To copy a standalone script with useful checks against user inputs, run:

``` r
standalone::copy_standalone_script("standalone-checks")
```

