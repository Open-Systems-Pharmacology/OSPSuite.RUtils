# setWarningMasking

Mask warning messages

## Usage

``` r
setWarningMasking(patterns)
```

## Arguments

- patterns:

  Character patterns to identify with
  [`grepl()`](https://rdrr.io/r/base/grep.html) when masking messages

## Examples

``` r
if (FALSE) { # \dontrun{
# Mask ggplot2 warning message when missing values are found
setWarningMasking("rows containing missing values")
} # }
```
