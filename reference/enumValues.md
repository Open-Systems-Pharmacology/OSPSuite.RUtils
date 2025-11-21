# Get the values stored in an enum

Get the values stored in an enum

## Usage

``` r
enumValues(enum)
```

## Arguments

- enum:

  `enum` containing the values

## Value

List of values stored in the `enum`.

## See also

Other enumeration-helpers:
[`enum()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enum.md),
[`enumGetKey()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumGetKey.md),
[`enumGetValue()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumGetValue.md),
[`enumHasKey()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumHasKey.md),
[`enumKeys()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumKeys.md),
[`enumPut()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumPut.md),
[`enumRemove()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumRemove.md)

## Examples

``` r
Symbol <- enum(c(Diamond = 1, Triangle = 2, Circle = 2))
enumValues(Symbol)
#> [1] 1 2 2
```
