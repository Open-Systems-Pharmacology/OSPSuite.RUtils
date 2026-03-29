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
#> ! Warning [29/03/2026 - 16:45:51]:  This is a warning message
#> 
```
