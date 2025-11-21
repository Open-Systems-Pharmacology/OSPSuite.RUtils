# Create Integer Option Specification

Create Integer Option Specification

## Usage

``` r
integerOption(
  min = -Inf,
  max = Inf,
  nullAllowed = FALSE,
  naAllowed = FALSE,
  expectedLength = 1
)
```

## Arguments

- min:

  Minimum allowed value. Defaults to `-Inf`.

- max:

  Maximum allowed value. Defaults to `Inf`.

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

An S3 object of class `optionSpec_integer` and `optionSpec`.
