# formatNumerics

Render numeric values of an `object` as character using the specified
format:

- If `object` is a data.frame or a list, `formatNumerics` applies on
  each of its fields

- If `object` is of type character or integer, `formatNumerics` renders
  the values as is

- If `object` is of type numeric, `formatNumerics` applies the defined
  format

## Usage

``` r
formatNumerics(
  object,
  digits = ospsuiteUtilsEnv$formatNumericsDigits,
  scientific = FALSE
)
```

## Arguments

- object:

  An R object such as a list, a data.frame, character or numeric values.

- digits:

  Number of decimal digits to render

- scientific:

  Logical value defining if scientific writing is rendered

## Value

Numeric values are rendered as character values. If `object` is a
data.frame or a list, a data.frame or list is returned with numeric
values rendered as character values.

## Examples

``` r
# Format array of numeric values
formatNumerics(log(c(12, 15, 0.3)), digits = 1, scientific = TRUE)
#> [1] "2.5e+00"  "2.7e+00"  "-1.2e+00"

# Format a data.frame
x <- data.frame(parameter = c("a", "b", "c"), value = c(1, 110.4, 6.666))
formatNumerics(x, digits = 2, scientific = FALSE)
#>   parameter  value
#> 1         a   1.00
#> 2         b 110.40
#> 3         c   6.67
```
