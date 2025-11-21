# Add a new key-value pairs to an `enum`

Add a new key-value pairs to an `enum`

## Usage

``` r
enumPut(keys, values, enum, overwrite = FALSE)
```

## Arguments

- keys:

  Keys of the values to be added

- values:

  Values to be added

- enum:

  The enum to which the specified key-value pairs should be added.
  **WARNING**: the original object is **not** modified!

- overwrite:

  If `TRUE` and a value with any of the given `keys` exists, it will be
  overwritten with the new value. Otherwise, an error is thrown. Default
  is `FALSE.`

## Value

`Enum` with added key-value pair.

## See also

Other enumeration-helpers:
[`enum()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enum.md),
[`enumGetKey()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumGetKey.md),
[`enumGetValue()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumGetValue.md),
[`enumHasKey()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumHasKey.md),
[`enumKeys()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumKeys.md),
[`enumRemove()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumRemove.md),
[`enumValues()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumValues.md)

## Examples

``` r
myEnum <- enum(c(a = "b"))
myEnum <- enumPut("c", "d", myEnum)
myEnum <- enumPut(c("c", "d", "g"), c(12, 2, "a"), myEnum, overwrite = TRUE)
```
