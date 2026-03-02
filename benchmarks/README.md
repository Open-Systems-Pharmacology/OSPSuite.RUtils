# Benchmarks

This directory contains benchmark scripts for performance-critical operations in the `ospsuite.utils` package.

## Running Benchmarks

### Vector Operations Benchmark

To run the vector operations benchmark:

```bash
R --vanilla < benchmarks/benchmark_vector_operations.R
```

Or from within R:

```r
source("benchmarks/benchmark_vector_operations.R")
```

This benchmark compares the performance of optimized implementations of:
- `logSafe()` - Vectorized logarithm with safe handling of edge cases
- `foldSafe()` - Vectorized division with threshold handling

### Results Summary

Based on testing with various vector sizes:

#### logSafe() Optimization
- **Small vectors (100 elements)**: ~5.8x speedup (83% improvement)
- **Medium vectors (1000 elements)**: ~36x speedup (97% improvement)
- **Large vectors (10000 elements)**: ~50x speedup (98% improvement)

#### foldSafe() Optimization
- **Small vectors (100 elements)**: ~1.6x speedup (36% improvement)
- **Large vectors (10000 elements)**: ~4.2x speedup (76% improvement)

### Interpretation

The benchmark runs 100 iterations of each function and reports:
- Mean execution time
- Median execution time
- Minimum execution time
- Maximum execution time
- Overall speedup factor
- Percentage improvement

Performance improvements scale with vector size, demonstrating the efficiency gains from vectorized operations over element-wise processing.
