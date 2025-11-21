# Package index

## Helpers

### Enum helpers

Utilities to work with enum objects

- [`enum()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enum.md)
  : Define an enumerated list

- [`enumGetKey()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumGetKey.md)
  [`getEnumKey()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumGetKey.md)
  :

  Get the key mapped to the given value in an `enum`

- [`enumGetValue()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumGetValue.md)
  : Get enum values

- [`enumHasKey()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumHasKey.md)
  : Check if an enum has a certain key.

- [`enumKeys()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumKeys.md)
  : Get all keys of an enum

- [`enumPut()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumPut.md)
  :

  Add a new key-value pairs to an `enum`

- [`enumRemove()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumRemove.md)
  : Remove an entry from the enum.

- [`enumValues()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/enumValues.md)
  : Get the values stored in an enum

### Validation helpers

Check or validate a given assertion

- [`hasEmptyStrings()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/hasEmptyStrings.md)
  [`validateHasOnlyNonEmptyStrings()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/hasEmptyStrings.md)
  : Validate that no empty string is present

- [`hasOnlyDistinctValues()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/hasOnlyDistinctValues.md)
  [`validateHasOnlyDistinctValues()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/hasOnlyDistinctValues.md)
  : Validate that a vector has only unique values

- [`isEmpty()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/isEmpty.md)
  [`validateIsNotEmpty()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/isEmpty.md)
  : Validate if the provided object is empty

- [`isFileExtension()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/isFileExtension.md)
  [`validateIsFileExtension()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/isFileExtension.md)
  : Validate if the provided path has required extension

- [`isFileUTF8()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/isFileUTF8.md)
  : Assess if a file is UTF-8 encoded.

- [`isIncluded()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/isIncluded.md)
  [`validateIsIncluded()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/isIncluded.md)
  : Check if a vector of values is included in another vector of values

- [`isOfLength()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/isOfLength.md)
  [`validateIsOfLength()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/isOfLength.md)
  : Check if the provided object has expected length

- [`isOfType()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/isOfType.md)
  : Check if the provided object is of certain type

- [`isSameLength()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/isSameLength.md)
  [`validateIsSameLength()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/isSameLength.md)
  : Validate if objects are of same length

- [`isUTF8()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/isUTF8.md)
  : Assess if a character vector is UTF-8 encoded.

- [`validateEnumValue()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/validateEnumValue.md)
  :

  Check if `value` is in the given `enum`. If not, stops with an error.

- [`validateIsFileUTF8()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/validateIsFileUTF8.md)
  : Validate if a file is UTF-8 encoded.

- [`validateIsOfType()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/validateIsOfType.md)
  [`validateIsCharacter()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/validateIsOfType.md)
  [`validateIsString()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/validateIsOfType.md)
  [`validateIsNumeric()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/validateIsOfType.md)
  [`validateIsInteger()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/validateIsOfType.md)
  [`validateIsLogical()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/validateIsOfType.md)
  : Check if the provided object is of certain type. If not, stop with
  an error.

- [`validateIsOption()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/validateIsOption.md)
  : Validate Options Against Specifications

- [`validatePathIsAbsolute()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/validatePathIsAbsolute.md)
  : Check if path is absolute

- [`validateVector()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/validateVector.md)
  [`validateVectorRange()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/validateVector.md)
  [`validateVectorValues()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/validateVector.md)
  : Validate Vector Against Specified Criteria

### Validation spec constructors

Create specification objects for option validation

- [`integerOption()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/integerOption.md)
  : Create Integer Option Specification
- [`numericOption()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/numericOption.md)
  : Create Numeric Option Specification
- [`characterOption()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/characterOption.md)
  : Create Character Option Specification
- [`logicalOption()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/logicalOption.md)
  : Create Logical Option Specification

### Conditional value assignment helpers

Compute and assign value conditionally

- [`ifEqual()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/ifEqual.md)
  : Value conditional on equality

- [`ifIncluded()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/ifIncluded.md)
  : Value conditional on inclusion

- [`ifNotNull()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/ifNotNull.md)
  :

  Value conditional on `NULL`

### Formatting helpers

- [`formatNumerics()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/formatNumerics.md)
  : formatNumerics

### Printing helpers

- [`ospPrintClass()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/ospPrintClass.md)
  : Print an object's class name
- [`ospPrintHeader()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/ospPrintHeader.md)
  : Print a header with specified level
- [`ospPrintItems()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/ospPrintItems.md)
  : Print a list of items with an optional title

### Math helpers

- [`logSafe()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/logSafe.md)
  :

  Computes logarithm of a number or of a vector of numbers and handles
  zeros while substituting all values below `epsilon` by `epsilon`.

## Package settings

- [`getOSPSuiteUtilsSetting()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/getOSPSuiteUtilsSetting.md)
  :

  Get the value of a global
  [ospsuite.utils](https://github.com/open-systems-pharmacology/OSPSuite.RUtils)
  package setting.

- [`ospsuiteUtilsSettingNames`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/ospsuiteUtilsSettingNames.md)
  :

  Names of the settings stored in `ospsuiteEnv`. Can be used with
  [`getOSPSuiteUtilsSetting()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/getOSPSuiteUtilsSetting.md)

## Deprecated Features

- [`Printable`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/Printable.md)
  : Printable

## Logger

Utilities for recording logs

- [`getLogFolder()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/getLogFolder.md)
  : getLogFolder
- [`setLogFolder()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/setLogFolder.md)
  : setLogFolder
- [`logDebug()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/logDebug.md)
  : logDebug
- [`logInfo()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/logInfo.md)
  : logInfo
- [`logWarning()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/logWarning.md)
  : logWarning
- [`logError()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/logError.md)
  : logError
- [`cliFormat()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/cliFormat.md)
  : cliFormat
- [`logCatch()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/logCatch.md)
  : logCatch
- [`setInfoMasking()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/setInfoMasking.md)
  : setInfoMasking
- [`setWarningMasking()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/setWarningMasking.md)
  : setWarningMasking
- [`setErrorMasking()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/setErrorMasking.md)
  : setErrorMasking

## Miscellaneous

- [`` `%||%` ``](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/op-null-default.md)
  :

  Default value for `NULL`

- [`toList()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/toList.md)
  : Make sure the object is a list

- [`toMissingOfType()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/toMissingOfType.md)
  :

  Convert special constants to `NA` of desired type

- [`toc()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/toc.md)
  : toc

- [`messages`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/messages.md)
  : List of functions and strings used to signal error messages

- [`objectCount()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/objectCount.md)
  : Count number of objects

- [`flattenList()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/flattenList.md)
  : Flatten a list to an atomic vector of desired type

- [`logSafe()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/logSafe.md)
  :

  Computes logarithm of a number or of a vector of numbers and handles
  zeros while substituting all values below `epsilon` by `epsilon`.

- [`foldSafe()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/foldSafe.md)
  : Safe fold calculation

- [`tic()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/tic.md)
  : tic

- [`timeStamp()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/timeStamp.md)
  : timeStamp
