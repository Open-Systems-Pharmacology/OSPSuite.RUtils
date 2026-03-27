# logCatch

Catch errors, log and display meaningful information

## Usage

``` r
logCatch(expr)
```

## Arguments

- expr:

  Evaluated code chunks

## Examples

``` r
# Catch and display warning message
logCatch({
  warning("This is a warning message")
})
#> WARN [2026-03-27 09:47:53] This is a warning message
```
