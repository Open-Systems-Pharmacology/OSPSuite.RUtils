# ospsuite.utils 1.2.0.9000

NEW FUNCTIONS

* `hasEmptyString()` to check for empty strings.

MAJOR CHANGES

* Cloning method is now disabled for `Printable` R6 class. This entails that all
  subclasses that inherit from this class will not be able to use cloning,
  **even if** they explicitly set `cloneable = TRUE`.

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

* Adds `getOSPSuiteUtilsSetting()` function to get global settings
  (see enum `ospsuiteUtilsSettingNames` for supported settings).

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
