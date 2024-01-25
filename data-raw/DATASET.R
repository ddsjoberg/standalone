## code to prepare `DATASET` dataset goes here
lst_scripts <-
  list(
    # FROM THE standalone PACKAGE
    "standalone-checks" = "https://raw.githubusercontent.com/ddsjoberg/standalone/main/R/standalone-checks.R",
    "standalone-stringr" = "https://raw.githubusercontent.com/ddsjoberg/standalone/main/R/standalone-stringr.R",
    "standalone-forcats" = "https://raw.githubusercontent.com/ddsjoberg/standalone/main/R/standalone-forcats.R",

    # FROM THE rlang PACKAGE
    "rlang-purrr" = "https://raw.githubusercontent.com/r-lib/rlang/main/R/standalone-purrr.R",
    "rlang-cli" = "https://raw.githubusercontent.com/r-lib/rlang/main/R/standalone-cli.R",
    "rlang-downstream-deps" = "https://raw.githubusercontent.com/r-lib/rlang/main/R/standalone-downstream-deps.R",
    "rlang-lazyeval" = "https://raw.githubusercontent.com/r-lib/rlang/main/R/standalone-lazyeval.R",
    "rlang-lifecycle" = "https://raw.githubusercontent.com/r-lib/rlang/main/R/standalone-lifecycle.R",
    "rlang-linked-version" = "https://raw.githubusercontent.com/r-lib/rlang/main/R/standalone-linked-version.R",
    "rlang-obj-type" = "https://raw.githubusercontent.com/r-lib/rlang/main/R/standalone-obj-type.R",
    "rlang-s3-register" = "https://raw.githubusercontent.com/r-lib/rlang/main/R/standalone-s3-register.R",
    "rlang-sizes" = "https://raw.githubusercontent.com/r-lib/rlang/main/R/standalone-sizes.R",
    "rlang-types-check" = "https://raw.githubusercontent.com/r-lib/rlang/main/R/standalone-types-check.R",
    "rlang-vctrs" = "https://raw.githubusercontent.com/r-lib/rlang/main/R/standalone-vctrs.R",
    "rlang-zeallot" = "https://raw.githubusercontent.com/r-lib/rlang/main/R/standalone-zeallot.R"
  )

usethis::use_data(lst_scripts, overwrite = TRUE)
