test_that("fct_infreq() works", {
  f <- factor(c("b", "b", "a", "c", "c", "c"))

  expect_equal(levels(fct_infreq(f)), as.character(unique(sort(f, decreasing = TRUE))))
  expect_true(is.ordered(fct_infreq(f, ordered = TRUE)))
})

test_that("fct_inorder() works", {
  f <- factor(c("b", "b", "a", "c", "c", "c"))

  expect_equal(levels(fct_inorder(f)), as.character(unique(f)))
  expect_true(is.ordered(fct_inorder(f, ordered = TRUE)))
})

test_that("fct_rev() works", {
  f <- factor(c("b", "b", "a", "c", "c", "c"))

  expect_equal(levels(fct_rev(f)), rev(levels(f)))

})
