# Get enum values

Return the value that is stored under the given key. If the key is not
present, an error is thrown.

## Usage

``` r
enumGetValue(enum, key)
```

## Arguments

- enum:

  The `enum` that contains the key-value pair.

- key:

  The `key` under which the value is stored.

## Value

Value that is assigned to `key`.

## See also

Other enumeration-helpers:
[`enum()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enum.md),
[`enumGetKey()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enumGetKey.md),
[`enumHasKey()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enumHasKey.md),
[`enumKeys()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enumKeys.md),
[`enumPut()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enumPut.md),
[`enumRemove()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enumRemove.md),
[`enumValues()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enumValues.md)

## Examples

``` r
Symbol <- enum(c(Diamond = 1, Triangle = 2, Circle = 2))
enumGetValue(Symbol, "Diamond")
#> [1] 1
```
