# setInfoMasking

Mask info messages

## Usage

``` r
setInfoMasking(patterns)
```

## Arguments

- patterns:

  Character patterns to identify with
  [`grepl()`](https://rdrr.io/r/base/grep.html) when masking messages

## Examples

``` r
if (FALSE) { # \dontrun{
# Mask ggplot2 message when line is used with 1 value per group
setInfoMasking("Each group consists of only one observation")
} # }
```
