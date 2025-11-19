# Print a list of items with an optional title

Prints a list of items from a vector or list, with an optional title.
Items are indented and prefixed with a dash.

## Usage

``` r
ospPrintItems(x, title = NULL, print_empty = FALSE)
```

## Arguments

- x:

  A vector or list

- title:

  Optional title to display before the list (default: NULL)

- print_empty:

  Whether to print empty values (NULL, NA, empty string) (default:
  FALSE)

## Value

Invisibly returns the input object

## See also

Other print functions:
[`ospPrintClass()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/ospPrintClass.md),
[`ospPrintHeader()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/ospPrintHeader.md)

## Examples

``` r
# Print a simple vector with title
vector <- c("A", "B", "C")
ospPrintItems(vector, title = "Letters")
#> Letters:
#>   • A
#>   • B
#>   • C

# Print a named vector with title
named_vector <- c(A = 1, B = 2, C = 3)
ospPrintItems(named_vector, title = "Letters")
#> Letters:
#>   • A: 1
#>   • B: 2
#>   • C: 3

# Print a list including empty values
list_with_nulls <- list("Min" = NULL, "Max" = 100, "Unit" = NA)
ospPrintItems(list_with_nulls, title = "Parameters", print_empty = TRUE)
#> Parameters:
#>   • Min: NULL
#>   • Max: 100
#>   • Unit: NA
```
