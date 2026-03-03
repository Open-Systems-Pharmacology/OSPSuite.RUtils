# Benchmarking Scripts

This directory contains benchmarking scripts to test the performance of optimizations made to the `ospsuite.utils` package.

## benchmark_print_optimizations.R

This script benchmarks the performance improvements made to printing and display functions:

### Optimizations Tested

1. **`.isEmpty` function (Task 3.2)**
   - Cached `length()` calls to avoid redundant computation
   - Simplified conditional logic from 3-4 checks to 2-3 checks
   - Combined empty vector and empty list checks
   - **Expected improvement:** 10-15% faster

2. **`ospPrintItems` function (Task 3.1)**
   - Eliminated dual-pass iteration over collections
   - Combined emptiness checking and item collection into a single pass
   - Cached name checking (`has_names`) outside the loop
   - **Expected improvement:** ~40% faster for large lists (50+ items)

### Running the Benchmark

```R
# Install the package first
devtools::install()

# Run the benchmark
source("benchmarks/benchmark_print_optimizations.R")
```

### Benchmark Tests

The script includes comprehensive tests for:

- **`.isEmpty` function:**
  - NULL values
  - NA values
  - Empty strings
  - Empty vectors
  - Empty lists
  - Non-empty single values
  - Non-empty vectors
  - Non-empty lists

- **`ospPrintItems` function:**
  - Small lists (3 items)
  - Medium lists (50 items)
  - Large lists (200 items)
  - Mixed lists with empty and non-empty values
  - All-empty lists
  - Lists with `print_empty = TRUE`
  - Unnamed vectors

### Comparing Performance

To compare the optimized version with the original:

1. Checkout the commit before optimization:
   ```bash
   git checkout <commit-before-optimization>
   ```

2. Install and run the benchmark:
   ```R
   devtools::install()
   source("benchmarks/benchmark_print_optimizations.R")
   ```

3. Save the results

4. Checkout the optimized version:
   ```bash
   git checkout <commit-after-optimization>
   ```

5. Install and run the benchmark again:
   ```R
   devtools::install()
   source("benchmarks/benchmark_print_optimizations.R")
   ```

6. Compare the median/mean execution times

### Dependencies

The benchmark script requires:
- `ospsuite.utils` (the package being benchmarked)
- `microbenchmark` (for precise timing measurements)

Install `microbenchmark` if not already installed:
```R
install.packages("microbenchmark")
```
