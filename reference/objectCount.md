# Count number of objects

Count number of objects

## Usage

``` r
objectCount(x)
```

## Arguments

- x:

  An object (an atomic vector, a list, or instance(s) of a class).

## Value

Integer representing the count of objects.

## Details

Classes in R can roughly be distinguished as following:

- Vector-style classes have the property that
  [`length()`](https://rdrr.io/r/base/length.html) represents number of
  elements (e.g., `factor`, `list`, etc.).

- Record-style (or dataframe or scalar) classes, on the other hand, have
  complex structures to represent a single thing (e.g., `data.frame`,
  `R6`, `lm`, etc.).

This function counts objects differently depending on the entered class:

If the argument is a vector or a vector-style class, it will return the
output from [`length()`](https://rdrr.io/r/base/length.html) function.
Otherwise, it will returns `1`.

For example,

- `length(mtcars)` returns `11`, but `objectCount(mtcars)` will return
  `1`, while

- `length(list(1, 2))` returns `2`, and `objectCount(list(1, 2))` will
  return `2` as well.

## Examples

``` r
# vectors or vector-style classes
objectCount(c(1, 2, 3)) # 3
#> [1] 3
objectCount(list("a", "b")) # 2
#> [1] 2
objectCount(list(iris, mtcars)) # 2
#> [1] 2

# everything else
objectCount(mtcars) # 1
#> [1] 1
objectCount(lm(wt ~ mpg, mtcars)) # 1
#> [1] 1
objectCount(new.env()) # 1
#> [1] 1
```
