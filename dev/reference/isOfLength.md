# Check if the provided object has expected length

Check if the provided object has expected length

## Usage

``` r
isOfLength(object, nbElements)

validateIsOfLength(object, nbElements)
```

## Arguments

- object:

  An object or a list of objects

- nbElements:

  number of elements that are supposed in object

## Value

- `isOfLength()` returns `TRUE` if the object or all objects inside the
  list have `nbElements`.

- For `validateIsOfLength()`, if validations are successful, `NULL` is
  returned. Otherwise, error is signaled.

## Note

Only the first level of the given list is considered.

## Examples

``` r
df <- data.frame(x = c(1, 2, 3))

isOfLength(df, 1) # TRUE
#> [1] TRUE
isOfLength(df, 3) # FALSE
#> [1] FALSE

validateIsOfLength(list(1, 2), 2L) # NULL
#> NULL
# validateIsOfLength(c("3", "4"), 3L) # error
```
