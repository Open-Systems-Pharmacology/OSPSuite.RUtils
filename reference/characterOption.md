# Create Character Option Specification

Create Character Option Specification

## Usage

``` r
characterOption(
  allowedValues = NULL,
  nullAllowed = FALSE,
  naAllowed = FALSE,
  expectedLength = 1
)
```

## Arguments

- allowedValues:

  Vector of permitted values. Defaults to `NULL` (any value allowed).

- nullAllowed:

  Logical flag indicating whether `NULL` is permitted. Defaults to
  `FALSE`.

- naAllowed:

  Logical flag indicating whether `NA` values are permitted. Defaults to
  `FALSE`.

- expectedLength:

  Expected length of the option value. Use `NULL` for any length, `1`
  for scalar (default), or a positive integer for specific length.

## Value

An S3 object of class `optionSpec_character` and `optionSpec`.
