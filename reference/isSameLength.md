# Validate if objects are of same length

Validate if objects are of same length

## Usage

``` r
isSameLength(...)

validateIsSameLength(...)
```

## Arguments

- ...:

  Objects to compare.

## Value

- `isSameLength()` returns `TRUE` if all objects have same lengths.

- For `validateIsSameLength()`, if validations are successful, `NULL` is
  returned. Otherwise, error is signaled.

## Examples

``` r
# compare length of only 2 objects
isSameLength(mtcars, ToothGrowth) # FALSE
#> [1] FALSE
isSameLength(cars, BOD) # TRUE
#> [1] TRUE

# or more number of objects
isSameLength(c(1, 2), c(TRUE, FALSE), c("x", "y")) # TRUE
#> [1] TRUE
isSameLength(list(1, 2), list(TRUE, FALSE), list("x")) # FALSE
#> [1] FALSE

# validation
validateIsSameLength(list(1, 2), c("3", "4")) # NULL
#> NULL
# validateIsSameLength(list(1, 2), c("3", "4"), c(FALSE)) # error
```
