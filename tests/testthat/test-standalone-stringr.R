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

test_that("str_sub() supports vectorized start/end like stringr::str_sub()", {
  # vectorized start/end against a single string (previously errored)
  expect_identical(
    str_sub("abcdefgh", c(1, 3, 5)),
    stringr::str_sub("abcdefgh", c(1, 3, 5))
  )
  expect_identical(
    str_sub("abcdefgh", 1, c(2, 4, 6)),
    stringr::str_sub("abcdefgh", 1, c(2, 4, 6))
  )

  # vectorized string with vectorized indices
  expect_identical(
    str_sub(c("hello", "world"), c(1, 2), c(3, 4)),
    stringr::str_sub(c("hello", "world"), c(1, 2), c(3, 4))
  )

  # scalar start recycled across a string vector
  expect_identical(
    str_sub(c("hello", "world"), 2),
    stringr::str_sub(c("hello", "world"), 2)
  )

  # empty input
  expect_identical(str_sub(character(0), 1, 2), stringr::str_sub(character(0), 1, 2))
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
  s <- str_pad("hadley", 30, "left")
  expect_identical(s, stringr::str_pad("hadley", 30, "left"))

  s <- str_pad("hadley", 30, "right")
  expect_identical(s, stringr::str_pad("hadley", 30, "right"), )

  s <- str_pad("hadley", 30, "both")
  expect_identical(s, stringr::str_pad("hadley", 30, "both"))
})

test_that("str_pad() matches stringr::str_pad with escape characters", {
  s <- "\"**Primary System Organ Class**  \\n    **Reported Term for the Adverse Event**\""

  padded_string <- str_pad(s, 82, pad = " ", side = "right")
  stringr_string <- stringr::str_pad(s, 82, pad = " ", side = "right")

  expect_identical(padded_string, stringr_string)
})

test_that("str_pad() handles edge cases like stringr::str_pad()", {
  # width smaller than the string is a no-op (does not error)
  expect_identical(str_pad("abcdef", 3), stringr::str_pad("abcdef", 3))

  # vectorized width with a scalar string returns a vector, not a matrix
  expect_identical(str_pad("ab", c(3, 5)), stringr::str_pad("ab", c(3, 5)))

  # vectorized string and width together
  expect_identical(
    str_pad(c("a", "bb"), c(3, 4)),
    stringr::str_pad(c("a", "bb"), c(3, 4))
  )

  # NA inputs are preserved (not turned into the string "NA")
  expect_identical(
    str_pad(c("a", NA, "bb"), 4),
    stringr::str_pad(c("a", NA, "bb"), 4)
  )

  # empty input returns an empty character vector
  expect_identical(str_pad(character(0), 3), stringr::str_pad(character(0), 3))

  # vectorized pad character
  expect_identical(
    str_pad(c("a", "b"), 3, pad = c("-", "*")),
    stringr::str_pad(c("a", "b"), 3, pad = c("-", "*"))
  )
})

test_that("word() works", {
  sentences <- c("Jane saw a cat", "Jane sat down")

  s <- word(sentences, 1)
  expect_identical(s, stringr::word(sentences, 1))

  s <- word(sentences, 2, -1)
  expect_identical(s, stringr::word(sentences, 2, -1))
})

test_that("word() handles edge cases like stringr::word()", {
  # NA input returns NA_character_ (does not error)
  expect_identical(word(NA, 1), stringr::word(NA, 1))
  expect_identical(word(c("a b", NA), 1), stringr::word(c("a b", NA), 1))

  # empty string yields an empty word
  expect_identical(word("", 1), stringr::word("", 1))

  # leading separators and consecutive separators keep empty segments
  expect_identical(word("  a b", 1), stringr::word("  a b", 1))
  expect_identical(word("a,,b", 2, sep = ","), stringr::word("a,,b", 2, sep = ","))

  # out-of-range index returns NA
  expect_identical(word("a b", 5), stringr::word("a b", 5))

  # default start of 1
  expect_identical(word("one two", end = 1), stringr::word("one two", end = 1))
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

test_that("str_split() with finite n keeps the original tail for regex patterns", {
  # the final piece must keep the original separators, not re-join with the
  # literal regex pattern
  expect_identical(
    str_split("aXXbXXc", "X+", n = 2),
    stringr::str_split("aXXbXXc", "X+", n = 2)
  )

  # n larger than the number of pieces returns all pieces
  expect_identical(str_split("a,b", ",", n = 5), stringr::str_split("a,b", ",", n = 5))

  # n = 1 returns the whole string unsplit
  expect_identical(str_split("a,b,c", ",", n = 1), stringr::str_split("a,b,c", ",", n = 1))

  # vectorized input with finite n
  expect_identical(
    str_split(c("a,b,c", "d,e,f"), ",", n = 2),
    stringr::str_split(c("a,b,c", "d,e,f"), ",", n = 2)
  )
})

test_that("str_extract() and str_remove_all() replacement works for package version identification", {
  package_version <- "2.0.3"

  s <- as.character(ifelse(regexpr("[>=<]+", package_version) > 0,
              regmatches(package_version, regexpr("[>=<]+", package_version)),
              NA))
  expect_identical(s, stringr::str_extract(package_version, pattern = "[>=<]+"))

  s <- gsub(pattern = "[\\(\\) >=<]", replacement = "", x = package_version)
  expect_identical(s, stringr::str_remove_all(package_version, "[\\(\\) >=<]"))

})
