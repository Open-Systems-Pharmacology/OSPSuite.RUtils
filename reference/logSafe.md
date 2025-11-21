# Computes logarithm of a number or of a vector of numbers and handles zeros while substituting all values below `epsilon` by `epsilon`.

Computes logarithm of a number or of a vector of numbers and handles
zeros while substituting all values below `epsilon` by `epsilon`.

## Usage

``` r
logSafe(x, base = exp(1), epsilon = ospsuiteUtilsEnv$LOG_SAFE_EPSILON)
```

## Arguments

- x:

  A numeric or a vector of numerics.

- base:

  a positive or complex number: the base with respect to which
  logarithms are computed. Defaults to e = exp(1).

- epsilon:

  A very small number which is considered as threshold below which all
  values are treated as `epsilon`. Allows computation of `log` close
  to 0. Default value is `getOSPSuiteUtilsSetting("LOG_SAFE_EPSILON")`.

## Value

`log(x, base = base)` for `x > epsilon`, or `log(epsilon, base = base)`,
or `NA_real_` for `NA` elements.

## Examples

``` r
inputVector <- c(NA, 1, 5, 0, -1)
logSafe(inputVector)
#> [1]         NA   0.000000   1.609438 -46.051702 -46.051702
```
