# logWarning

Log warning with time stamp

## Usage

``` r
logWarning(msg)
```

## Arguments

- msg:

  Character values of message to log that leverages `cli` formatting.

## Examples

``` r
# Log warning
logWarning(cliFormat("This is a {.strong warning} message"))
#> ! Warning [21/11/2025 - 14:28:06]:  This is a warning message
#> 
```
