# Safe fold calculation

Calculates `x / y` while substituting values below `epsilon` (for x and
y) by `epsilon`. `x` and `y` must be of the same length

## Usage

``` r
foldSafe(x, y, epsilon = ospsuiteUtilsEnv$LOG_SAFE_EPSILON)
```

## Arguments

- x:

  A numeric or a vector of numerics.

- y:

  A numeric or a vector of numerics.

- epsilon:

  A very small number which is considered as threshold below which all
  values are treated as `epsilon`. Allows computation of fold changes
  for values close to 0. Default value is
  `getOSPSuiteUtilsSetting("LOG_SAFE_EPSILON")`.

## Value

A vector with `x / y`.

## Examples

``` r
inputX <- c(NA, 1, 5, 0, -1)
inputY <- c(1, -1, NA, 0, -1)
folds <- foldSafe(inputX, inputY)
```
