# Check if `value` is in the given `enum`. If not, stops with an error.

Check if `value` is in the given `enum`. If not, stops with an error.

## Usage

``` r
validateEnumValue(value, enum, nullAllowed = FALSE)
```

## Arguments

- value:

  A value to search for in the `enum`.

- enum:

  `enum` where the `value` should be contained.

- nullAllowed:

  If `TRUE`, `value` can be `NULL` and the test always passes. If
  `FALSE` (default), `NULL` is not accepted and the test fails.

## Examples

``` r
Symbol <- enum(c(Diamond = 1, Triangle = 2, Circle = 2))
validateEnumValue(1, Symbol)
#> NULL
```
