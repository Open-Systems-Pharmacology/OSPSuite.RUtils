# Create Logical Option Specification

Create Logical Option Specification

## Usage

``` r
logicalOption(nullAllowed = FALSE, naAllowed = FALSE, expectedLength = 1)
```

## Arguments

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

An S3 object of class `optionSpec_logical` and `optionSpec`.
