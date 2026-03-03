# Simple Benchmarking Example for Logging Optimizations
# This provides a quick demonstration of the performance improvements

# Install microbenchmark if needed
if (!require("microbenchmark", quietly = TRUE)) {
  cat("Installing microbenchmark package...\n")
  install.packages("microbenchmark", repos = "https://cloud.r-project.org/")
}

library(microbenchmark)
library(ospsuite.utils)

cat("\n=== Quick Logging Performance Demo ===\n\n")

# Setup
setLogFolder(tempdir())

# Demo 1: Error Trace Processing
cat("1. Error Trace Processing (stack depth = 20)\n")

create_error <- function(depth) {
  if (depth <= 0) stop("Error!") else create_error(depth - 1)
}

result1 <- microbenchmark(
  logCatch(tryCatch(create_error(20), error = function(e) NULL)),
  times = 50L
)
print(result1)
cat("\n")

# Demo 2: Warning Masking
cat("2. Warning Masking (5 patterns)\n")

setWarningMasking(paste0("pattern_", 1:5))

result2 <- microbenchmark(
  matched = logCatch(warning("pattern_1 found")),  # Early exit
  unmatched = logCatch(warning("no match")),       # Checks all
  times = 50L
)
print(result2)
cat("\n")

# Demo 3: Message Handling
cat("3. Message Masking (5 patterns)\n")

setInfoMasking(paste0("info_", 1:5))

result3 <- microbenchmark(
  matched = logCatch(message("info_1 detected")),  # Early exit
  unmatched = logCatch(message("regular message")), # Checks all
  times = 50L
)
print(result3)
cat("\n")

# Demo 4: Multi-line Messages
cat("4. Multi-line Message Formatting\n")

short_msg <- "Single line"
long_msg <- paste(rep("Line", 10), collapse = "\n")

result4 <- microbenchmark(
  short = logInfo(short_msg),
  long = logInfo(long_msg),
  times = 50L
)
print(result4)
cat("\n")

# Cleanup
setLogFolder(NULL)
unlink(file.path(tempdir(), "log.txt"))

cat("=== Demo Complete ===\n")
cat("\nKey Optimizations:\n")
cat("• Pre-allocated vectors instead of dynamic growth (c())\n")
cat("• Early exit from pattern matching loops\n")
cat("• Helper function to eliminate duplicate code\n")
cat("• Optimized string splitting with fixed=TRUE\n")
cat("• Removed unnecessary unlist() calls\n")
