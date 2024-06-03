test_that("str_trim() works", {
  s <- str_trim("  trailing and leading whitespace\t")
  expect_identical(s, "trailing and leading whitespace")

  s <- str_trim("\n\ntrailing and leading whitespace\n\n", "left")
  expect_identical(s, "trailing and leading whitespace\n\n")

  s <- str_trim("\n\ntrailing and leading whitespace\n\n", "right")
  expect_identical(s, "\n\ntrailing and leading whitespace")

  s <- str_trim("    ")
  expect_identical(s, "")
})

test_that("str_squish() works", {
  s <- str_squish("  String with trailing,  middle, and leading white space\t")
  expect_identical(s, "String with trailing, middle, and leading white space")

  s <- str_squish(c("one 1  ", "two\n\n2", "three\r3\t"))
  expect_identical(s, c("one 1", "two 2", "three 3"))

  s_notfixed <- str_squish("\n\nString with excess  trailing and leading white   space\n\n")
  expect_identical(s_notfixed, "String with excess trailing and leading white space")

  s_fixed <- str_squish("\n\nString with excess  trailing and leading white   space\n\n", fixed = TRUE)
  expect_identical(s_fixed, "String with excess  trailing and leading white   space")
})

test_that("str_remove_all() works", {
  s <- str_remove_all(c("one 1", "two 2", "three 3"), "[aeiou]")
  expect_identical(s, c("n 1", "tw 2", "thr 3"))

  s <- str_remove_all(c("one 1  ", "two\n\n2", "three\r3\t"), "[ \t\r\n]")
  expect_identical(s, c("one1", "two2", "three3"))

  s_notfixed <- str_remove_all(c("one.1", "two..2", "three...3"), ".")
  expect_identical(s_notfixed, c("", "", ""))

  s_fixed <- str_remove_all(c("one.1", "two..2", "three...3"), ".", fixed = TRUE)
  expect_identical(s_fixed, c("one1", "two2", "three3"))
})

test_that("str_extract() works", {
  shopping_list <- c("apples x43", "bag of flour", "bag of sugar", "milk x2")

  s <- str_extract(shopping_list, "[a-z]+")
  expect_identical(s, c("apples", "bag", "bag", "milk"))

  s <- str_extract(shopping_list, "([a-z]+) of ([a-z]+)")
  expect_identical(s, c(NA, "bag of sugar", "bag of flour", NA))

  s_notfixed <- str_extract(shopping_list, "\\d")
  expect_identical(s_notfixed, c("4", NA, NA, "2"))

  s_fixed <- str_extract(shopping_list, "\\d", fixed = TRUE)
  expect_identical(s_fixed, rep(NA_character_, 4))
})

test_that("str_detect() works", {
  fruits <- c("apple", "banana", "pear", "pineapple")

  s <- str_detect(fruits, "apple")
  expect_identical(s, c(TRUE, FALSE, FALSE, TRUE))

  s <- str_detect(fruits, "p")
  expect_identical(s, c(TRUE, FALSE, TRUE, TRUE))

  s_notfixed <- str_detect(fruits, "^a")
  expect_identical(s_notfixed, c(TRUE, rep(FALSE, 3)))

  s_fixed <- str_detect(fruits, "^a", fixed = TRUE)
  expect_identical(s_fixed, rep(FALSE, 4))
})

test_that("str_remove() works", {
  s <- str_remove(c("one 1", "two 2", "three 3"), "[aeiou]")
  expect_identical(s, c("ne 1", "tw 2", "thre 3"))

  s <- str_remove(c("one 1  ", "two\n\n2", "three\r3\t"), "[ \t\r\n]")
  expect_identical(s, c("one1  ", "two\n2", "three3\t"))

  s_notfixed <- str_remove(c("one.1", "two..2", "three...3"), ".")
  expect_identical(s_notfixed, c("ne.1", "wo..2", "hree...3"))

  s_fixed <- str_remove(c("one.1", "two..2", "three...3"), ".", fixed = TRUE)
  expect_identical(s_fixed, c("one1", "two.2", "three..3"))
})

test_that("str_replace() works", {
  fruits <- c("one apple", "two pears", "three bananas")

  s <- str_replace(fruits, "[aeiou]", "-")
  expect_identical(s, c("-one apple", "tw- pears", "thr-e bananas"))

  s <- str_replace(fruits, "([aeiou])", "\\1\\1")
  expect_identical(s, c("oone apple", "twoo pears", "threee bananas"))

})

test_that("str_replace_all() works", {
  fruits <- c("one apple", "two pears", "three bananas")

  s <- str_replace_all(fruits, "[aeiou]", "-")
  expect_identical(s, c("-n- -ppl-", "tw- p--rs", "thr-- b-n-n-s"))

  s <- str_replace_all(fruits, "([aeiou])", "\\1\\1")
  expect_identical(s, c("oonee aapplee", "twoo peeaars", "threeee baanaanaas"))

})

test_that("str_sub() works", {
  hw <- "Hadley Wickham"

  s <- str_sub(hw, 1, 6)
  expect_identical(s, "Hadley")

  s <- str_sub(hw, -1)
  expect_identical(s, "m")

})

test_that("str_sub_all() works", {
  fruits <- c("one apple", "two pears", "three bananas")

  s <- str_replace_all(fruits, "[aeiou]", "-")
  expect_identical(s, c("-n- -ppl-", "tw- p--rs", "thr-- b-n-n-s"))

  s <- str_replace_all(fruits, "([aeiou])", "\\1\\1")
  expect_identical(s, c("oonee aapplee", "twoo peeaars", "threeee baanaanaas"))

})
