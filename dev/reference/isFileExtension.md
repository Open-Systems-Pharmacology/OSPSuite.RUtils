# Validate if the provided path has required extension

Validate if the provided path has required extension

## Usage

``` r
isFileExtension(file, extension)

validateIsFileExtension(file, extension)
```

## Arguments

- file:

  A name of the file or full path.

- extension:

  A required extension of the file.

## Value

`isFileExtension()` returns `TRUE` if the file name (or full path)
includes the extension.

If validations are successful, `validateIsFileExtension()` returns
`NULL`. Otherwise, error is signaled.

## Examples

``` r
isFileExtension("enum.R", "R") # TRUE
#> [1] TRUE
isFileExtension("enum.R", "pkml") # FALSE
#> [1] FALSE

validateIsFileExtension("enum.R", "R") # NULL
#> NULL
# validateIsFileExtension("enum.R", "pkml") # error
```
