# List of functions and strings used to signal error messages

Most of these messages will be relevant only in the context of OSP R
package ecosystem.

## Usage

``` r
messages
```

## Format

An object of class `list` of length 48.

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
#> ℹ Info [15/01/2026 - 11:55:23]:  Property $age is readonly
#> 
```
