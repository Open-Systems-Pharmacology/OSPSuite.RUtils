# Validate that no empty string is present

Validate that no empty string is present

## Usage

``` r
hasEmptyStrings(x)

validateHasOnlyNonEmptyStrings(x)
```

## Arguments

- x:

  A character string or a vector of character strings.

## Value

- `hasEmptyStrings()` returns `TRUE` if any of the strings are empty;
  `FALSE` otherwise.

- `validateHasOnlyNonEmptyStrings()` produces an error if empty string
  are present. It returns `NULL` otherwise.

## Details

If any of the following conditions are met, the input string is
considered empty:

- if any `NA`s are present (e.g. `x = c("a", "abc", NA)`)

- if string is empty (e.g. `x = list("a", "abc", "")`)

- if length is 0 (e.g. `x = character()`)

## Examples

``` r
hasEmptyStrings(c("x", "y")) # FALSE
#> [1] FALSE
hasEmptyStrings(list("x", "y")) # FALSE
#> [1] FALSE
hasEmptyStrings("   abc   ") # FALSE
#> [1] FALSE
hasEmptyStrings(c("", "y")) # TRUE
#> [1] TRUE
hasEmptyStrings(list("", "y")) # TRUE
#> [1] TRUE
hasEmptyStrings(NA) # TRUE
#> [1] TRUE
hasEmptyStrings(character(0)) # TRUE
#> [1] TRUE
hasEmptyStrings(c(NA, "x", "y")) # TRUE
#> [1] TRUE

validateHasOnlyNonEmptyStrings(c("x", "y")) # NULL
validateHasOnlyNonEmptyStrings(list("x", "y")) # NULL
validateHasOnlyNonEmptyStrings("   abc   ") # NULL
# validateHasOnlyNonEmptyStrings(c("", "y")) # error
# validateHasOnlyNonEmptyStrings(list("", "y")) # error
# validateHasOnlyNonEmptyStrings(NA) # error
# validateHasOnlyNonEmptyStrings(character(0)) # error
# validateHasOnlyNonEmptyStrings(c(NA, "x", "y")) # error
```
