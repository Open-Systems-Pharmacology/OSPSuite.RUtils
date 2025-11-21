# Check if a vector of values is included in another vector of values

Check if a vector of values is included in another vector of values

## Usage

``` r
isIncluded(values, parentValues)

validateIsIncluded(values, parentValues, nullAllowed = FALSE)
```

## Arguments

- values:

  A vector of values.

- parentValues:

  A vector of values where `values` are checked for inclusion.

- nullAllowed:

  Boolean flag if `NULL` is accepted for the `object`. If `TRUE`, `NULL`
  always returns `TRUE`, otherwise `NULL` returns `FALSE`. Default is
  `FALSE`.

## Value

- `isIncluded()` returns `TRUE` if the value or **all** `values` (if
  it's a vector) are present in the `parentValues`; `FALSE` otherwise.

- `validateIsIncluded()` returns `NULL` if child value is included in
  parent value set, otherwise error is signaled.

## Examples

``` r
# check if a column is present in dataframe
A <- data.frame(
  col1 = c(1, 2, 3),
  col2 = c(4, 5, 6),
  col3 = c(7, 8, 9)
)
isIncluded("col3", names(A)) # TRUE
#> [1] TRUE

# check if single element is present in a vector (atomic or non-atomic)
isIncluded("x", list("w", "x", 1, 2)) # TRUE
#> [1] TRUE
isIncluded("x", c("w", "a", "y")) # FALSE
#> [1] FALSE

# check if **all** values (if it's a vector) are contained in parent values
isIncluded(c("x", "y"), c("a", "y", "b", "x")) # TRUE
#> [1] TRUE
isIncluded(list("x", 1), list("a", "b", "x", 1)) # TRUE
#> [1] TRUE
isIncluded(c("x", "y"), c("a", "b", "x")) # FALSE
#> [1] FALSE
isIncluded(list("x", 1), list("a", "b", "x")) # FALSE
#> [1] FALSE

# corresponding validation
validateIsIncluded("col3", names(A)) # NULL
#> NULL
# validateIsIncluded("col6", names(A)) # error
```
