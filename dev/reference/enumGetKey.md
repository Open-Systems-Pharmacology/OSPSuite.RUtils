# Get the key mapped to the given value in an `enum`

Get the key mapped to the given value in an `enum`

## Usage

``` r
enumGetKey(enum, value)

getEnumKey(enum, value)
```

## Arguments

- enum:

  The `enum` where the key-value pair is stored

- value:

  The value that is mapped to the `key`

## Value

Key under which the value is stored. If the value is not in the enum,
`NULL` is returned.

## See also

Other enumeration-helpers:
[`enum()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enum.md),
[`enumGetValue()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enumGetValue.md),
[`enumHasKey()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enumHasKey.md),
[`enumKeys()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enumKeys.md),
[`enumPut()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enumPut.md),
[`enumRemove()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enumRemove.md),
[`enumValues()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enumValues.md)

## Examples

``` r
Symbol <- enum(c(Diamond = 1, Triangle = 2, Circle = 2))
enumGetKey(Symbol, 1)
#> [1] "Diamond"
```
