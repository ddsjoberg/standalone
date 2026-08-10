test_that("deframe() works", {
  data <- data.frame(a = letters[1:5], n = 1:5)
  def <- deframe(data)

  expect_identical(names(def), data[[1]])
  expect_identical(unname(def), data[[2]])

  def <- deframe(data[1])

  expect_identical(def, data[[1]])
})

test_that("enframe() works", {
  enf <- enframe(1:3)
  expect_identical(names(enf), c("name", "value"))
  expect_identical(enf[[1]], 1:3)
  expect_identical(enf[[2]], 1:3)

  enf <- enframe(c(a = 5, b = 7), name = "alpha", value = "num")
  expect_identical(names(enf), c("alpha", "num"))
  expect_identical(enf[[1]], c("a", "b"))
  expect_identical(enf[[2]], c(5, 7))

  enf <- enframe(list(one = 1, two = 2:3, three = 4:6))
  expect_identical(enf[[1]], c("one", "two", "three"))
  expect_identical(enf[[2]], c(list(1), list(2:3), list(4:6)))
})

test_that("remove_rownames() works", {
  data <- data.frame(a = 1:3, row.names = letters[1:3])
  data <- remove_rownames(data)
  expect_identical(rownames(data), c("1", "2", "3"))
})

test_that("rownames_to_column() works", {
  data <- data.frame(a = 1:3, row.names = letters[1:3])
  data <- rownames_to_column(data, var = "nms")
  expect_identical(names(data), c("nms", "a"))
  expect_identical(data[[1]], letters[1:3])
})

test_that("rownames_to_column() resets row names like tibble", {
  data <- data.frame(a = 1:3, row.names = letters[1:3])
  expect_identical(
    rownames_to_column(data, var = "nms"),
    tibble::rownames_to_column(data, var = "nms")
  )
  expect_identical(
    rownames_to_column(data),
    tibble::rownames_to_column(data)
  )
})

test_that("enframe() handles NULL and name = NULL like tibble", {
  expect_identical(enframe(NULL), tibble::enframe(NULL))
  expect_identical(enframe(1:3, name = NULL), tibble::enframe(1:3, name = NULL))
  expect_identical(
    enframe(c(a = 5, b = 7), name = NULL),
    tibble::enframe(c(a = 5, b = 7), name = NULL)
  )
})
