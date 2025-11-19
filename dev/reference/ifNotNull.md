# Value conditional on `NULL`

Short-key checking if argument 1 is not `NULL`, output the argument 2 if
not null, or output argument 3 otherwise.

Check if condition is not `NULL`, if so output `outputIfNotNull`,
otherwise, output `outputIfNull`.

## Usage

``` r
ifNotNull(condition, outputIfNotNull, outputIfNull = NULL)
```

## Arguments

- condition:

  argument 1

- outputIfNotNull:

  argument 2

- outputIfNull:

  argument 3

## Value

`outputIfNotNull` if condition is not `NULL`, `outputIfNull` otherwise.

## Examples

``` r
ifNotNull(NULL, "x")
#> NULL
ifNotNull(NULL, "x", "y")
#> [1] "y"
ifNotNull(1 < 2, "x", "y")
#> [1] "x"
```
