# Validate if a file is UTF-8 encoded.

Validate if a file is UTF-8 encoded.

## Usage

``` r
validateIsFileUTF8(file)
```

## Arguments

- file:

  A name of the file or full path.

## Value

If validations are successful, `validateIsFileUTF8()` returns `NULL`.
Otherwise, error is signaled.

## Examples

``` r
writeLines(c("Hello, world!"), "utf.txt")
writeLines(c("Hello, world!", "\xb5g/L"), "non-utf.txt")

validateIsFileUTF8("utf.txt") # NULL
#> NULL
if (FALSE) { # \dontrun{
validateIsFileUTF8("non-utf.txt") # Error
} # }

```
