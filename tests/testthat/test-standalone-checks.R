test_that("check functions work", {
  expect_silent(check_class("mystring", "character"))

  expect_error(
    check_class("mystring", c("numeric", "logical")),
    'The `"mystring"` argument must be class <numeric/logical>, not a string.'
  )

  expect_error(
    check_class("mystring", c("numeric", "logical"), allow_empty = TRUE),
    'The `"mystring"` argument must be class <numeric/logical> or empty, not a string.'
  )

  myfunc <- function(x) {
    set_cli_abort_call()
    check_class(x, "character", call = get_cli_abort_call())
  }
  expect_snapshot(myfunc(1), error = TRUE)

  # check_data_frame()
  expect_silent(check_data_frame(data.frame()))

  expect_error(
    check_data_frame("mystring"),
    'The `"mystring"` argument must be class <data.frame>, not a string.'
  )

  myfunc <- function(x) {
    set_cli_abort_call()
    check_data_frame(x, call = get_cli_abort_call())
  }
  expect_snapshot(myfunc(1), error = TRUE)

  # check_logical()
  expect_silent(check_logical(c(TRUE, FALSE, TRUE, TRUE)))

  expect_error(
    check_logical("mystring"),
    'The `"mystring"` argument must be class <logical>, not a string.'
  )

  myfunc <- function(x) {
    set_cli_abort_call()
    check_logical(x, call = get_cli_abort_call())
  }
  expect_snapshot(myfunc(1), error = TRUE)

  # check_scalar_logical()
  expect_silent(check_scalar_logical(FALSE))

  expect_error(
    check_scalar_logical(1),
    "The `1` argument must be a scalar with class <logical>, not a number."
  )

  myfunc <- function(x) {
    set_cli_abort_call()
    check_scalar_logical(x, call = get_cli_abort_call())
  }
  expect_snapshot(myfunc(c(TRUE, FALSE)), error = TRUE)

  # check_string()
  expect_silent(check_string("mystring"))

  expect_error(
    check_string(1),
    "The `1` argument must be a string, not a number."
  )

  myfunc <- function(x) {
    set_cli_abort_call()
    check_string(x, call = get_cli_abort_call())
  }
  expect_snapshot(myfunc(1), error = TRUE)

  # check_not_missing()
  fun_missing_nms <- function(noval) {
    check_not_missing(noval)
  }

  expect_silent(fun_missing_nms(noval = 1))

  myfunc <- function(x) {
    set_cli_abort_call()
    check_not_missing(x, call = get_cli_abort_call())
  }
  expect_snapshot(myfunc(), error = TRUE)

  # check_length()
  expect_silent(check_length(1:5, 5))

  expect_error(
    check_length(1:10, 5),
    "The `1:10` argument must be length 5."
  )

  myfunc <- function(x, l) {
    set_cli_abort_call()
    check_length(x, l, call = get_cli_abort_call())
  }
  expect_snapshot(myfunc(1:10, 5), error = TRUE)

  # check_scalar()
  expect_silent(check_scalar("mystring"))

  expect_error(
    check_scalar(c(1, 10)),
    "The `c(1, 10)` argument must be length 1.",
    fixed = TRUE
  )

  myfunc <- function(x) {
    set_cli_abort_call()
    check_scalar(x, call = get_cli_abort_call())
  }
  expect_snapshot(myfunc(c(TRUE, FALSE)), error = TRUE)

  # check_range()
  expect_silent(check_range(5, c(1, 20)))
  expect_silent(check_range(c(2, 2.47, 5), c(1, 5), include_bounds = c(FALSE, TRUE)))

  expect_error(
    check_range(5, c(0, 1)),
    "The `5` argument must be in the interval `(0, 1)`.",
    fixed = TRUE
  )
  expect_error(
    check_range(c(4, 5), c(1, 5), include_bounds = c(TRUE, FALSE)),
    "The `c(4, 5)` argument must be in the interval `[1, 5)`.",
    fixed = TRUE
  )

  myfunc <- function(x, r) {
    set_cli_abort_call()
    check_range(x, r, call = get_cli_abort_call())
  }
  expect_snapshot(myfunc(1, c(0, 1)), error = TRUE)

  # check_scalar_range()
  expect_silent(check_scalar_range(5, c(1, 20)))
  expect_silent(check_scalar_range(5, c(1, 5), include_bounds = c(FALSE, TRUE)))

  expect_error(
    check_scalar_range(5, c(0, 1)),
    "The `5` argument must be in the interval `(0, 1)` and length 1.",
    fixed = TRUE
  )
  expect_error(
    check_scalar_range(c(4, 5), c(1, 5), include_bounds = c(TRUE, FALSE)),
    'The `c(4, 5)` argument must be in the interval `[1, 5)` and length 1.',
    fixed = TRUE
  )

  myfunc <- function(x, r) {
    set_cli_abort_call()
    check_scalar_range(x, r, call = get_cli_abort_call())
  }
  expect_snapshot(myfunc(1, c(0, 1)), error = TRUE)

  # check_binary()
  expect_silent(check_binary(c(TRUE, FALSE, FALSE)))
  expect_silent(check_binary(c(1, 0, 0, 1)))

  expect_error(
    check_binary(c(1, 5)),
    "Expecting `c(1, 5)` to be either <logical> or <numeric/integer> coded as 0 and 1.",
    fixed = TRUE
  )

  myfunc <- function(x) {
    set_cli_abort_call()
    check_binary(x, call = get_cli_abort_call())
  }
  expect_snapshot(myfunc(c(0, 1, 2)), error = TRUE)

  # check_formula_list_selector()
  expect_silent(check_formula_list_selector(list(a = 1)))
  expect_silent(check_formula_list_selector(list(x ~ 1, y + 1 ~ 3)))
  expect_silent(check_formula_list_selector(x ~ y + 1))

  expect_error(
    check_formula_list_selector(list(1)),
    "The `list(1)` argument must be a named list, list of formulas, or a single formula.",
    fixed = TRUE
  )

  myfunc <- function(x) {
    set_cli_abort_call()
    check_formula_list_selector(x, call = get_cli_abort_call())
  }
  expect_snapshot(myfunc(1), error = TRUE)

  # check_n_levels()
  myfunc <- function(x) {
    set_cli_abort_call()
    check_n_levels(x, 2L)
  }
  expect_silent(myfunc(sample(c("a", "b"), size = 10, replace = TRUE)))
  expect_snapshot(myfunc(letters), error = TRUE)

  # check_integerish()
  myfunc <- function(x) {
    set_cli_abort_call()
    check_integerish(x)
  }
  expect_silent(myfunc(c(1, 2, 6)))
  expect_snapshot(myfunc(pi), error = TRUE)

  # check_scalar_integerish()
  myfunc <- function(x) {
    set_cli_abort_call()
    check_scalar_integerish(x)
  }
  expect_silent(myfunc(1))
  expect_snapshot(myfunc(pi), error = TRUE)

  # check_no_na_factor_levels()
  myfunc <- function(x) {
    set_cli_abort_call()
    check_no_na_factor_levels(x)
  }
  my_iris <- iris
  my_iris[c(4,7,10,15), "Species"] <- NA
  my_iris$Species <- factor(my_iris$Species, exclude = NULL)

  expect_silent(myfunc(iris))
  expect_snapshot(myfunc(my_iris), error = TRUE)

  # check_factor_has_levels()
  myfunc <- function(x) {
    set_cli_abort_call()
    check_factor_has_levels(x)
  }
  my_iris <- iris
  my_iris$bad_fct_col <- factor(NA)

  expect_silent(myfunc(iris))
  expect_snapshot(myfunc(my_iris), error = TRUE)

  # check_numeric()
  myfunc <- function(x) {
    set_cli_abort_call()
    check_numeric(x)
  }
  expect_silent(myfunc(c(1, 2.45, 6L, TRUE)))
  expect_silent(myfunc(0L))
  expect_snapshot(myfunc("a"), error = TRUE)
})
