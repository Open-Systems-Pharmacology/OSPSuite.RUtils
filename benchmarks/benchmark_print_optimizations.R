# Benchmarking script for print optimization changes
# 
# This script benchmarks the performance improvements made to:
# 1. .isEmpty function (Task 3.2)
# 2. ospPrintItems function (Task 3.1)
#
# Expected improvements:
# - .isEmpty: 10-15% faster
# - ospPrintItems: ~40% faster for large lists

library(ospsuite.utils)
library(microbenchmark)

# ==============================================================================
# Benchmark 1: .isEmpty function optimization
# ==============================================================================

cat("=" , rep("=", 79), "\n", sep = "")
cat("Benchmark 1: .isEmpty function optimization\n")
cat("=" , rep("=", 79), "\n", sep = "")

# Access internal function for benchmarking
.isEmpty <- ospsuite.utils:::.isEmpty

# Test data
test_null <- NULL
test_na <- NA
test_empty_string <- ""
test_empty_vector <- numeric(0)
test_empty_list <- list()
test_single_value <- 42
test_vector <- 1:100
test_list <- list(a = 1, b = 2, c = 3)

cat("\nTest 1.1: NULL values\n")
result1 <- microbenchmark(
  .isEmpty(test_null),
  times = 10000
)
print(result1)

cat("\nTest 1.2: NA values\n")
result2 <- microbenchmark(
  .isEmpty(test_na),
  times = 10000
)
print(result2)

cat("\nTest 1.3: Empty strings\n")
result3 <- microbenchmark(
  .isEmpty(test_empty_string),
  times = 10000
)
print(result3)

cat("\nTest 1.4: Empty vectors\n")
result4 <- microbenchmark(
  .isEmpty(test_empty_vector),
  times = 10000
)
print(result4)

cat("\nTest 1.5: Empty lists\n")
result5 <- microbenchmark(
  .isEmpty(test_empty_list),
  times = 10000
)
print(result5)

cat("\nTest 1.6: Non-empty single values\n")
result6 <- microbenchmark(
  .isEmpty(test_single_value),
  times = 10000
)
print(result6)

cat("\nTest 1.7: Non-empty vectors\n")
result7 <- microbenchmark(
  .isEmpty(test_vector),
  times = 10000
)
print(result7)

cat("\nTest 1.8: Non-empty lists\n")
result8 <- microbenchmark(
  .isEmpty(test_list),
  times = 10000
)
print(result8)

# ==============================================================================
# Benchmark 2: ospPrintItems function optimization
# ==============================================================================

cat("\n\n")
cat("=" , rep("=", 79), "\n", sep = "")
cat("Benchmark 2: ospPrintItems function optimization\n")
cat("=" , rep("=", 79), "\n", sep = "")

# Helper to capture and discard output
capture_print <- function(expr) {
  capture.output(expr, file = nullfile())
}

# Test data sets of varying sizes
small_list <- list(a = 1, b = 2, c = 3)
medium_list <- setNames(as.list(1:50), paste0("item", 1:50))
large_list <- setNames(as.list(1:200), paste0("item", 1:200))

# List with mixed empty and non-empty values
mixed_list_small <- list(
  a = 1, b = NULL, c = 3, d = NA, e = 5,
  f = "", g = 7, h = numeric(0), i = 9, j = list()
)

mixed_list_large <- list()
for (i in 1:100) {
  if (i %% 3 == 0) {
    mixed_list_large[[paste0("item", i)]] <- NULL
  } else if (i %% 5 == 0) {
    mixed_list_large[[paste0("item", i)]] <- NA
  } else if (i %% 7 == 0) {
    mixed_list_large[[paste0("item", i)]] <- ""
  } else {
    mixed_list_large[[paste0("item", i)]] <- i
  }
}

# All empty list
all_empty_list <- list(
  a = NULL, b = NA, c = "", d = numeric(0), e = list(),
  f = NULL, g = NA, h = "", i = numeric(0), j = list()
)

cat("\nTest 2.1: Small list (3 items)\n")
result9 <- microbenchmark(
  capture_print(ospPrintItems(small_list, title = "Small List")),
  times = 1000
)
print(result9)

cat("\nTest 2.2: Medium list (50 items)\n")
result10 <- microbenchmark(
  capture_print(ospPrintItems(medium_list, title = "Medium List")),
  times = 500
)
print(result10)

cat("\nTest 2.3: Large list (200 items)\n")
result11 <- microbenchmark(
  capture_print(ospPrintItems(large_list, title = "Large List")),
  times = 100
)
print(result11)

cat("\nTest 2.4: Small mixed list (empty and non-empty values)\n")
result12 <- microbenchmark(
  capture_print(ospPrintItems(mixed_list_small, title = "Mixed List")),
  times = 1000
)
print(result12)

cat("\nTest 2.5: Large mixed list (100 items, some empty)\n")
result13 <- microbenchmark(
  capture_print(ospPrintItems(mixed_list_large, title = "Large Mixed List")),
  times = 100
)
print(result13)

cat("\nTest 2.6: All empty list (should show special message)\n")
result14 <- microbenchmark(
  capture_print(ospPrintItems(all_empty_list, title = "All Empty List")),
  times = 1000
)
print(result14)

cat("\nTest 2.7: Large mixed list with print_empty = TRUE\n")
result15 <- microbenchmark(
  capture_print(ospPrintItems(mixed_list_large, title = "Large Mixed List", print_empty = TRUE)),
  times = 100
)
print(result15)

cat("\nTest 2.8: Unnamed vector (100 items)\n")
unnamed_vector <- 1:100
result16 <- microbenchmark(
  capture_print(ospPrintItems(unnamed_vector, title = "Unnamed Vector")),
  times = 100
)
print(result16)

# ==============================================================================
# Summary
# ==============================================================================

cat("\n\n")
cat("=" , rep("=", 79), "\n", sep = "")
cat("Summary\n")
cat("=" , rep("=", 79), "\n", sep = "")

cat("\n")
cat("Optimizations implemented:\n")
cat("1. .isEmpty: Cached length() call, reduced from 3-4 conditional checks to 2-3\n")
cat("   - Expected improvement: 10-15% faster\n")
cat("   - Most benefit seen in empty vector/list checks\n")
cat("\n")
cat("2. ospPrintItems: Eliminated dual-pass iteration\n")
cat("   - Before: First pass to check emptiness, second pass to print\n")
cat("   - After: Single pass collecting items and tracking emptiness simultaneously\n")
cat("   - Expected improvement: ~40% faster for large lists\n")
cat("   - Most benefit seen with lists containing 50+ items\n")
cat("\n")
cat("Key changes:\n")
cat("- Reduced redundant .isEmpty() calls during iteration\n")
cat("- Eliminated separate counting pass\n")
cat("- Cached name checking (has_names) outside loop\n")
cat("- Pre-allocated items_to_print as list instead of iterating twice\n")
cat("\n")
cat("To compare with previous version:\n")
cat("1. Checkout the commit before optimization\n")
cat("2. Run this benchmark script\n")
cat("3. Checkout the optimized version\n")
cat("4. Run this benchmark script again\n")
cat("5. Compare the median/mean execution times\n")
cat("\n")
