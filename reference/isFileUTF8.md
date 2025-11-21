# Assess if a file is UTF-8 encoded.

Assess if a file is UTF-8 encoded.

## Usage

``` r
isFileUTF8(file)
```

## Arguments

- file:

  A name of the file or full path.

## Value

A logical assessing whether there is non UTF-8 encoded characters in
`file`

## Examples

``` r
writeLines(c("Hello, world!"), "utf.txt")
writeLines(c("Hello, world!", "\xb5g/L"), "non-utf.txt")

isFileUTF8("utf.txt") # TRUE
#> [1] TRUE
isFileUTF8("non-utf.txt") # FALSE
#> [1] FALSE

```
