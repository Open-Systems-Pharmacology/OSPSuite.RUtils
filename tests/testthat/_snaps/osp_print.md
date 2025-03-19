# OspPrintClass prints class name correctly

    Code
      OspPrintClass(data.frame(x = 1:3, y = letters[1:3]))
    Message
      <data.frame>

---

    Code
      OspPrintClass(list(a = 1, b = 2))
    Message
      <list>

---

    Code
      OspPrintClass(1:5)
    Message
      <integer>

---

    Code
      OspPrintClass(myClass$new())
    Message
      <myClass>

# OspPrintHeader prints headers at different levels

    Code
      OspPrintHeader("Main Title", 1)
    Message
      
      -- Main Title ------------------------------------------------------------------

---

    Code
      OspPrintHeader("Section Title", 2)
    Message
      
      -- Section Title --
      

---

    Code
      OspPrintHeader("Subsection Title", 3)
    Message
      
      -- Subsection Title 

# OspPrintItems prints items correctly

    Code
      OspPrintItems(person)
    Message
        * name: John
        * age: 30
        * job: Developer

---

    Code
      OspPrintItems(colors)
    Message
        * red
        * green
        * blue

---

    Code
      OspPrintItems(my_list)
    Message
        * id: 123
        * values: 1, 2, 3
        * name: Test

---

    Code
      OspPrintItems(mixed)
    Message
        * a: A
        * B
        * c: C

---

    Code
      OspPrintItems(letters_vec, title = "Letters")
    Message
      Letters:
        * A
        * B
        * C

---

    Code
      OspPrintItems(numbered_letters, title = "Letters")
    Message
      Letters:
        * A: 1
        * B: 2
        * C: 3

# OspPrintItems handles empty values correctly

    Code
      OspPrintItems(empty_list, title = "Empty List", print_empty = TRUE)
    Message
      Empty List:

---

    Code
      OspPrintItems(empty_list, title = "Empty List", print_empty = FALSE)
    Message
      Empty List:

---

    Code
      OspPrintItems(empty_vector, title = "Empty Vector", print_empty = TRUE)
    Message
      Empty Vector:

---

    Code
      OspPrintItems(empty_vector, title = "Empty Vector", print_empty = FALSE)
    Message
      Empty Vector:

---

    Code
      OspPrintItems(list_with_nulls, title = "Parameters", print_empty = TRUE)
    Message
      Parameters:
        * Min: NULL
        * Max: 100
        * Unit: NA
        * EmptyVec: <empty vector>
        * EmptyList: <empty list>

---

    Code
      OspPrintItems(list_with_nulls, title = "Parameters", print_empty = FALSE)
    Message
      Parameters:
        * Max: 100

---

    Code
      OspPrintItems(all_empty_list, title = "All Empty", print_empty = TRUE)
    Message
      All Empty:
        * A: NULL
        * B: NA
        * C: <empty string>
        * D: <empty list>
        * E: <empty vector>

---

    Code
      OspPrintItems(all_empty_list, title = "All Empty", print_empty = FALSE)
    Message
      All Empty:
        * All items are NULL, NA, or empty

---

    Code
      OspPrintItems(unnamed_mixed, title = "Unnamed Mixed", print_empty = TRUE)
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
      OspPrintItems(unnamed_mixed, title = "Unnamed Mixed", print_empty = FALSE)
    Message
      Unnamed Mixed:
        * 1

# Different OspPrint* functions work well together

    Code
      OspPrintClass(my_object)
    Message
      <myClass>
    Code
      OspPrintItems(my_object$named_items, title = "Named Items")
    Message
      Named Items:
        * A: 1
        * B: 2
        * C: 3
    Code
      OspPrintHeader("Nested Item List", 2)
    Message
      
      -- Nested Item List --
      
    Code
      purrr::iwalk(my_object$nested_item_list, function(x, idx) OspPrintItems(x,
        title = idx))
    Message
      sub_list_1:
        * D: 4
        * E: 5
      sub_list_2:
        * F: 6
        * G: 7

