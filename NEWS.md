# ospsuite.utils 1.1.0.9000

# ospsuite.utils 1.1.0

MAJOR CHANGES

* `isIncluded()` now only accepts base types as valid inputs.

* `formatNumerics()` now consistently returns output of type `"character"`.

MINOR CHANGES

* Improvements to documentation.

* `validateIsCharacter()` is added as an alias for `validateIsString()` function.

* `getEnumKey()` is added as an alias for `enumGetKey()` function.

* `hasOnlyDistinctValues()` is added as an alias for `hasUniqueValues()` function.

BUG FIXES

* `validateIsInteger()` now works with lists (#21).

# ospsuite.utils 1.0.0

* Initial release.
