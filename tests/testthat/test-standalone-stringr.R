test_that("str_trim() works", {
  s <- str_trim("  trailing and leading whitespace\t")
  expect_identical(s, "trailing and leading whitespace")
  expect_identical(s, stringr::str_trim("  trailing and leading whitespace\t"))

  s <- str_trim("\n\ntrailing and leading whitespace\n\n", "left")
  expect_identical(s, "trailing and leading whitespace\n\n")
  expect_identical(s, stringr::str_trim("\n\ntrailing and leading whitespace\n\n", "left"))

  s <- str_trim("\n\ntrailing and leading whitespace\n\n", "right")
  expect_identical(s, "\n\ntrailing and leading whitespace")
  expect_identical(s, stringr::str_trim("\n\ntrailing and leading whitespace\n\n", "right"))

  s <- str_trim("    ")
  expect_identical(s, "")
  expect_identical(s, stringr::str_trim("    "))
})

test_that("str_squish() works", {
  s <- str_squish("  String with trailing,  middle, and leading white space\t")
  expect_identical(s, "String with trailing, middle, and leading white space")
  expect_identical(s, stringr::str_squish("  String with trailing,  middle, and leading white space\t"))

  s <- str_squish(c("one 1  ", "two\n\n2", "three\r3\t"))
  expect_identical(s, c("one 1", "two 2", "three 3"))
  expect_identical(s, stringr::str_squish(c("one 1  ", "two\n\n2", "three\r3\t")))

  s_notfixed <- str_squish("\n\nString with excess  trailing and leading white   space\n\n")
  expect_identical(s_notfixed, "String with excess trailing and leading white space")
  expect_identical(s_notfixed, stringr::str_squish("\n\nString with excess  trailing and leading white   space\n\n"))

  s_fixed <- str_squish("\n\nString with excess  trailing and leading white   space\n\n", fixed = TRUE)
  expect_identical(s_fixed, "String with excess trailing and leading white space")
  expect_identical(s_fixed, stringr::str_squish(stringr::fixed("\n\nString with excess  trailing and leading white   space\n\n")))

  s <- str_squish("\n\nString with excess  trailing and leading white   space\n\n")
  expect_identical(s, stringr::str_squish("\n\nString with excess  trailing and leading white   space\n\n"))
})

test_that("str_remove_all() works", {
  s <- str_remove_all(c("one 1", "two 2", "three 3"), "[aeiou]")
  expect_identical(s, c("n 1", "tw 2", "thr 3"))
  expect_identical(s, stringr::str_remove_all(c("one 1", "two 2", "three 3"), "[aeiou]"))

  s <- str_remove_all(c("one 1  ", "two\n\n2", "three\r3\t"), "[ \t\r\n]")
  expect_identical(s, c("one1", "two2", "three3"))
  expect_identical(s, stringr::str_remove_all(c("one 1  ", "two\n\n2", "three\r3\t"), "[ \t\r\n]"))

  s_notfixed <- str_remove_all(c("one.1", "two..2", "three...3"), ".")
  expect_identical(s_notfixed, c("", "", ""))
  expect_identical(s_notfixed, stringr::str_remove_all(c("one.1", "two..2", "three...3"), "."))

  s_fixed <- str_remove_all(c("one.1", "two..2", "three...3"), ".", fixed = TRUE)
  expect_identical(s_fixed, c("one1", "two2", "three3"))
  expect_identical(s_fixed, stringr::str_remove_all(c("one.1", "two..2", "three...3"), stringr::fixed(".")))

  s <- str_remove_all(c("one.1", "two..2", "three...3"), ".")
  expect_identical(s, stringr::str_remove_all(c("one.1", "two..2", "three...3"), "."))

  s <- str_remove_all("This is a test string\nwith multiple\nlines", pattern = "\\n(?!\\\\)")
  expect_identical(s, stringr::str_remove_all("This is a test string\nwith multiple\nlines", pattern = "\\n(?!\\\\)"))
})

test_that("str_extract() works", {
  shopping_list <- c("apples x43", "bag of flour", "bag of sugar, bag of sugar", "milk x2")

  s <- str_extract(shopping_list, "[a-z]+")
  expect_identical(s, c("apples", "bag", "bag", "milk"))
  expect_identical(s, stringr::str_extract(shopping_list, "[a-z]+"))

  s <- str_extract(shopping_list, "([a-z]+) of ([a-z]+)")
  expect_identical(s, c(NA, "bag of flour", "bag of sugar", NA))
  expect_identical(s, stringr::str_extract(shopping_list, "([a-z]+) of ([a-z]+)"))

  s_notfixed <- str_extract(shopping_list, "\\d")
  expect_identical(s_notfixed, c("4", NA, NA, "2"))
  expect_identical(s_notfixed, stringr::str_extract(shopping_list, "\\d"))

  s_fixed <- str_extract(shopping_list, "\\d", fixed = TRUE)
  expect_identical(s_fixed, rep(NA_character_, 4))
  expect_identical(s_fixed, stringr::str_extract(shopping_list, stringr::fixed("\\d")))

  s <- str_extract(shopping_list, "[a-z]+")
  expect_identical(s, stringr::str_extract(shopping_list, "[a-z]+"))
})

test_that("str_extract_all() works", {
  shopping_list <- c("apples x43", "bag of flour", "bag of sugar, bag of sugar", "milk x2")

  s <- str_extract_all(shopping_list, "[a-z]+")
  expect_identical(s, stringr::str_extract_all(shopping_list, "[a-z]+"))

  s <- str_extract_all(shopping_list, "([a-z]+) of ([a-z]+)")
  expect_identical(s, stringr::str_extract_all(shopping_list, "([a-z]+) of ([a-z]+)"))

  s_notfixed <- str_extract_all(shopping_list, "\\d")
  expect_identical(s_notfixed, stringr::str_extract_all(shopping_list, "\\d"))

  s_fixed <- str_extract_all(shopping_list, "\\d", fixed = TRUE)
  expect_identical(s_fixed, stringr::str_extract_all(shopping_list, stringr::fixed("\\d")))

  s <- str_extract_all(shopping_list, "[a-z]+")
  expect_identical(s, stringr::str_extract_all(shopping_list, "[a-z]+"))

  s <- str_extract_all("This is a test string\nwith multiple\nlines", pattern = "\\n(?!\\\\)")
  expect_identical(s, stringr::str_extract_all("This is a test string\nwith multiple\nlines", pattern = "\\n(?!\\\\)"))
})

test_that("str_detect() works", {
  fruits <- c("apple", "banana", "pear", "pineapple")

  s <- str_detect(fruits, "apple")
  expect_identical(s, c(TRUE, FALSE, FALSE, TRUE))
  expect_identical(s, stringr::str_detect(fruits, "apple"))

  s <- str_detect(fruits, "p")
  expect_identical(s, c(TRUE, FALSE, TRUE, TRUE))
  expect_identical(s, stringr::str_detect(fruits, "p"))

  s_notfixed <- str_detect(fruits, "^a")
  expect_identical(s_notfixed, c(TRUE, rep(FALSE, 3)))
  expect_identical(s_notfixed, stringr::str_detect(fruits, "^a"))

  s_fixed <- str_detect(fruits, "^a", fixed = TRUE)
  expect_identical(s_fixed, rep(FALSE, 4))
  expect_identical(s_fixed, stringr::str_detect(fruits, stringr::fixed("^a")))

  s <- str_detect(fruits, "p")
  expect_identical(s, stringr::str_detect(fruits, "p"))

  s <- str_detect("This is a test string\nwith multiple\nlines", pattern = "\\n(?!\\\\)")
  expect_identical(s, stringr::str_detect("This is a test string\nwith multiple\nlines", pattern = "\\n(?!\\\\)"))
})

test_that("str_remove() works", {
  s <- str_remove(c("one 1", "two 2", "three 3"), "[aeiou]")
  expect_identical(s, c("ne 1", "tw 2", "thre 3"))
  expect_identical(s, stringr::str_remove(c("one 1", "two 2", "three 3"), "[aeiou]"))

  s <- str_remove(c("one 1  ", "two\n\n2", "three\r3\t"), "[ \t\r\n]")
  expect_identical(s, c("one1  ", "two\n2", "three3\t"))
  expect_identical(s, stringr::str_remove(c("one 1  ", "two\n\n2", "three\r3\t"), "[ \t\r\n]"))

  s_notfixed <- str_remove(c("one.1", "two..2", "three...3"), ".")
  expect_identical(s_notfixed, c("ne.1", "wo..2", "hree...3"))
  expect_identical(s_notfixed, stringr::str_remove(c("one.1", "two..2", "three...3"), "."))

  s_fixed <- str_remove(c("one.1", "two..2", "three...3"), ".", fixed = TRUE)
  expect_identical(s_fixed, c("one1", "two.2", "three..3"))
  expect_identical(s_fixed, stringr::str_remove(c("one.1", "two..2", "three...3"), stringr::fixed(".")))

  s <- str_remove(c("one.1", "two..2", "three...3"), ".")
  expect_identical(s, stringr::str_remove(c("one.1", "two..2", "three...3"), "."))

  s <- str_remove("This is a test string\nwith multiple\nlines", pattern = "\\n(?!\\\\)")
  expect_identical(s, stringr::str_remove("This is a test string\nwith multiple\nlines", pattern = "\\n(?!\\\\)"))
})

test_that("str_replace() works", {
  fruits <- c("one apple", "two pears", "three bananas")

  s <- str_replace(fruits, "[aeiou]", "-")
  expect_identical(s, c("-ne apple", "tw- pears", "thr-e bananas"))
  expect_identical(s, stringr::str_replace(fruits, "[aeiou]", "-"))

  s <- str_replace(fruits, "([aeiou])", "\\1\\1")
  expect_identical(s, c("oone apple", "twoo pears", "threee bananas"))
  expect_identical(s, stringr::str_replace(fruits, "([aeiou])", "\\1\\1"))

  s <- str_replace(fruits, "([aeiou])", "\\1\\1")
  expect_identical(s, stringr::str_replace(fruits, "([aeiou])", "\\1\\1"))

  s <- str_replace("This is a test string\nwith multiple\nlines", pattern = "\\n(?!\\\\)", replacement = "")
  expect_identical(s, stringr::str_replace("This is a test string\nwith multiple\nlines", pattern = "\\n(?!\\\\)", replacement = ""))
})

test_that("str_replace_all() works", {
  fruits <- c("one apple", "two pears", "three bananas")

  s <- str_replace_all(fruits, "[aeiou]", "-")
  expect_identical(s, c("-n- -ppl-", "tw- p--rs", "thr-- b-n-n-s"))
  expect_identical(s, stringr::str_replace_all(fruits, "[aeiou]", "-"))

  s <- str_replace_all(fruits, "([aeiou])", "\\1\\1")
  expect_identical(s, c("oonee aapplee", "twoo peeaars", "threeee baanaanaas"))
  expect_identical(s, stringr::str_replace_all(fruits, "([aeiou])", "\\1\\1"))

  s <- str_replace_all(fruits, "[aeiou]", "-")
  expect_identical(s, stringr::str_replace_all(fruits, "[aeiou]", "-"))

  s <- str_replace_all("This is a test string\nwith multiple\nlines", pattern = "\\n(?!\\\\)", replacement = "")
  expect_identical(s, stringr::str_replace_all("This is a test string\nwith multiple\nlines", pattern = "\\n(?!\\\\)", replacement = ""))
})

test_that("str_sub() works", {
  hw <- "Hadley Wickham"

  s <- str_sub(hw, 1, 6)
  expect_identical(s, "Hadley")
  expect_identical(s, stringr::str_sub(hw, 1, 6))

  s <- str_sub(hw, -1)
  expect_identical(s, "m")
  expect_identical(s, stringr::str_sub(hw, -1))

  s <- str_sub(hw, -1)
  expect_identical(s, stringr::str_sub(hw, -1))
})

test_that("str_sub_all() works", {
  fruits <- c("one apple", "two pears", "three bananas")

  s <- str_replace_all(fruits, "[aeiou]", "-")
  expect_identical(s, c("-n- -ppl-", "tw- p--rs", "thr-- b-n-n-s"))
  expect_identical(s, stringr::str_replace_all(fruits, "[aeiou]", "-"))

  s <- str_replace_all(fruits, "([aeiou])", "\\1\\1")
  expect_identical(s, c("oonee aapplee", "twoo peeaars", "threeee baanaanaas"))
  expect_identical(s, stringr::str_replace_all(fruits, "([aeiou])", "\\1\\1"))

  s <- str_replace_all(fruits, "([aeiou])", "\\1\\1")
  expect_identical(s, stringr::str_replace_all(fruits, "([aeiou])", "\\1\\1"))

  s <- str_replace_all("This is a test string\nwith multiple\nlines", pattern = "\\n(?!\\\\)", replacement = "")
  expect_identical(s, stringr::str_replace_all("This is a test string\nwith multiple\nlines", pattern = "\\n(?!\\\\)", replacement = ""))
})

test_that("str_pad() works", {
  s <-  str_pad("hadley", 30, "left")
  expect_identical(s, stringr::str_pad("hadley", 30, "left"))

  s <- str_pad("hadley", 30, "right")
  expect_identical(s, stringr::str_pad("hadley", 30, "right"),)

  s <- str_pad("hadley", 30, "both")
  expect_identical(s, stringr::str_pad("hadley", 30, "both"))
})

test_that("word() works", {
  sentences <- c("Jane saw a cat", "Jane sat down")

  s <- word(sentences, 1)
  expect_identical(s, stringr::word(sentences, 1))

  s <- word(sentences, 2, -1)
  expect_identical(s, stringr::word(sentences, 2, -1))
})

test_that("str_split() works", {
  fruits <- c(
    "apples and oranges and pears and bananas",
    "pineapples and mangos and guavas"
  )

  s <- str_split(fruits, " and ")
  expect_identical(s, stringr::str_split(fruits, " and "))

  s <- str_split(fruits, " and ", n = 3)
  expect_identical(s, stringr::str_split(fruits, " and ", n = 3))

  s <- str_split("This is a test string\nwith multiple\nlines", pattern = "\\n(?!\\\\)")
  expect_identical(s, stringr::str_split("This is a test string\nwith multiple\nlines", pattern = "\\n(?!\\\\)"))
})
