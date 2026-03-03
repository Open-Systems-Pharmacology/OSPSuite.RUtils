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
#> ✖ Error [03/03/2026 - 16:05:47]:  This is an error message
#> 

# Log error with indications
logError(cliFormat(
  "This is an {.strong error} message",
  "Check these {.val values} or this {.fn function}"
))
#> ✖ Error [03/03/2026 - 16:05:47]:  This is an error message
#> → Check these "values" or this `function()`
#> 
```
