# setErrorMasking

Mask error trace messages

## Usage

``` r
setErrorMasking(patterns)
```

## Arguments

- patterns:

  Character patterns to identify with
  [`grepl()`](https://rdrr.io/r/base/grep.html) when masking messages

## Examples

``` r
if (FALSE) { # \dontrun{
setErrorMasking(c("tryCatch", "withCallingHandlers"))
} # }
```
