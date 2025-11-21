# Print a header with specified level

Prints a header with the specified level (H1, H2, or H3) using cli.

## Usage

``` r
ospPrintHeader(text, level = 1)
```

## Arguments

- text:

  The text to print as a header

- level:

  The header level (1, 2, or 3)

## Value

Invisibly returns NULL

## See also

Other print functions:
[`ospPrintClass()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/ospPrintClass.md),
[`ospPrintItems()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/ospPrintItems.md)

## Examples

``` r
# Print different header levels
ospPrintHeader("Main Title", 1)
#> 
#> ── Main Title ──────────────────────────────────────────────────────────────────
ospPrintHeader("Section Title", 2)
#> 
#> ── Section Title ──
#> 
ospPrintHeader("Subsection Title", 3)
#> 
#> ── Subsection Title 
```
