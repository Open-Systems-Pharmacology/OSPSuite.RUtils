#!/usr/bin/env Rscript
#
# Benchmark script for option validation system optimizations
#
# This script measures the performance improvements from optimizing:
# 1. validateIsOption - removing Map() overhead and optimizing error collection
# 2. .normalizeSpec - replacing do.call() with direct function calls
#
# Expected improvement: 15-25% faster validation
#

library(ospsuite.utils)

# Helper function to create test data with various option configurations
create_test_options <- function(n_options = 10) {
  options <- list()
  validOptions <- list()
  
  for (i in seq_len(n_options)) {
    option_name <- paste0("option", i)
    
    # Mix different option types
    option_type <- (i %% 4) + 1
    
    if (option_type == 1) {
      # Integer option
      options[[option_name]] <- sample(1L:100L, 1)
      validOptions[[option_name]] <- integerOption(min = 1L, max = 100L)
    } else if (option_type == 2) {
      # Numeric option
      options[[option_name]] <- runif(1, 0, 1)
      validOptions[[option_name]] <- numericOption(min = 0, max = 1)
    } else if (option_type == 3) {
      # Character option
      options[[option_name]] <- sample(c("a", "b", "c"), 1)
      validOptions[[option_name]] <- characterOption(allowedValues = c("a", "b", "c"))
    } else {
      # Logical option
      options[[option_name]] <- sample(c(TRUE, FALSE), 1)
      validOptions[[option_name]] <- logicalOption()
    }
  }
  
  list(options = options, validOptions = validOptions)
}

# Helper function to create test data with legacy list format (for .normalizeSpec testing)
create_legacy_test_options <- function(n_options = 10) {
  options <- list()
  validOptions <- list()
  
  for (i in seq_len(n_options)) {
    option_name <- paste0("option", i)
    
    # Mix different option types using legacy list format
    option_type <- (i %% 4) + 1
    
    if (option_type == 1) {
      # Integer option
      options[[option_name]] <- sample(1L:100L, 1)
      validOptions[[option_name]] <- list(
        type = "integer",
        valueRange = c(1L, 100L),
        nullAllowed = FALSE,
        naAllowed = FALSE,
        expectedLength = 1
      )
    } else if (option_type == 2) {
      # Numeric option
      options[[option_name]] <- runif(1, 0, 1)
      validOptions[[option_name]] <- list(
        type = "numeric",
        valueRange = c(0, 1),
        nullAllowed = FALSE,
        naAllowed = FALSE,
        expectedLength = 1
      )
    } else if (option_type == 3) {
      # Character option
      options[[option_name]] <- sample(c("a", "b", "c"), 1)
      validOptions[[option_name]] <- list(
        type = "character",
        allowedValues = c("a", "b", "c"),
        nullAllowed = FALSE,
        naAllowed = FALSE,
        expectedLength = 1
      )
    } else {
      # Logical option
      options[[option_name]] <- sample(c(TRUE, FALSE), 1)
      validOptions[[option_name]] <- list(
        type = "logical",
        nullAllowed = FALSE,
        naAllowed = FALSE,
        expectedLength = 1
      )
    }
  }
  
  list(options = options, validOptions = validOptions)
}

# Benchmark 1: Small option set (10 options)
cat("====================================================\n")
cat("Benchmark 1: Small option set (10 options)\n")
cat("====================================================\n\n")

test_data_small <- create_test_options(10)
n_iterations <- 1000

cat("Running", n_iterations, "iterations...\n")
result_small <- system.time({
  for (i in seq_len(n_iterations)) {
    validateIsOption(test_data_small$options, test_data_small$validOptions)
  }
})

cat("\nResults:\n")
cat("  Total time:", result_small["elapsed"], "seconds\n")
cat("  Time per validation:", result_small["elapsed"] / n_iterations * 1000, "ms\n")
cat("  Validations per second:", n_iterations / result_small["elapsed"], "\n\n")

# Benchmark 2: Medium option set (50 options)
cat("====================================================\n")
cat("Benchmark 2: Medium option set (50 options)\n")
cat("====================================================\n\n")

test_data_medium <- create_test_options(50)
n_iterations <- 500

cat("Running", n_iterations, "iterations...\n")
result_medium <- system.time({
  for (i in seq_len(n_iterations)) {
    validateIsOption(test_data_medium$options, test_data_medium$validOptions)
  }
})

cat("\nResults:\n")
cat("  Total time:", result_medium["elapsed"], "seconds\n")
cat("  Time per validation:", result_medium["elapsed"] / n_iterations * 1000, "ms\n")
cat("  Validations per second:", n_iterations / result_medium["elapsed"], "\n\n")

# Benchmark 3: Large option set (100 options)
cat("====================================================\n")
cat("Benchmark 3: Large option set (100 options)\n")
cat("====================================================\n\n")

test_data_large <- create_test_options(100)
n_iterations <- 200

cat("Running", n_iterations, "iterations...\n")
result_large <- system.time({
  for (i in seq_len(n_iterations)) {
    validateIsOption(test_data_large$options, test_data_large$validOptions)
  }
})

cat("\nResults:\n")
cat("  Total time:", result_large["elapsed"], "seconds\n")
cat("  Time per validation:", result_large["elapsed"] / n_iterations * 1000, "ms\n")
cat("  Validations per second:", n_iterations / result_large["elapsed"], "\n\n")

# Benchmark 4: Legacy format normalization overhead
cat("====================================================\n")
cat("Benchmark 4: Legacy format (do.call optimization)\n")
cat("====================================================\n\n")

test_data_legacy <- create_legacy_test_options(50)
n_iterations <- 500

cat("Running", n_iterations, "iterations with legacy list format...\n")
result_legacy <- system.time({
  for (i in seq_len(n_iterations)) {
    validateIsOption(test_data_legacy$options, test_data_legacy$validOptions)
  }
})

cat("\nResults:\n")
cat("  Total time:", result_legacy["elapsed"], "seconds\n")
cat("  Time per validation:", result_legacy["elapsed"] / n_iterations * 1000, "ms\n")
cat("  Validations per second:", n_iterations / result_legacy["elapsed"], "\n\n")

# Benchmark 5: Error collection performance
cat("====================================================\n")
cat("Benchmark 5: Error collection performance\n")
cat("====================================================\n\n")

# Create options that will cause validation errors
test_data_errors <- create_test_options(20)
# Corrupt half of the options to trigger errors
for (i in seq(1, 20, by = 2)) {
  option_name <- paste0("option", i)
  test_data_errors$options[[option_name]] <- "invalid"
}

n_iterations <- 100

cat("Running", n_iterations, "iterations with validation errors...\n")
result_errors <- system.time({
  for (i in seq_len(n_iterations)) {
    tryCatch(
      validateIsOption(test_data_errors$options, test_data_errors$validOptions),
      error = function(e) NULL  # Ignore errors
    )
  }
})

cat("\nResults:\n")
cat("  Total time:", result_errors["elapsed"], "seconds\n")
cat("  Time per validation:", result_errors["elapsed"] / n_iterations * 1000, "ms\n")
cat("  Validations per second:", n_iterations / result_errors["elapsed"], "\n\n")

# Summary
cat("====================================================\n")
cat("SUMMARY\n")
cat("====================================================\n\n")
cat("Benchmark                          | Time per validation | Validations/sec\n")
cat("-----------------------------------+--------------------+----------------\n")
cat(sprintf("Small (10 options)              | %7.3f ms          | %8.1f\n",
            result_small["elapsed"] / 1000 * 1000, 1000 / result_small["elapsed"]))
cat(sprintf("Medium (50 options)             | %7.3f ms          | %8.1f\n",
            result_medium["elapsed"] / 500 * 1000, 500 / result_medium["elapsed"]))
cat(sprintf("Large (100 options)             | %7.3f ms          | %8.1f\n",
            result_large["elapsed"] / 200 * 1000, 200 / result_large["elapsed"]))
cat(sprintf("Legacy format (50 options)      | %7.3f ms          | %8.1f\n",
            result_legacy["elapsed"] / 500 * 1000, 500 / result_legacy["elapsed"]))
cat(sprintf("With errors (20 options)        | %7.3f ms          | %8.1f\n",
            result_errors["elapsed"] / 100 * 1000, 100 / result_errors["elapsed"]))
cat("\n")

cat("Optimizations implemented:\n")
cat("1. Replaced Map() with simple for loop in validateIsOption\n")
cat("2. Used character vectors instead of lists for error collection\n")
cat("3. Replaced do.call() with direct function calls in .normalizeSpec\n")
cat("\nExpected improvement: 15-25% faster than previous implementation\n")
cat("\nNote: To compare with the old implementation, run this benchmark\n")
cat("      against a version before the optimizations were applied.\n")
