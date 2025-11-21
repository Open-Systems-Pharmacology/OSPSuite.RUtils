# Convert special constants to `NA` of desired type

Convert special constants to `NA` of desired type

## Usage

``` r
toMissingOfType(x, type)
```

## Arguments

- x:

  A single element.

- type:

  Type of atomic vector to be returned.

## Details

Special constants (`NULL`, `Inf`, `-Inf`, `NaN`, `NA`) will be converted
to `NA` of desired type.

This function is **not** vectorized, and therefore only scalar values
should be entered.

## Examples

``` r
toMissingOfType(NA, type = "real")
#> [1] NA
toMissingOfType(NULL, type = "integer")
#> [1] NA
```
