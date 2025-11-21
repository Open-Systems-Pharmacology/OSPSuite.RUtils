# Get all keys of an enum

Get all keys of an enum

## Usage

``` r
enumKeys(enum)
```

## Arguments

- enum:

  `enum` containing the keys.

## Value

List of `key` names.

## See also

Other enumeration-helpers:
[`enum()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enum.md),
[`enumGetKey()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumGetKey.md),
[`enumGetValue()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumGetValue.md),
[`enumHasKey()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumHasKey.md),
[`enumPut()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumPut.md),
[`enumRemove()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumRemove.md),
[`enumValues()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumValues.md)

## Examples

``` r
Symbol <- enum(c(Diamond = 1, Triangle = 2, Circle = 2))
enumKeys(Symbol)
#> [1] "Diamond"  "Triangle" "Circle"  
```
