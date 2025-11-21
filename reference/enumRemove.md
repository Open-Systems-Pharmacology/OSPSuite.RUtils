# Remove an entry from the enum.

Remove an entry from the enum.

## Usage

``` r
enumRemove(keys, enum)
```

## Arguments

- keys:

  Key(s) of entries to be removed from the enum

- enum:

  Enum from which the entries to be removed **WARNING**: the original
  object is not modified!

## Value

Enum without the removed entries.

## See also

Other enumeration-helpers:
[`enum()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enum.md),
[`enumGetKey()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumGetKey.md),
[`enumGetValue()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumGetValue.md),
[`enumHasKey()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumHasKey.md),
[`enumKeys()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumKeys.md),
[`enumPut()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumPut.md),
[`enumValues()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumValues.md)

## Examples

``` r
Symbol <- enum(c(Diamond = 1, Triangle = 2, Circle = 2))

# either by key
enumRemove("Diamond", Symbol)
#> $Triangle
#> [1] 2
#> 
#> $Circle
#> [1] 2
#> 

# or by position
enumRemove(2L, Symbol)
#> $Diamond
#> [1] 1
#> 
#> $Circle
#> [1] 2
#> 
```
