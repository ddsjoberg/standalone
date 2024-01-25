## code to prepare `DATASET` dataset goes here
lst_scripts <-
  list(
    "standalone-checks" = "https://raw.githubusercontent.com/ddsjoberg/standalone/main/R/standalone-checks.R",
    "standalone-stringr" = "https://raw.githubusercontent.com/ddsjoberg/standalone/main/R/standalone-stringr.R",
    "standalone-forcats" = "https://raw.githubusercontent.com/ddsjoberg/standalone/main/R/standalone-forcats.R",
    "rlang-purrr" = "https://raw.githubusercontent.com/r-lib/rlang/main/R/standalone-purrr.R"
  )

usethis::use_data(lst_scripts, overwrite = TRUE)
