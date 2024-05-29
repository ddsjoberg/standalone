test_that("set_cli_abort_call() and get_cli_abort_call() work", {
  env <- rlang::env()
  set_cli_abort_call(env)

  expect_identical(get_cli_abort_call(), env)
})
