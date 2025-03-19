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

# osp_print_items handles empty values correctly

    Code
      osp_print_items(empty_list, title = "Empty List", print_empty = TRUE)
    Message
      Empty List:
        * Empty list

---

    Code
      osp_print_items(empty_list, title = "Empty List", print_empty = FALSE)
    Message
      Empty List:

---

    Code
      osp_print_items(empty_vector, title = "Empty Vector", print_empty = TRUE)
    Message
      Empty Vector:
        * Empty vector

---

    Code
      osp_print_items(empty_vector, title = "Empty Vector", print_empty = FALSE)
    Message
      Empty Vector:

---

    Code
      osp_print_items(list_with_nulls, title = "Parameters", print_empty = TRUE)
    Message
      Parameters:
        * Min: NULL
        * Max: 100
        * Unit: NA
        * EmptyVec: <empty vector>
        * EmptyList: <empty list>

---

    Code
      osp_print_items(list_with_nulls, title = "Parameters", print_empty = FALSE)
    Message
      Parameters:
        * Max: 100
        * EmptyList: <empty list>

---

    Code
      osp_print_items(all_empty_list, title = "All Empty", print_empty = TRUE)
    Message
      All Empty:
        * A: NULL
        * B: NA
        * C: <empty string>
        * D: <empty list>
        * E: <empty vector>

---

    Code
      osp_print_items(all_empty_list, title = "All Empty", print_empty = FALSE)
    Message
      All Empty:
        * D: <empty list>

---

    Code
      osp_print_items(unnamed_mixed, title = "Unnamed Mixed", print_empty = TRUE)
    Message
      Unnamed Mixed:
        * NULL
        * 1
        * NA
        * <empty string>
        * <empty list>
        * <empty vector>

---

    Code
      osp_print_items(unnamed_mixed, title = "Unnamed Mixed", print_empty = FALSE)
    Message
      Unnamed Mixed:
        * 1
        * <empty list>

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

