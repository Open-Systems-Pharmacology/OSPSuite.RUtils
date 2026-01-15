# logError

Log error with time stamp

## Usage

``` r
logError(msg)
```

## Arguments

- msg:

  Character values of message to log that leverages `cli` formatting.

## Examples

``` r
# Log error
logError(cliFormat("This is an {.strong error} message"))
#> ✖ Error [15/01/2026 - 12:04:00]:  This is an error message
#> 

# Log error with indications
logError(cliFormat(
  "This is an {.strong error} message",
  "Check these {.val values} or this {.fn function}"
))
#> ✖ Error [15/01/2026 - 12:04:00]:  This is an error message
#> → Check these "values" or this `function()`
#> 
```
