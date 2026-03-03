# Quick verification script to test that output is preserved
# This can be run manually to verify the optimizations don't change behavior

# Note: This requires R to be installed and the package to be loaded
# Run with: Rscript benchmarks/verify_output.R

cat("Loading ospsuite.utils package...\n")
library(ospsuite.utils)

cat("\n", rep("=", 70), "\n", sep = "")
cat("Test 1: Named vector\n")
cat(rep("=", 70), "\n", sep = "")
person <- c(name = "John", age = "30", job = "Developer")
ospPrintItems(person, title = "Person Info")

cat("\n", rep("=", 70), "\n", sep = "")
cat("Test 2: Mixed list with empty values (print_empty = FALSE)\n")
cat(rep("=", 70), "\n", sep = "")
mixed_list <- list(a = 1, b = NULL, c = 3, d = NA, e = 5)
ospPrintItems(mixed_list, title = "Mixed List")

cat("\n", rep("=", 70), "\n", sep = "")
cat("Test 3: Mixed list with empty values (print_empty = TRUE)\n")
cat(rep("=", 70), "\n", sep = "")
ospPrintItems(mixed_list, title = "Mixed List (show empty)", print_empty = TRUE)

cat("\n", rep("=", 70), "\n", sep = "")
cat("Test 4: All empty list\n")
cat(rep("=", 70), "\n", sep = "")
all_empty <- list(a = NULL, b = NA, c = "", d = numeric(0))
ospPrintItems(all_empty, title = "All Empty List")

cat("\n", rep("=", 70), "\n", sep = "")
cat("Test 5: Unnamed vector\n")
cat(rep("=", 70), "\n", sep = "")
colors <- c("red", "green", "blue")
ospPrintItems(colors, title = "Colors")

cat("\n", rep("=", 70), "\n", sep = "")
cat("Test 6: Empty list with title\n")
cat(rep("=", 70), "\n", sep = "")
empty_list <- list()
ospPrintItems(empty_list, title = "Empty List")

cat("\n", rep("=", 70), "\n", sep = "")
cat("Test 7: Empty list without title (should be silent)\n")
cat(rep("=", 70), "\n", sep = "")
result <- ospPrintItems(list())
cat("(Nothing should be printed above this line)\n")

cat("\n✓ All verification tests completed successfully!\n")
