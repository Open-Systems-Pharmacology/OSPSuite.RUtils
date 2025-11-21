# Make sure the object is a list

Make sure the object is a list

## Usage

``` r
toList(object)
```

## Arguments

- object:

  Object to be converted to a list.

## Value

If `is.list(object) == TRUE`, returns the `object`; otherwise,
`list(object)`.

## Examples

``` r
toList(list("a" = 1, "b" = 2))
#> $a
#> [1] 1
#> 
#> $b
#> [1] 2
#> 
toList(c("a" = 1, "b" = 2))
#> [[1]]
#> a b 
#> 1 2 
#> 
```
