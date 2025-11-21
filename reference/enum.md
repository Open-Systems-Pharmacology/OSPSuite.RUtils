# Define an enumerated list

Create an enumeration to be used instead of arbitrary values in code. In
some languages (C, C++, Python, etc.), enum (or enumeration) is a data
type that consists of integer constants and is ideal in contexts where a
variable can take on only one of a limited set of possible values (e.g.
day of the week). Since R programming language natively doesn't support
enumeration, the current function provides a way to create them using
lists.

## Usage

``` r
enum(enumValues)
```

## Arguments

- enumValues:

  A vector or a list of comma-separated constants to use for creating
  the enum. Optionally, these can be named constants.

## Value

An enumerated list.

## See also

Other enumeration-helpers:
[`enumGetKey()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumGetKey.md),
[`enumGetValue()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumGetValue.md),
[`enumHasKey()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumHasKey.md),
[`enumKeys()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumKeys.md),
[`enumPut()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumPut.md),
[`enumRemove()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumRemove.md),
[`enumValues()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumValues.md)

## Examples

``` r
# Without predefined values
Color <- enum(c("Red", "Blue", "Green"))
Color
#> $Red
#> [1] "Red"
#> 
#> $Blue
#> [1] "Blue"
#> 
#> $Green
#> [1] "Green"
#> 
myColor <- Color$Red
myColor
#> [1] "Red"

# With predefined values
Symbol <- enum(c(Diamond = 1, Triangle = 2, Circle = 2))
Symbol
#> $Diamond
#> [1] 1
#> 
#> $Triangle
#> [1] 2
#> 
#> $Circle
#> [1] 2
#> 

mySymbol <- Symbol$Diamond
mySymbol
#> [1] 1
```
