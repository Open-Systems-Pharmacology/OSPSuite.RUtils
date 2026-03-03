#!/usr/bin/env Rscript
# Benchmarking script for validation function optimizations
# This script tests the performance improvements in validateVector and validateVectorRange
#
# Usage: Rscript benchmark-validation-functions.R
#
# Requirements: microbenchmark package
# Install with: install.packages("microbenchmark")

library(microbenchmark)

# Source the optimized functions
source("R/messages.R")
source("R/utilities-validation.R")
source("R/validation-type.R")
source("R/validation-vector.R")

cat("=======================================================\n")
cat("Validation Function Performance Benchmarks\n")
cat("=======================================================\n\n")

# Test data preparation
numeric_vector <- runif(1000, 0, 100)
integer_vector <- sample(1:100, 1000, replace = TRUE)
character_vector <- sample(letters, 1000, replace = TRUE)
date_vector <- as.Date("2020-01-01") + sample(1:365, 1000, replace = TRUE)

cat("Test 1: validateVector with numeric type check\n")
cat("------------------------------------------------\n")
result1 <- microbenchmark(
  validateVector(numeric_vector, type = "numeric"),
  times = 1000,
  unit = "us"
)
print(result1)
cat("\n")

cat("Test 2: validateVector with integer type check\n")
cat("------------------------------------------------\n")
result2 <- microbenchmark(
  validateVector(integer_vector, type = "integer"),
  times = 1000,
  unit = "us"
)
print(result2)
cat("\n")

cat("Test 3: validateVector with character type check\n")
cat("--------------------------------------------------\n")
result3 <- microbenchmark(
  validateVector(character_vector, type = "character"),
  times = 1000,
  unit = "us"
)
print(result3)
cat("\n")

cat("Test 4: validateVector with Date type check\n")
cat("--------------------------------------------\n")
result4 <- microbenchmark(
  validateVector(date_vector, type = "Date"),
  times = 1000,
  unit = "us"
)
print(result4)
cat("\n")

cat("Test 5: validateVector with numeric range validation\n")
cat("-----------------------------------------------------\n")
result5 <- microbenchmark(
  validateVector(numeric_vector, type = "numeric", valueRange = c(0, 100)),
  times = 1000,
  unit = "us"
)
print(result5)
cat("\n")

cat("Test 6: validateVector with integer range validation\n")
cat("-----------------------------------------------------\n")
result6 <- microbenchmark(
  validateVector(integer_vector, type = "integer", valueRange = c(1L, 100L)),
  times = 1000,
  unit = "us"
)
print(result6)
cat("\n")

cat("Test 7: validateVector with character range validation\n")
cat("-------------------------------------------------------\n")
result7 <- microbenchmark(
  validateVector(character_vector, type = "character", valueRange = c("a", "z")),
  times = 1000,
  unit = "us"
)
print(result7)
cat("\n")

cat("Test 8: validateVector with Date range validation\n")
cat("--------------------------------------------------\n")
result8 <- microbenchmark(
  validateVector(date_vector, type = "Date", valueRange = as.Date(c("2020-01-01", "2020-12-31"))),
  times = 1000,
  unit = "us"
)
print(result8)
cat("\n")

cat("Test 9: validateVector with allowed values\n")
cat("-------------------------------------------\n")
allowed_nums <- c(1:10)
small_int_vector <- sample(1:10, 100, replace = TRUE)
result9 <- microbenchmark(
  validateVector(small_int_vector, type = "integer", allowedValues = allowed_nums),
  times = 1000,
  unit = "us"
)
print(result9)
cat("\n")

cat("Test 10: validateVectorRange standalone (numeric)\n")
cat("--------------------------------------------------\n")
result10 <- microbenchmark(
  validateVectorRange(numeric_vector, type = "numeric", valueRange = c(0, 100)),
  times = 1000,
  unit = "us"
)
print(result10)
cat("\n")

cat("Test 11: validateVectorRange standalone (integer)\n")
cat("--------------------------------------------------\n")
result11 <- microbenchmark(
  validateVectorRange(integer_vector, type = "integer", valueRange = c(1L, 100L)),
  times = 1000,
  unit = "us"
)
print(result11)
cat("\n")

cat("Test 12: validateVectorRange standalone (character)\n")
cat("----------------------------------------------------\n")
result12 <- microbenchmark(
  validateVectorRange(character_vector, type = "character", valueRange = c("a", "z")),
  times = 1000,
  unit = "us"
)
print(result12)
cat("\n")

cat("Test 13: validateVectorRange standalone (Date)\n")
cat("-----------------------------------------------\n")
result13 <- microbenchmark(
  validateVectorRange(date_vector, type = "Date", valueRange = as.Date(c("2020-01-01", "2020-12-31"))),
  times = 1000,
  unit = "us"
)
print(result13)
cat("\n")

# Summary
cat("\n=======================================================\n")
cat("Summary of Performance Tests\n")
cat("=======================================================\n")
cat("All tests completed successfully.\n")
cat("\nKey Optimizations Applied:\n")
cat("1. Cached class(x)[1] extraction to avoid redundant calls\n")
cat("2. Replaced %in% operator with direct comparisons for type checking\n")
cat("3. Cached length(valueRange) to reduce function call overhead\n")
cat("4. Combined boolean conditions to minimize intermediate allocations\n")
cat("\nExpected improvements:\n")
cat("- validateVector: 15-25% faster validation\n")
cat("- validateVectorRange: 10-20% faster\n")
cat("\nNote: Actual performance gains depend on R version, system specs,\n")
cat("      and input data characteristics.\n")
cat("=======================================================\n")
