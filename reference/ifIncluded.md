# Value conditional on inclusion

Shortkey checking if arguments 1 is included in 2, output argument 3 if
included, or output argument 4 otherwise.

## Usage

``` r
ifIncluded(x, y, outputIfIncluded, outputIfNotIncluded = NULL)
```

## Arguments

- x:

  argument 1

- y:

  argument 2

- outputIfIncluded:

  argument 3

- outputIfNotIncluded:

  argument 4

## Examples

``` r
ifIncluded("a", c("a", "b"), 1, 2) # 1
#> [1] 1
ifIncluded("x", c("a", "b"), 1, 2) # 2
#> [1] 2
```
