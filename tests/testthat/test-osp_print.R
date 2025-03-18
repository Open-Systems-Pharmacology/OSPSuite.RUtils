test_that("osp_print_class prints class name correctly", {
  # Test with a data frame
  expect_snapshot(osp_print_class(data.frame(x = 1:3, y = letters[1:3])))

  # Test with a list
  expect_snapshot(osp_print_class(list(a = 1, b = 2)))

  # Test with a vector
  expect_snapshot(osp_print_class(1:5))

  # Test with a custom R6 class
  myClass <- R6::R6Class("myClass")

  expect_snapshot(osp_print_class(myClass$new()))

})

test_that("osp_print_header prints headers at different levels", {
  # Test with level 1 |>
  expect_snapshot(osp_print_header("Main Title", 1))

  # Test with level 2
  expect_snapshot(osp_print_header("Section Title", 2))

  # Test with level 3
  expect_snapshot(osp_print_header("Subsection Title", 3))

  # Test with invalid level
  expect_error(osp_print_header("Invalid", 4))
  expect_error(osp_print_header("Invalid", "not a number"))
})

test_that("osp_print_items prints items correctly", {
  # Test with named vector
  person <- c(name = "John", age = "30", job = "Developer")
  expect_snapshot(osp_print_items(person))

  # Test with unnamed vector
  colors <- c("red", "green", "blue")
  expect_snapshot(osp_print_items(colors))

  # Test with named list
  my_list <- list(id = 123, values = c(1, 2, 3), name = "Test")
  expect_snapshot(osp_print_items(my_list))

  # Test with mixed named and unnamed items
  mixed <- c(a = "A", "B", c = "C")
  expect_snapshot(osp_print_items(mixed))

  # Test with title parameter for unnamed vector
  letters_vec <- c("A", "B", "C")
  expect_snapshot(osp_print_items(letters_vec, title = "Letters"))

  # Test with title parameter for named vector
  numbered_letters <- c(A = 1, B = 2, C = 3)
  expect_snapshot(osp_print_items(numbered_letters, title = "Letters"))
})


test_that("Different osp_print_* functions work well together",{
  myClass <-
    R6::R6Class("myClass",
                public = list(
                  named_items = list(
                    "A" = 1,
                    "B" = 2,
                    "C" = 3),
                  nested_item_list = list(
                    sub_list_1 = list(
                      "D" = 4,
                      "E" = 5
                    ),
                    sub_list_2 = list(
                      "F" = 6,
                      "G" = 7
                    )
                  )
                )
    )
  my_object <- myClass$new()
  expect_snapshot({
    osp_print_class(my_object)
    osp_print_items(my_object$named_items, title = "Named Items")
    osp_print_header("Nested Item List", 2)
    purrr::iwalk(my_object$nested_item_list, \(x, idx)
                 osp_print_items(x, title = idx)
    )
  })

})
