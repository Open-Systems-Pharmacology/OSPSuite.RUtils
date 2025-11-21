# Print an object's class name

Prints the class name of an object with nice formatting using cli.

## Usage

``` r
ospPrintClass(x)
```

## Arguments

- x:

  An R object

## Value

Invisibly returns the input object

## See also

Other print functions:
[`ospPrintHeader()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/ospPrintHeader.md),
[`ospPrintItems()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/ospPrintItems.md)

## Examples

``` r
# Print class name of a data frame
ospPrintClass(iris)
#> <data.frame>
```
