# Validate Options Against Specifications

Validates a list of options against specified validation rules. Supports
both modern spec constructors
([`integerOption()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/integerOption.md),
etc.) and legacy list format for backward compatibility.

## Usage

``` r
validateIsOption(options, validOptions)
```

## Arguments

- options:

  A list of options to validate.

- validOptions:

  A list specifying validation rules for each option. Each entry should
  either be:

  - A spec object created with
    [`integerOption()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/integerOption.md),
    [`characterOption()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/characterOption.md),
    etc.

  - A list with fields: `type`, `valueRange`, `allowedValues`,
    `nullAllowed`, `naAllowed`

## Value

Returns `NULL` invisibly if all validations pass. Stops with detailed
error message listing all failures if any validation fails.

## Details

Each entry in `validOptions` is validated against the matching value
from `options`. Spec objects created with constructors (e.g.,
[`integerOption()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/integerOption.md))
are recommended because they express intent clearly and work well with
IDEs. For backward compatibility, legacy list-based specs are still
accepted and are automatically normalized to `optionSpec` before
validation.

## Examples

``` r
validOptions <- list(
  maxIterations = integerOption(min = 1L, max = 10000L),
  method = characterOption(allowedValues = c("a", "b")),
  threshold = numericOption(min = 0, max = 1, nullAllowed = TRUE)
)

options <- list(maxIterations = 100L, method = "a", threshold = 0.05)
validateIsOption(options, validOptions)
#> NULL
```
