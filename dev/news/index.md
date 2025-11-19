# Changelog

## ospsuite.utils (development version)

### Major changes

- New spec constructors
  [`integerOption()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/integerOption.md),
  [`numericOption()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/numericOption.md),
  [`characterOption()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/characterOption.md),
  [`logicalOption()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/logicalOption.md)
  for type-safe, declarative validation.
  [`validateIsOption()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/validateIsOption.md)
  now supports `expectedLength` (`1` = scalar, `NULL` = any) and
  aggregates errors with clear error messages. `validateColumns()` is
  deprecated; use `validateIsOption(..., expectedLength = NULL)` instead
  ([\#189](https://github.com/open-systems-pharmacology/OSPSuite.RUtils/issues/189)).

### Minor improvements and bug fixes

- Improved error messages in
  [`validateEnumValue()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/validateEnumValue.md)
  and
  [`enumGetValue()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enumGetValue.md)
  to provide helpful suggestions when a close match is found. Both
  functions now use edit distance (Levenshtein distance ≤ 2) to suggest
  similar valid values or keys, making it easier to identify and fix
  typos in enum values and keys.
  ([\#185](https://github.com/open-systems-pharmacology/OSPSuite.RUtils/issues/185))

## ospsuite.utils 1.8.0

### Major changes

- New functions using [cli](https://cli.r-lib.org) and
  [logger](https://daroczig.github.io/logger/) packages to record and
  keep tracks of what the code does in a log file:
  - [`setLogFolder()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/setLogFolder.md):
    initialize/end the logging system
  - [`logCatch()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/logCatch.md):
    catch and record messages, warnings, and errors
  - [`logError()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/logError.md),
    [`logWarning()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/logWarning.md),
    [`logInfo()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/logInfo.md),
    [`logDebug()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/logDebug.md):
    record errors, warnings, info and debug messages in the logs.

## ospsuite.utils 1.7.0

### Major changes

- Class `Printable` is deprecated,
- New functions
  [`ospPrintClass()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/ospPrintClass.md),
  [`ospPrintItems()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/ospPrintItems.md),
  and
  [`ospPrintHeader()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/ospPrintHeader.md)
  are introduced to replace the `Printable` class.

## ospsuite.utils 1.6.1

### Minor improvements and bug fixes

- Cloning method is now enabled for `Printable` R6 class. It is required
  to make some of child classes cloneable in dependent packages.

## ospsuite.utils 1.6.0

### Major changes

- [`validateIsOption()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/validateIsOption.md)
  to validate a list of options against specified criteria, improving
  robustness in option handling. This function ensures options match
  expected types, value ranges, allowed values, and handles `NULL` and
  `NA` values.

- `validateColumns()` for rigorous validation of data frame columns
  against predefined specifications. Supports validation of type, value
  range, allowed values, and manages `NULL` and `NA` values effectively.

- [`validateVector()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/validateVector.md)
  introduced as a comprehensive vector validation tool, allowing checks
  against type, value range, and predefined allowed values with
  considerations for `NULL` and `NA`. Used by other validation functions
  [`validateIsOption()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/validateIsOption.md)
  and `validateColumns()`.

- [`validateVectorRange()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/validateVector.md)
  and
  [`validateVectorValues()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/validateVector.md)
  to provide detailed validation for value ranges and allowed values
  respectively. These functions complement
  [`validateVector()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/validateVector.md).

- [`isFileUTF8()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/isFileUTF8.md)
  and
  [`validateIsFileUTF8()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/validateIsFileUTF8.md)
  to provide validation assessing whether files are UTF-8 encoded.

## ospsuite.utils 1.5.0

### Major changes

- [`logSafe()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/logSafe.md)
  to compute logarithm of values that could be close to 0 or slightly
  negative.

- [`foldSafe()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/foldSafe.md)
  to compute `x / y` when `x` or `y` could be negative or zero. All
  values below a certain threshold `epsilon` are substituted by
  `epsilon`. NOTE: not suited for calculating fold differences of
  negative numbers.

### Minor improvements and bug fixes

- The print function of the `Printable` class now converts values using
  the `format` function before printing. E.g., numerical value
  “0.99999999” will be displayed as “1”.
  <https://github.com/Open-Systems-Pharmacology/OSPSuite.RUtils/issues/120>

## ospsuite.utils 1.4.23

### Major changes

- [`ifEqual()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/ifEqual.md)
  and
  [`ifIncluded()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/ifIncluded.md)
  for conditional values.

- [`flattenList()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/flattenList.md)
  to flatten a list to an atomic vector of desired type.

- [`toMissingOfType()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/toMissingOfType.md)
  to convert special constants (`NULL`, `Inf`, `NA`, etc.) to `NA` of
  desired type.

## ospsuite.utils 1.3.0

### Major changes

- [`hasEmptyStrings()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/hasEmptyStrings.md)
  and
  [`validateHasOnlyNonEmptyStrings()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/hasEmptyStrings.md)
  to check for empty strings.

- `objectCount` to count number of objects.

- [`validateHasOnlyDistinctValues()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/hasOnlyDistinctValues.md)
  to validate only unique values are present.

- [`validateIsFileExtension()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/isFileExtension.md)
  to validate file extensions.

- Cloning method is now disabled for `Printable` R6 class. This entails
  that `cloneable` property set by `Printable`’s subclasses will be
  respected. Previously, this was not the case; the cloning method was
  available **even if** the subclass had explicitly set
  `cloneable = FALSE`.

### Minor improvements and bug fixes

- Michael Sevestre is the new maintainer.

- The package has been archived on CRAN.

## ospsuite.utils 1.2.0

CRAN release: 2022-02-18

### Major changes

- Removes alias `hasUniqueValues()`.

- All messages used in `ospsuite` package are now in `ospsuit.utils`
  (exported list `messages`).

- Adds
  [`isEmpty()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/isEmpty.md)
  and
  [`validateIsNotEmpty()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/isEmpty.md)
  functions to validate that objects aren’t empty
  ([\#58](https://github.com/open-systems-pharmacology/OSPSuite.RUtils/issues/58);
  thanks to [@pchelle](https://github.com/pchelle)).

- Adds
  [`getOSPSuiteUtilsSetting()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/getOSPSuiteUtilsSetting.md)
  function to get global settings (see enum `ospsuiteUtilsSettingNames`
  for supported settings).

### Minor improvements and bug fixes

- Fixes a regression in
  [`isIncluded()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/isIncluded.md)
  in previous release that inadvertently removed support for compound
  types
  ([\#63](https://github.com/open-systems-pharmacology/OSPSuite.RUtils/issues/63)).

## ospsuite.utils 1.1.0

CRAN release: 2022-02-09

### Major changes

- [`isIncluded()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/isIncluded.md)
  now only accepts base types as valid inputs.

- [`formatNumerics()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/formatNumerics.md)
  now consistently returns output of type `"character"`.

### Minor improvements and bug fixes

- Improvements to documentation.

- [`validateIsCharacter()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/validateIsOfType.md)
  is added as an alias for
  [`validateIsString()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/validateIsOfType.md)
  function.

- [`getEnumKey()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enumGetKey.md)
  is added as an alias for
  [`enumGetKey()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/enumGetKey.md)
  function.

- [`hasOnlyDistinctValues()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/hasOnlyDistinctValues.md)
  is added as an alias for `hasUniqueValues()` function.

- [`validateIsInteger()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/dev/reference/validateIsOfType.md)
  now works with lists
  ([\#21](https://github.com/open-systems-pharmacology/OSPSuite.RUtils/issues/21)).

## ospsuite.utils 1.0.0

CRAN release: 2021-12-08

- Initial release.
