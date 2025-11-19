# Validate Vector Against Specified Criteria

Validates a vector `x` based on specified criteria, including type
correctness, value range, allowed values, and handling of `NULL` and
`NA` values. If the vector fails any validation, an informative error
message is thrown.

## Usage

``` r
validateVector(
  x,
  type = NULL,
  valueRange = NULL,
  allowedValues = NULL,
  nullAllowed = FALSE,
  naAllowed = FALSE
)

validateVectorRange(x, type, valueRange)

validateVectorValues(x, type, allowedValues = NULL, naAllowed = FALSE)
```

## Arguments

- x:

  Vector to validate.

- type:

  Expected type of elements in `x` ("numeric", "integer", "character",
  "factor", "logical", or "Date"). Type "double" is treated as
  "numeric".

- valueRange:

  Optional vector of length 2 specifying the range of allowed values for
  `x`, applicable to "numeric", "integer", "character", and "Date"
  types.

- allowedValues:

  Optional vector specifying a set of allowed values for `x`.

- nullAllowed:

  Logical flag indicating whether `x` can be `NULL`. Defaults to
  `FALSE`.

- naAllowed:

  Logical flag indicating whether elements in `x` can be `NA`. Defaults
  to `FALSE`.

## Value

Does not return a value explicitly but will stop with a descriptive
error message if any of the validations fail.

## Details

`validateVector` is the primary function for checking a vector against
defined validation criteria. It ensures that `x` meets the type, range,
and allowed value conditions specified. For more detailed validations
related to the value range and allowed values, `validateVectorRange` and
`validateVectorValues` functions are utilized respectively.

## Examples

``` r
validateVector(x = 1:5, type = "integer")
#> NULL
validateVector(x = c(1.2, 2.5), type = "numeric", valueRange = c(1, 3))
#> NULL
validateVector(x = c("a", "b"), type = "character", allowedValues = c("a", "b", "c"))
#> NULL
validateVector(
  x = as.Date("2020-01-01"), type = "Date",
  valueRange = as.Date(c("2020-01-01", "2020-12-31"))
)
#> NULL

# Range validation examples
validateVectorRange(x = c(5, 10), type = "numeric", valueRange = c(1, 10))
#> NULL
validateVectorRange(x = c("a", "b"), type = "character", valueRange = c("a", "c"))
#> NULL
validateVectorRange(
  x = as.Date(c("2020-01-01")), type = "Date",
  valueRange = as.Date(c("2020-01-01", "2020-12-31"))
)
#> NULL
validateVectorRange(x = 1:3, type = "integer", valueRange = c(1L, 5L))
#> NULL

# Allowed values validation examples
validateVectorValues(x = c("a", "b"), type = "character", allowedValues = c("a", "b", "c"))
#> NULL
validateVectorValues(x = c(2L, 4L), type = "integer", allowedValues = c(1L, 2L, 3L, 4L))
#> NULL
validateVectorValues(x = c(TRUE), type = "logical", allowedValues = c(TRUE, FALSE))
#> NULL
```
