# List of functions and strings used to signal error messages

Most of these messages will be relevant only in the context of OSP R
package ecosystem.

## Usage

``` r
messages
```

## Format

An object of class `list` of length 47.

## Value

A string with error message.

## Examples

``` r
# example with string
messages$errorEnumNotAllNames
#> [1] "The enumValues has some but not all names assigned.\nThey must be all assigned or none assigned"

# example with function
messages$errorPropertyReadOnly("age")
#> [1] "Property \033[32m$age\033[39m is readonly"

# example display with warning
warning(messages$errorPropertyReadOnly("age"))
#> Warning: Property $age is readonly

# example display using logs
logInfo(messages$errorPropertyReadOnly("age"))
#> ℹ Info [17/03/2026 - 10:21:47]:  Property $age is readonly
#> 
```
