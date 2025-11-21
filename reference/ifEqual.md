# Value conditional on equality

Short-key checking if arguments 1 and 2 are equal, output argument 3 if
equal, or output argument 4 otherwise.

## Usage

``` r
ifEqual(x, y, outputIfEqual, outputIfNotEqual = NULL)
```

## Arguments

- x:

  argument 1

- y:

  argument 2

- outputIfEqual:

  argument 3

- outputIfNotEqual:

  argument 4

## Examples

``` r
ifEqual(1, 1, "x", "y") # "x"
#> [1] "x"
ifEqual(1, 2, "x", "y") # "y"
#> [1] "y"
```
