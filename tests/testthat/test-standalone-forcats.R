test_that("fct_infreq() works", {
  f <- factor(c("b", "b", "a", "c", "c", "c"))

  expect_equal(levels(fct_infreq(f)), as.character(unique(sort(f, decreasing = TRUE))))
  expect_true(is.ordered(fct_infreq(f, ordered = TRUE)))
  expect_equal(levels(fct_infreq(f)), levels(forcats::fct_infreq(f)))
})

test_that("fct_inorder() works", {
  f <- factor(c("b", "b", "a", "c", "c", "c"))

  expect_equal(levels(fct_inorder(f)), as.character(unique(f)))
  expect_equal(levels(fct_inorder(f)), levels(forcats::fct_inorder(f)))
  expect_true(is.ordered(fct_inorder(f, ordered = TRUE)))
})

test_that("fct_rev() works", {
  f <- c("b", "b", "a", "c", "c", "c")

  expect_equal(levels(fct_rev(f)), rev(levels(as.factor(f))))
  expect_equal(levels(fct_rev(f)), levels(forcats::fct_rev(f)))
})

test_that("fct_expand() works", {
  f <- factor(sample(letters[1:3], 20, replace = TRUE))
  expect_equal(fct_expand(f, letters[1:6]), forcats::fct_expand(f, letters[1:6]))
  expect_equal(fct_expand(letters[1:3], "z", "zz", after = 0), forcats::fct_expand(letters[1:3], "z", "zz", after = 0))
})

test_that("fct_na_value_to_level() works", {
  # default NA level
  f1 <- as.factor(c("a", "b", NA, "c", "b", NA))
  expect_equal(
    fct_na_value_to_level(f1, level = NA),
    forcats::fct_na_value_to_level(f1, level = NA)
  )

  # specified character level
  f2 <- factor(c(NA, letters[1:2]))

  forcats::fct_na_value_to_level(f2, "(Missing)")
  fct_na_value_to_level(f2, "(Missing)")
})
