# Benchmarking Script for Logging Infrastructure Optimizations
# This script tests the performance improvements in:
# 1. Error trace processing
# 2. Warning and message masking
# 3. String operations in consoleLayout

# Load required packages
if (!require("microbenchmark", quietly = TRUE)) {
  install.packages("microbenchmark")
}
library(microbenchmark)
library(ospsuite.utils)

cat("=== Logging Infrastructure Performance Benchmarks ===\n\n")

# Setup: Initialize logging
setLogFolder(tempdir())

# ============================================================================
# Benchmark 1: Error Trace Processing
# ============================================================================
cat("1. Error Trace Processing Benchmark\n")
cat("   Testing with various call stack depths...\n\n")

# Create nested function calls to simulate different stack depths
create_nested_calls <- function(depth) {
  if (depth <= 0) {
    stop("Test error")
  } else {
    create_nested_calls(depth - 1)
  }
}

# Test with different stack depths
stack_depths <- c(5, 10, 20, 50)

for (depth in stack_depths) {
  cat(sprintf("   Stack depth: %d\n", depth))
  
  result <- microbenchmark(
    logCatch({
      tryCatch(
        create_nested_calls(depth),
        error = function(e) NULL
      )
    }),
    times = 50L,
    unit = "ms"
  )
  
  print(summary(result)[, c("min", "lq", "mean", "median", "uq", "max")])
  cat("\n")
}

# ============================================================================
# Benchmark 2: Warning Masking Performance
# ============================================================================
cat("2. Warning Masking Benchmark\n")
cat("   Testing pattern matching with various numbers of patterns...\n\n")

# Test with different numbers of masking patterns
pattern_counts <- c(1, 5, 10, 20)

for (count in pattern_counts) {
  # Setup masking patterns
  patterns <- paste0("pattern_", seq_len(count))
  setWarningMasking(patterns)
  
  cat(sprintf("   Number of patterns: %d\n", count))
  
  # Benchmark warning that matches (early in list)
  result_match <- microbenchmark(
    logCatch({
      warning("pattern_1 detected")
    }),
    times = 100L,
    unit = "us"
  )
  
  cat("   Early match (should exit early):\n")
  print(summary(result_match)[, c("min", "lq", "mean", "median", "uq", "max")])
  
  # Benchmark warning that doesn't match (checks all patterns)
  result_no_match <- microbenchmark(
    logCatch({
      warning("no match here")
    }),
    times = 100L,
    unit = "us"
  )
  
  cat("   No match (checks all patterns):\n")
  print(summary(result_no_match)[, c("min", "lq", "mean", "median", "uq", "max")])
  cat("\n")
}

# Reset masking
setWarningMasking(NULL)

# ============================================================================
# Benchmark 3: Message Masking Performance
# ============================================================================
cat("3. Message Masking Benchmark\n")
cat("   Testing pattern matching for messages...\n\n")

for (count in pattern_counts) {
  # Setup masking patterns
  patterns <- paste0("info_pattern_", seq_len(count))
  setInfoMasking(patterns)
  
  cat(sprintf("   Number of patterns: %d\n", count))
  
  # Benchmark message that matches (early in list)
  result_match <- microbenchmark(
    logCatch({
      message("info_pattern_1 detected")
    }),
    times = 100L,
    unit = "us"
  )
  
  cat("   Early match:\n")
  print(summary(result_match)[, c("min", "lq", "mean", "median", "uq", "max")])
  
  # Benchmark message that doesn't match
  result_no_match <- microbenchmark(
    logCatch({
      message("normal message")
    }),
    times = 100L,
    unit = "us"
  )
  
  cat("   No match:\n")
  print(summary(result_no_match)[, c("min", "lq", "mean", "median", "uq", "max")])
  cat("\n")
}

# Reset masking
setInfoMasking(NULL)

# ============================================================================
# Benchmark 4: consoleLayout String Operations
# ============================================================================
cat("4. consoleLayout String Operations Benchmark\n")
cat("   Testing with messages of varying line counts...\n\n")

line_counts <- c(1, 5, 10, 20)

for (lines in line_counts) {
  msg <- paste(rep("Test message line", lines), collapse = "\n")
  
  cat(sprintf("   Number of lines: %d\n", lines))
  
  result <- microbenchmark(
    logInfo(msg),
    times = 100L,
    unit = "us"
  )
  
  print(summary(result)[, c("min", "lq", "mean", "median", "uq", "max")])
  cat("\n")
}

# ============================================================================
# Benchmark 5: Combined Scenario - Real-world Usage
# ============================================================================
cat("5. Combined Real-world Scenario Benchmark\n")
cat("   Testing typical usage patterns...\n\n")

# Setup realistic masking patterns
setErrorMasking(c("logCatch", "stop", "tryCatch", "withCallingHandlers"))
setWarningMasking(c("rows containing missing values", "deprecated"))
setInfoMasking(c("Each group consists of only one observation"))

# Simulate real-world scenario with mixed operations
real_world_scenario <- function() {
  logCatch({
    # Normal info message
    message("Processing data...")
    
    # Warning that gets masked
    warning("rows containing missing values removed")
    
    # Normal warning
    warning("This is an important warning")
    
    # Info that gets masked
    message("Each group consists of only one observation")
    
    # Normal info
    message("Operation completed")
  })
}

cat("   Real-world mixed operations:\n")
result <- microbenchmark(
  real_world_scenario(),
  times = 50L,
  unit = "ms"
)

print(summary(result)[, c("min", "lq", "mean", "median", "uq", "max")])
cat("\n")

# ============================================================================
# Summary and Recommendations
# ============================================================================
cat("\n=== Benchmark Summary ===\n")
cat("The optimizations focus on:\n")
cat("1. Pre-allocation and early exit in error trace processing\n")
cat("2. Helper function with early exit for pattern matching\n")
cat("3. Vectorized string operations in consoleLayout\n\n")

cat("Key Performance Indicators:\n")
cat("- Error trace: Faster processing with deep call stacks\n")
cat("- Pattern matching: Early exit reduces time for matching patterns\n")
cat("- String operations: Reduced overhead from unnecessary operations\n\n")

cat("Recommendations:\n")
cat("- Use specific masking patterns at the beginning of the list\n")
cat("- Keep masking pattern lists reasonably sized (<20 patterns)\n")
cat("- Consider pattern complexity (simple patterns are faster)\n\n")

# Cleanup
setLogFolder(NULL)
unlink(file.path(tempdir(), "log.txt"))

cat("=== Benchmarks Complete ===\n")
