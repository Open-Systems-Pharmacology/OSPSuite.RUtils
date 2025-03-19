# osp_print_class prints class name correctly

    Code
      osp_print_class(data.frame(x = 1:3, y = letters[1:3]))
    Message
      <data.frame>

---

    Code
      osp_print_class(list(a = 1, b = 2))
    Message
      <list>

---

    Code
      osp_print_class(1:5)
    Message
      <integer>

---

    Code
      osp_print_class(myClass$new())
    Message
      <myClass>

# osp_print_header prints headers at different levels

    Code
      osp_print_header("Main Title", 1)
    Message
      
      -- Main Title ------------------------------------------------------------------

---

    Code
      osp_print_header("Section Title", 2)
    Message
      
      -- Section Title --
      

---

    Code
      osp_print_header("Subsection Title", 3)
    Message
      
      -- Subsection Title 

# osp_print_items prints items correctly

    Code
      osp_print_items(person)
    Message
        * name: John
        * age: 30
        * job: Developer

---

    Code
      osp_print_items(colors)
    Message
        * red
        * green
        * blue

---

    Code
      osp_print_items(my_list)
    Message
        * id: 123
        * values: 1, 2, 3
        * name: Test

---

    Code
      osp_print_items(mixed)
    Message
        * a: A
        * B
        * c: C

---

    Code
      osp_print_items(letters_vec, title = "Letters")
    Message
      Letters:
        * A
        * B
        * C

---

    Code
      osp_print_items(numbered_letters, title = "Letters")
    Message
      Letters:
        * A: 1
        * B: 2
        * C: 3

# osp_print_items handles empty values (NULL, NA, empty string)

    Code
      osp_print_items(list_with_nulls, title = "Mixed with NULL and empty",
        print_empty = TRUE)
    Message
      Mixed with NULL and empty:
        * Null: NULL
        * Value: 100
        * Empty: <empty string>
    Code
      osp_print_items(list_with_na, title = "Mixed with NA and NULL", print_empty = TRUE)
    Message
      Mixed with NA and NULL:
        * NA: NA
        * Value: 200
        * Null: NULL

---

    Code
      osp_print_items(list_with_nulls, title = "Mixed with NULL and empty",
        print_empty = FALSE)
    Message
      Mixed with NULL and empty:
        * Value: 100
    Code
      osp_print_items(list_with_na, title = "Mixed with NA and NULL", print_empty = FALSE)
    Message
      Mixed with NA and NULL:
        * Value: 200

---

    Code
      osp_print_items(all_empty, title = "All Empty", print_empty = TRUE)
    Message
      All Empty:
        * Null: NULL
        * NA: NA
        * Empty: <empty string>

---

    Code
      osp_print_items(all_empty, title = "All Empty", print_empty = FALSE)
    Message
      All Empty:
        * All items are NULL, NA, or empty

---

    Code
      osp_print_items(mixed_unnamed, title = "Mixed Unnamed", print_empty = TRUE)
    Message
      Mixed Unnamed:
        * NULL
        * value
        * NA
        * <empty string>
    Code
      osp_print_items(mixed_unnamed, title = "Mixed Unnamed", print_empty = FALSE)
    Message
      Mixed Unnamed:
        * value

---

    Code
      osp_print_items(all_empty, print_empty = TRUE)
    Message
        * Null: NULL
        * NA: NA
        * Empty: <empty string>
    Code
      osp_print_items(all_empty, print_empty = FALSE)

# Different osp_print_* functions work well together

    Code
      osp_print_class(my_object)
    Message
      <myClass>
    Code
      osp_print_items(my_object$named_items, title = "Named Items")
    Message
      Named Items:
        * A: 1
        * B: 2
        * C: 3
    Code
      osp_print_header("Nested Item List", 2)
    Message
      
      -- Nested Item List --
      
    Code
      purrr::iwalk(my_object$nested_item_list, function(x, idx) osp_print_items(x,
        title = idx))
    Message
      sub_list_1:
        * D: 4
        * E: 5
      sub_list_2:
        * F: 6
        * G: 7

