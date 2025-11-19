# Printable

Base class that implements some basic properties for printing to
console.

## Methods

### Public methods

- [`Printable$new()`](#method-Printable-new)

- [`Printable$clone()`](#method-Printable-clone)

------------------------------------------------------------------------

### Method `new()`

Create a new Printable object.

#### Usage

    Printable$new()

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    Printable$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
myPrintable <- R6::R6Class(
  "myPrintable",
  inherit = Printable,
  public = list(
    x = NULL,
    y = NULL,
    print = function() {
      private$printClass()
      private$printLine("x", self$x)
      private$printLine("y", self$y)
      invisible(self)
    }
  )
)

x <- myPrintable$new()
#> Warning: ospsuite.utils::Printable was deprecated in ospsuite.utils 1.6.2.
#> ℹ Please use ospsuite.utils::ospPrint*() instead.
#> ℹ The deprecated feature was likely used in the ospsuite.utils package.
#>   Please report the issue at
#>   <https://github.com/open-systems-pharmacology/OSPSuite.RUtils/issues>.
x
#> myPrintable: 
#>    x: NULL 
#>    y: NULL 
```
