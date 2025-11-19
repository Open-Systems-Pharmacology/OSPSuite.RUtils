# Check if an enum has a certain key.

Check if an enum has a certain key.

## Usage

``` r
enumHasKey(key, enum)
```

## Arguments

- key:

  Key to check for.

- enum:

  Enum where to look for the `key`.

## Value

`TRUE` if a key-value pair for `key` exists, `FALSE` otherwise.

## See also

Other enumeration-helpers:
[`enum()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enum.md),
[`enumGetKey()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enumGetKey.md),
[`enumGetValue()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enumGetValue.md),
[`enumKeys()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enumKeys.md),
[`enumPut()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enumPut.md),
[`enumRemove()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enumRemove.md),
[`enumValues()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enumValues.md)

## Examples

``` r
Symbol <- enum(c(Diamond = 1, Triangle = 2, Circle = 2))
enumHasKey("Diamond", Symbol)
#> [1] TRUE
enumHasKey("Square", Symbol)
#> [1] FALSE
```
