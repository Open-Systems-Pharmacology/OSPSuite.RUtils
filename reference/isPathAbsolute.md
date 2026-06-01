# Check if path is absolute

Relative paths will be detected based on the presence of wildcard
character(\*) in the path specification.

## Usage

``` r
isPathAbsolute(path)

validateIsPathAbsolute(path)

validatePathIsAbsolute(path)
```

## Arguments

- path:

  A valid file path name.

## Value

- `isPathAbsolute()` returns `TRUE` if path is absolute (no wildcard);
  `FALSE` otherwise.

- `validateIsPathAbsolute()` returns `NULL` if path is absolute.
  Otherwise, error is signaled.

## Examples

``` r
# check if path is absolute
isPathAbsolute("Organism|path") # TRUE
#> [1] TRUE
isPathAbsolute("Organism|*path") # FALSE
#> [1] FALSE

# validation: no error if path is absolute
validateIsPathAbsolute("Organism|path")
#> NULL

# validation: error otherwise
# validateIsPathAbsolute("Organism|*path")
```
