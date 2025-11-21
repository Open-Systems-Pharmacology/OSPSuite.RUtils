# Assess if a character vector is UTF-8 encoded.

Assess if a character vector is UTF-8 encoded.

## Usage

``` r
isUTF8(text)
```

## Arguments

- text:

  A character vector

## Value

A logical assessing whether there is non UTF-8 encoded characters in
`text`

## Examples

``` r
isUTF8("Hello, world!") # TRUE
#> [1] TRUE
isUTF8("\xb5g/L") # FALSE
#> [1] FALSE
```
