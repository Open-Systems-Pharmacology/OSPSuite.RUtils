# ospsuite.utils 1.5.0

NEW FUNCTIONS

* `logSafe()` to compute logarithm of values that could be close to 0 or slightly 
negative.

* `foldSafe()` to compute `x / y` when `y` could be negative. All values below a 
certain threshold `epsilon` are substituted by `epsilon`. NOTE: not suited for 
calculating fold differences of negative numbers.

BUG FIXES

* The print function of the `Printable` class now converts values using the `format` 
function before printing. E.g., numerical value "0.99999999" will be displayed as "1".
https://github.com/Open-Systems-Pharmacology/OSPSuite.RUtils/issues/120

# ospsuite.utils 1.4.23

NEW FUNCTIONS

* `ifEqual()` and `ifIncluded()` for conditional values.

* `flattenList()` to flatten a list to an atomic vector of desired type.

* `toMissingOfType()` to convert special constants (`NULL`, `Inf`, `NA`, etc.)
  to `NA` of desired type.

# ospsuite.utils 1.3.0

NEW FUNCTIONS

* `hasEmptyStrings()` and `validateHasOnlyNonEmptyStrings()` to check for empty
  strings.

* `objectCount` to count number of objects.

* `validateHasOnlyDistinctValues()` to validate only unique values are present.

* `validateIsFileExtension()` to validate file extensions.

MAJOR CHANGES

* Cloning method is now disabled for `Printable` R6 class. This entails that
  `cloneable` property set by `Printable`'s subclasses will be respected.
  Previously, this was not the case; the cloning method was available **even
  if** the subclass had explicitly set `cloneable = FALSE`.

MINOR CHANGES

* Michael Sevestre is the new maintainer.

* The package has been archived on CRAN.

# ospsuite.utils 1.2.0

MAJOR CHANGES

* Removes alias `hasUniqueValues()`.

* All messages used in `ospsuite` package are now in `ospsuit.utils` (exported
  list `messages`).

BUG FIXES

* Fixes a regression in `isIncluded()` in previous release that inadvertently
  removed support for compound types (#63).

NEW FUNCTIONS

* Adds `isEmpty()` and `validateIsNotEmpty()` functions to validate that objects
  aren't empty (#58; thanks to @pchelle).

* Adds `getOSPSuiteUtilsSetting()` function to get global settings (see enum
  `ospsuiteUtilsSettingNames` for supported settings).

# ospsuite.utils 1.1.0

MAJOR CHANGES

* `isIncluded()` now only accepts base types as valid inputs.

* `formatNumerics()` now consistently returns output of type `"character"`.

MINOR CHANGES

* Improvements to documentation.

* `validateIsCharacter()` is added as an alias for `validateIsString()`
  function.

* `getEnumKey()` is added as an alias for `enumGetKey()` function.

* `hasOnlyDistinctValues()` is added as an alias for `hasUniqueValues()`
  function.

BUG FIXES

* `validateIsInteger()` now works with lists (#21).

# ospsuite.utils 1.0.0

* Initial release.

