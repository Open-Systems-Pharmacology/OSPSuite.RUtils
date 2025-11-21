# Validate that a vector has only unique values

Validate that a vector has only unique values

## Usage

``` r
hasOnlyDistinctValues(values, na.rm = TRUE)

validateHasOnlyDistinctValues(values, na.rm = TRUE)
```

## Arguments

- values:

  An array of values

- na.rm:

  Logical to decide if missing values should be removed from the
  duplicate checking. Note that duplicate `NA` values are flagged if
  `na.rm=FALSE`.

## Value

- `hasOnlyDistinctValues` returns `TRUE` if all values are unique.

- `validateHasOnlyDistinctValues()` returns `NULL` if only unique values
  present, otherwise produces error.

## Examples

``` r
hasOnlyDistinctValues(c("x", "y"))
#> [1] TRUE
hasOnlyDistinctValues(c("x", "y", "x"))
#> [1] FALSE
hasOnlyDistinctValues(c("x", NA, "y", NA), na.rm = FALSE)
#> [1] FALSE
hasOnlyDistinctValues(c("x", NA, "y", NA), na.rm = TRUE)
#> [1] TRUE

validateHasOnlyDistinctValues(c("x", "y")) # NULL
#> NULL
# validateHasOnlyDistinctValues(c("x", "y", "x")) # error
```
