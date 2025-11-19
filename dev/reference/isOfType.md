# Check if the provided object is of certain type

Check if the provided object is of certain type

## Usage

``` r
isOfType(object, type, nullAllowed = FALSE)
```

## Arguments

- object:

  An object or an atomic vector or a list of objects.

- type:

  A single string or a vector of string representation or class of the
  type that should be checked for.

- nullAllowed:

  Boolean flag if `NULL` is accepted for the `object`. If `TRUE`, `NULL`
  always returns `TRUE`, otherwise `NULL` returns `FALSE`. Default is
  `FALSE`.

## Value

`TRUE` if the object or all objects inside the list are of the given
type.

## Note

Only the first level of the given list is considered.

## Examples

``` r
# checking type of a single object
df <- data.frame(x = c(1, 2, 3))
isOfType(df, "data.frame")
#> [1] TRUE
```
