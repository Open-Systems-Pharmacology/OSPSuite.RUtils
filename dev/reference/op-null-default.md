# Default value for `NULL`

Convenience function to avoid testing for `NULL`.

## Usage

``` r
x %||% y
```

## Arguments

- x, y:

  If `x` is `NULL`, will return `y`; otherwise returns `x`.

## Value

The first object if it is not `NULL` otherwise the second object.

## Examples

``` r
1 %||% 2
#> [1] 1
NULL %||% 2
#> [1] 2
```
