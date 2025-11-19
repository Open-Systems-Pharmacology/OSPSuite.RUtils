# Flatten a list to an atomic vector of desired type

Flatten a list to an atomic vector of desired type

## Usage

``` r
flattenList(x, type)
```

## Arguments

- x:

  A list or an atomic vector. If the latter, no change will be made.

- type:

  Type of atomic vector to be returned.

## Value

An atomic vector of desired type.

## Details

The `type` argument will decide which variant from `purrr::flatten()`
family is used to flatten the list.

## Examples

``` r
flattenList(list(1, 2, 3, NA), type = "numeric")
#> [1]  1  2  3 NA
flattenList(list(TRUE, FALSE, NA), type = "integer")
#> [1]  1  0 NA
```
