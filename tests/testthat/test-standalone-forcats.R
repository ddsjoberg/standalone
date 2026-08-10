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

test_that("fct_relevel() works", {
  f <- factor(c("b", "b", "a", "c", "c", "c"))
  expect_equal(forcats::fct_relevel(fct_relevel(f, "b", "a")), fct_relevel(f, "b", "a"))
  expect_equal(forcats::fct_relevel(f, "a", after = Inf), fct_relevel(f, "a", after = Inf))
  expect_equal(forcats::fct_relevel(f, rev), fct_relevel(f, rev))
  expect_equal(forcats::fct_relevel(f, ~ rev(.x)), fct_relevel(f, ~ rev(.x)))
  expect_equal(forcats::fct_relevel(letters, "z"), fct_relevel(letters, "z"))

  # test for unobserved levels
  f_new <- fct_relevel(f, "b", "a", "d") # "d" is unobserved
  expect_equal(levels(f_new), c("b", "a", "d", "c")) # "d" should be added as a level, even though not observed
})

test_that("fct_collapse() works", {
  f <- factor(c("b", "b", "a", "c", "c", "d"))
  expect_equal(forcats::fct_collapse(f, ab = c("a", "b")), fct_collapse(f, ab = c("a", "b")))
  expect_equal(
    forcats::fct_collapse(f, ab = c("a", "b"), cd = c("c", "d")),
    fct_collapse(f, ab = c("a", "b"), cd = c("c", "d"))
  )
  expect_equal(
    forcats::fct_collapse(f, ab = c("a", "b"), other_level = "c"),
    fct_collapse(f, ab = c("a", "b"), other_level = "c")
  )
})

test_that("fct_* function behaviour when input is not a factor ", {
  f <- factor(c("b", "b", "a", "c", "c", "c"))
  c <- as.character(c("b", "b", "a", "c", "c", "c"))
  expect_equal(forcats::fct_infreq(f), fct_infreq(c))
  expect_equal(forcats::fct_inorder(f), fct_inorder(c))
  expect_equal(forcats::fct_rev(f), fct_rev(c))
  expect_equal(forcats::fct_relevel(forcats::fct_relevel(f, "b", "a")), fct_relevel(fct_relevel(c, "b", "a")))
  expect_equal(forcats::fct_collapse(f, ab = c("a", "b")), fct_collapse(c, ab = c("a", "b")))

  f <- factor(sample(letters[1:3], 20, replace = TRUE))
  c <- as.character(f)
  expect_equal(forcats::fct_expand(f, letters[1:6]), fct_expand(c, letters[1:6]))

  f <- as.factor(c("a", "b", NA, "c", "b", NA))
  c <- as.character(f)
  expect_equal(forcats::fct_na_value_to_level(f, level = NA), fct_na_value_to_level(c, level = NA))
})

test_that("fct_reorder() works", {
  f <- factor(c("WEEK 1", "WEEK 12", "WEEK 1", "WEEK 4", "WEEK 12", "WEEK 6"))
  x <- c(1, 12, 1, 4, 12, 6)

  expect_equal(forcats::fct_reorder(f, x), fct_reorder(f, x))
  # levels before fct_reorder are alphabetical (week 12 before week 4)
  expect_equal(levels(f), c("WEEK 1", "WEEK 12", "WEEK 4", "WEEK 6"))
  # levels are ordered by x with fct_reorder
  expect_equal(levels(fct_reorder(f, x)), c("WEEK 1", "WEEK 4", "WEEK 6", "WEEK 12"))
  expect_equal(levels(fct_reorder(f, x, .desc = TRUE)), c("WEEK 12", "WEEK 6", "WEEK 4", "WEEK 1"))


  # Test NA handling
  f1 <- factor(c("a", "b", "c", "c"))
  x <- c(3, 2, 1, NA)

  # function handled NA as forcats does
  expect_equal(levels(forcats::fct_reorder(f1, x, .na_rm = FALSE)), levels(fct_reorder(f1, x, .na_rm = FALSE)))
})

test_that("fct_reorder() matches forcats with many levels and empty levels", {
  set.seed(1)
  f <- factor(sample(paste0("L", 1:200), 1000, replace = TRUE))
  x <- rnorm(1000)
  expect_equal(fct_reorder(f, x), forcats::fct_reorder(f, x))
  expect_equal(fct_reorder(f, x, .desc = TRUE), forcats::fct_reorder(f, x, .desc = TRUE))

  # a level present in `levels()` but absent from the data falls back to .default
  f_empty <- factor(c("a", "b", "c"), levels = c("a", "b", "c", "d"))
  x_empty <- c(3, 2, 1)
  expect_equal(
    levels(fct_reorder(f_empty, x_empty)),
    levels(forcats::fct_reorder(f_empty, x_empty))
  )
})

test_that("fct_collapse() works without base R `%||%` (R < 4.4 compatibility)", {
  f <- factor(c("b", "b", "a", "c", "c", "d"))
  expect_equal(
    fct_collapse(f, ab = c("a", "b")),
    forcats::fct_collapse(f, ab = c("a", "b"))
  )
})
