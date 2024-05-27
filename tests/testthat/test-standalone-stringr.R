test_that("str_trim() works", {
  s <- str_trim("  trailing and leading whitespace\t")
  expect_equal(s, "trailing and leading whitespace")

  s <- str_trim("\n\ntrailing and leading whitespace\n\n", "left")
  expect_equal(s, "trailing and leading whitespace\n\n")

  s <- str_trim("\n\ntrailing and leading whitespace\n\n", "right")
  expect_equal(s, "\n\ntrailing and leading whitespace")

  s <- str_trim("    ")
  expect_equal(s, "")
})

test_that("str_squish() works", {
  s <- str_squish("  String with trailing,  middle, and leading white space\t")
  expect_equal(s, "String with trailing, middle, and leading white space")

  s <- str_squish(c("one 1  ", "two\n\n2", "three\r3\t"))
  expect_equal(s, c("one 1", "two 2", "three 3"))

  s_notfixed <- str_squish("\n\nString with excess  trailing and leading white   space\n\n")
  expect_equal(s, "String with excess trailing and leading white space")

  s_fixed <- str_squish("\n\nString with excess  trailing and leading white   space\n\n", fixed = TRUE)
  expect_equal(s, "String with excess  trailing and leading white   space")
})

test_that("str_remove_all() works", {
  s <- str_remove_all(c("one 1", "two 2", "three 3"), "[aeiou]")
  expect_equal(s, c("n 1", "tw 2", "thr 3"))

  s <- str_remove_all(c("one 1  ", "two\n\n2", "three\r3\t"), "[ \t\r\n]")
  expect_equal(s, c("one1", "two2", "three3"))

  s_notfixed <- str_remove_all(c("one.1", "two..2", "three...3"), ".")
  expect_equal(s, c("", "", ""))

  s_fixed <- str_remove_all(c("one.1", "two..2", "three...3"), ".", fixed = TRUE)
  expect_equal(s, c("one1", "two2", "three3"))
})

test_that("str_extract() works", {

})

test_that("str_detect() works", {

})
