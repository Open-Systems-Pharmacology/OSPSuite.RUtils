# Check if the provided object is of certain type. If not, stop with an error.

Check if the provided object is of certain type. If not, stop with an
error.

## Usage

``` r
validateIsOfType(object, type, nullAllowed = FALSE)

validateIsCharacter(object, nullAllowed = FALSE)

validateIsString(object, nullAllowed = FALSE)

validateIsNumeric(object, nullAllowed = FALSE)

validateIsInteger(object, nullAllowed = FALSE)

validateIsLogical(object, nullAllowed = FALSE)
```

## Arguments

- object:

  An object or an atomic vector or a list of objects.

- type:

  A single string or a vector of string representation or class of the
  type that should be checked for.

- nullAllowed:

  Boolean flag if `NULL` is accepted for the `object`. If `TRUE`, `NULL`
  always returns `TRUE`, otherwise `NULL` returns `FALSE`. Default is
  `FALSE`.

## Value

`NULL` if the entered object is of expected type, otherwise produces
error. Also accepts `NULL` as an input if `nullAllowed` argument is set
to `TRUE`.

## Examples

``` r
A <- data.frame(
  col1 = c(1, 2, 3),
  col2 = c(4, 5, 6),
  col3 = c(7, 8, 9)
)

validateIsOfType(A, "data.frame")
#> NULL
validateIsInteger(5)
#> NULL
validateIsNumeric(1.2)
#> NULL
validateIsCharacter("x")
#> NULL
validateIsLogical(TRUE)
#> NULL
```
