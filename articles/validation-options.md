# Validating Options

``` r
library(ospsuite.utils)
```

The
[ospsuite.utils](https://github.com/open-systems-pharmacology/OSPSuite.RUtils)
package provides a system for validating function arguments and
configuration options through the
[`validateIsOption()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/validateIsOption.md)
function and its associated spec constructors.

## Get started

The
[`validateIsOption()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/validateIsOption.md)
function validates a list of options against a set of specifications.
This is particularly useful for validating function arguments,
configuration parameters, or user inputs.

### Basic usage

``` r
# Define validation specifications
validOptions <- list(
  maxIterations = integerOption(min = 1L, max = 10000L),
  method = characterOption(allowedValues = c("newton", "gradient")),
  tolerance = numericOption(min = 0, max = 1)
)

# Valid options pass silently
options <- list(
  maxIterations = 100L,
  method = "newton",
  tolerance = 0.001
)

validateIsOption(options, validOptions)
#> NULL
```

Invalid options produce clear error messages:

``` r
# Invalid method value
invalidOptions <- list(
  maxIterations = 100L,
  method = "invalid",
  tolerance = 0.001
)

validateIsOption(invalidOptions, validOptions)
#> Error in `validateIsOption()`:
#> ! Option validation failed:
#> 
#> method : 1 value ("invalid") not included in allowed values.
#> Allowed values: "newton, gradient"
```

## Spec constructors

The package provides four type-specific constructors for creating
validation specifications:

### integerOption()

Validates integer values with optional range constraints:

``` r
validOptions <- list(
  age = integerOption(min = 0L, max = 120L),
  count = integerOption(min = 1L)
)

options <- list(age = 25L, count = 10L)
validateIsOption(options, validOptions)
#> NULL
```

> Note:
> [`integerOption()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/integerOption.md)
> automatically converts numeric values to integers when possible and
> issues a warning.

### numericOption()

Validates numeric values with optional range constraints:

``` r
validOptions <- list(
  weight = numericOption(min = 0, max = 500),
  bmi = numericOption(min = 10, max = 50)
)

options <- list(weight = 75.5, bmi = 22.3)
validateIsOption(options, validOptions)
#> NULL
```

### characterOption()

Validates character values with optional allowed values:

``` r
validOptions <- list(
  gender = characterOption(allowedValues = c("M", "F", "Other")),
  name = characterOption()
)

options <- list(gender = "F", name = "Alice")
validateIsOption(options, validOptions)
#> NULL
```

### logicalOption()

Validates logical values:

``` r
validOptions <- list(
  verbose = logicalOption(),
  debug = logicalOption()
)

options <- list(verbose = TRUE, debug = FALSE)
validateIsOption(options, validOptions)
#> NULL
```

## Common parameters

All spec constructors share these optional parameters:

### nullAllowed

Controls whether `NULL` is permitted (default: `FALSE`):

``` r
validOptions <- list(
  required = characterOption(),
  optional = characterOption(nullAllowed = TRUE)
)

# This fails because 'required' is NULL
options <- list(required = NULL, optional = NULL)
validateIsOption(options, validOptions)
#> Error in `validateIsOption()`:
#> ! Option validation failed:
#> 
#> required : `base::tryCatch()`: argument "x" is of type <NULL>, but expected <vector>!

# This succeeds
options <- list(required = "value", optional = NULL)
validateIsOption(options, validOptions)
#> NULL
```

### naAllowed

Controls whether `NA` values are permitted (default: `FALSE`):

``` r
validOptions <- list(
  age = integerOption(min = 0L, max = 120L, naAllowed = TRUE)
)

options <- list(age = NA_integer_)
validateIsOption(options, validOptions)
#> NULL
```

### expectedLength

Validates the length of vector values (default: `1` for scalars):

``` r
validOptions <- list(
  id = integerOption(expectedLength = 1),
  scores = numericOption(min = 0, max = 100, expectedLength = 3)
)

options <- list(id = 42L, scores = c(85.5, 90.0, 78.5))
validateIsOption(options, validOptions)
#> NULL
```

This is especially useful for validating data frame columns:

``` r
df <- data.frame(
  age = c(25L, 30L, 35L),
  gender = c("M", "F", "M"),
  bmi = c(22.5, 24.1, 26.3)
)

validOptions <- list(
  age = integerOption(min = 18L, max = 65L, expectedLength = nrow(df)),
  gender = characterOption(
    allowedValues = c("M", "F"),
    expectedLength = nrow(df)
  ),
  bmi = numericOption(min = 10, max = 50, expectedLength = nrow(df))
)

validateIsOption(as.list(df), validOptions)
#> NULL
```

> Note: Use `expectedLength = NULL` to accept any length:

## Error aggregation

The function validates all options and reports all failures together:

``` r
validOptions <- list(
  age = integerOption(min = 18L, max = 65L),
  method = characterOption(allowedValues = c("a", "b")),
  threshold = numericOption(min = 0, max = 1)
)

# Multiple errors reported together
options <- list(
  age = 150L,
  method = "invalid",
  threshold = 2.0
)

validateIsOption(options, validOptions)
#> Error in `validateIsOption()`:
#> ! Option validation failed:
#> 
#> age : `base::tryCatch()`: Value(s) out of the allowed range [18, 65].
#> method : 1 value ("invalid") not included in allowed values.
#> Allowed values: "a, b"
#> threshold : `base::tryCatch()`: Value(s) out of the allowed range [0, 1].
```

## Practical example

Here’s a complete example validating parameters for a simulation
function:

``` r
# Define validation specs
validParams <- list(
  timePoints = numericOption(min = 0, expectedLength = NULL),
  population = integerOption(min = 1L, max = 10000L),
  algorithm = characterOption(
    allowedValues = c("standard", "adaptive", "robust")
  ),
  tolerance = numericOption(min = 0, max = 1),
  verbose = logicalOption()
)

runAnalysis <- function(params) {
  validateIsOption(params, validParams)

  # Function logic here...
  "Analysis complete"
}

# Valid parameters
params <- list(
  timePoints = c(0, 1, 2, 5, 10),
  population = 1000L,
  algorithm = "adaptive",
  tolerance = 0.001,
  verbose = TRUE
)

runAnalysis(params)
#> [1] "Analysis complete"
```
