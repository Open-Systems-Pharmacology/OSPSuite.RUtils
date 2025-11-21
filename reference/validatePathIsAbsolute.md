# Check if path is absolute

Relative paths will be detected based on the presence of wildcard
character(\*) in the path specification.

## Usage

``` r
validatePathIsAbsolute(path)
```

## Arguments

- path:

  A valid file path name.

## Value

Error in case a relative path is found, otherwise no output will be
returned.

## Examples

``` r
# no error if path is absolute
validatePathIsAbsolute("Organism|path")
#> NULL

# error otherwise
# validatePathIsAbsolute("Organism|*path")
```
