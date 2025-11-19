# Validate if the provided object is empty

Validate if the provided object is empty

## Usage

``` r
isEmpty(object)

validateIsNotEmpty(object)
```

## Arguments

- object:

  An object or an atomic vector or a list of objects.

## Value

- `isEmpty()` returns `TRUE` if the object is empty; `FALSE` otherwise.

- `validateIsNotEmpty()` returns `NULL` if validation is successful.
  Otherwise, error is signaled.

## Examples

``` r
# empty list or data.frame
isEmpty(NULL)
#> [1] TRUE
isEmpty(numeric())
#> [1] TRUE
isEmpty(list())
#> [1] TRUE
isEmpty(data.frame())
#> [1] TRUE

# accounts for filtering of arrays and data.frame
df <- data.frame(x = c(1, 2, 3), y = c(4, 5, 6))
isEmpty(df)
#> [1] FALSE
isEmpty(df$x[FALSE])
#> [1] TRUE
isEmpty(df[FALSE, ])
#> [1] TRUE

# validation helper
validateIsNotEmpty(list(1, 2)) # NULL
#> NULL
# validateIsNotEmpty(NULL) # error
```
