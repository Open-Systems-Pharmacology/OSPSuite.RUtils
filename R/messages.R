#' List of functions and strings used to signal error messages
#'
#' @description
#' Most of these messages will be relevant only in the context of OSP R package
#' ecosystem.
#'
#' @return
#' A string with error message.
#'
#' @examples
#' # example with string
#' messages$errorEnumNotAllNames
#'
#' # example with function
#' messages$errorPropertyReadOnly("age")
#'
#' @export
messages <- list(
  errorGetEntityMultipleOutputs = function(path, container, optionalMessage = NULL) {
    callingFunction <- .getCallingFunctionName()
    paste0(
      callingFunction,
      ": the path '",
      toString(path),
      "' located under container '",
      container$path,
      "' leads to more than one entity! Use 'getAllXXXMatching'",
      "to get the list of all entities matching the path, where XXX stands for the entity type",
      optionalMessage
    )
  },
  errorEntityNotFound = function(path, container, optionalMessage = NULL) {
    callingFunction <- .getCallingFunctionName()
    paste0(
      callingFunction,
      ": No entity exists for path '",
      toString(path),
      "' located under container '",
      container$path,
      "'!",
      optionalMessage
    )
  },
  errorResultNotFound = function(path, individualId, optionalMessage = NULL) {
    callingFunction <- .getCallingFunctionName()
    paste0(
      callingFunction,
      ": No results exists for path '",
      toString(path),
      "' for individual IDs ",
      "'",
      individualId,
      "'!",
      optionalMessage
    )
  },
  errorCannotSetRHSFormula = "Creating a RHS Formula is not supported at the moment. This should be done in MoBi.",
  errorPKParameterNotFound = function(pkParameterName, allPKParameterNames) {
    paste0(
      "PK-Parameter '",
      pkParameterName,
      "' not found.\nAvailable PK-Parameters are:\n",
      paste0(allPKParameterNames, collapse = ", ")
    )
  },
  pkSimRPathInvalid = function(pksimPath) {
    paste0("Path to PKSim.R.dll '", pksimPath, "' is invalid.")
  },
  pkSimInstallPathNotFound = "Could not find an installation of PK-Sim on the machine. Please install the OSPSuite or use 'initPKSim()' to specify the installation path",
  errorSimulationBatchNothingToVary = "You need to vary at least one parameter or one molecule in order to use the SimulationBatch",
  errorMultipleMetaDataEntries = function(optionalMessage = NULL) {
    paste("Can only add a single meta data entry at once", optionalMessage)
  },
  errorMultipleSimulationsCannotBeUsedWithPopulation = "Multiple simulations cannot be run concurrently with a population.",
  errorDataSetNameMissing = "Argument `name` is missing, must be provided when
  creating an empty `DataSet`!",
  errorWrongType = function(objectName,
                            type,
                            expectedType,
                            optionalMessage = NULL) {
    callingFunction <- .getCallingFunctionName()
    expectedTypeMsg <- paste0(expectedType, collapse = ", or ")
    paste0(
      callingFunction,
      ": argument '",
      objectName,
      "' is of type '",
      type,
      "', but expected '",
      expectedTypeMsg,
      "'!",
      optionalMessage
    )
  },
  errorDifferentLength = function(objectNames, optionalMessage = NULL) {
    callingFunction <- .getCallingFunctionName()
    paste0(
      callingFunction,
      ": Arguments '",
      objectNames,
      "' must have the same length, but they don't!",
      optionalMessage
    )
  },
  errorWrongLength = function(object, nbElements, optionalMessage = NULL) {
    # Name of the calling function
    callingFunctions <- sys.calls()
    callingFunction <- sys.call(-length(callingFunctions) + 1)[[1]]
    paste0(
      callingFunction,
      ": Object should be of length '",
      nbElements,
      "', but is of length '",
      length(object),
      "' instead. ",
      optionalMessage
    )
  },
  errorWrongFileExtension = function(actualExtension, expectedExtension, optionalMessage = NULL) {
    paste0(
      "Provided file has extension '",
      actualExtension,
      "', while '",
      expectedExtension,
      "' was expected instead. ",
      optionalMessage
    )
  },
  errorEmpty = function(objectName, optionalMessage = NULL) {
    callingFunction <- .getCallingFunctionName()
    paste0(
      callingFunction,
      ": argument '",
      objectName,
      "' is empty!",
      optionalMessage
    )
  },
  errorEmptyString = function(objectName, optionalMessage = NULL) {
    callingFunction <- .getCallingFunctionName()
    paste0(
      callingFunction,
      ": argument '",
      objectName,
      "' has empty strings!",
      optionalMessage
    )
  },
  errorPropertyReadOnly = function(propertyName, optionalMessage = NULL) {
    paste0("Property '$", propertyName, "' is readonly")
  },
  errorCannotSetRHSFormula = "Creating a RHS Formula is not supported at the moment. This should be done in MoBi.",
  errorEnumNotAllNames = "The enumValues has some but not all names assigned. They must be all assigned or none assigned",
  errorValueNotInEnum = function(enum, value) {
    paste0(
      "Value '",
      value,
      "' is not in defined enumeration values: '",
      paste0(names(enum), collapse = ", "),
      "'."
    )
  },
  errorEnumValueUndefined = function(enum) {
    paste0(
      "Provided value is not in defined enumeration values: '",
      paste0(names(enum), collapse = ", "),
      "'."
    )
  },
  errorKeyInEnumPresent = function(key, optionalMessage = NULL) {
    paste0(
      "enum already contains the key '",
      key,
      "'! Use 'overwrite = TRUE' to overwrite the value. ",
      optionalMessage
    )
  },
  errorKeyNotInEnum = function(key) {
    paste0("No value with the key '", key, "' is present in the enum!")
  },
  errorUnitNotDefined = function(quantityName, dimension, unit) {
    paste0(
      "Unit '",
      unit,
      "' is not defined in dimension '",
      dimension,
      "' used by '",
      quantityName,
      "'."
    )
  },
  errorDimensionNotSupported = function(dimension, optionalMessage = NULL) {
    paste0(
      "Dimension '",
      dimension,
      "' is not supported! See enum `ospsuite::Dimensions` for the list of supported dimensions."
    )
  },
  errorUnitNotSupported = function(unit, dimension, optionalMessage = NULL) {
    paste0(
      "Unit '",
      unit,
      "' is not supported by the dimension '",
      dimension,
      "'!"
    )
  },
  errorNotIncluded = function(values, parentValues) {
    paste0(
      "Values '",
      paste0(values, collapse = ", "),
      "' are not in included in parent values: '",
      paste0(parentValues, collapse = ", "),
      "'."
    )
  },
  errorEntityPathNotAbsolute = function(path) {
    callingFunction <- .getCallingFunctionName()
    paste0(
      callingFunction,
      ": Only absolute paths (i.e. without the wildcard(s) `*`) are allowed, but the given path is: ",
      path
    )
  },
  errorOnlyOneValuesSetAllowed = function(argumentName) {
    callingFunction <- .getCallingFunctionName()
    paste0(
      callingFunction,
      ": argument '",
      argumentName,
      "' is a list with multiple values sets, but only one value set is allowed!"
    )
  },
  errorOnlyOneSupported = function(optionalMessage = NULL) {
    paste("Can only add a single instance of this object", optionalMessage)
  },
  errorDuplicatedValues = function(optionalMessage = NULL) {
    paste("Object has duplicated values; only unique values are allowed.", optionalMessage)
  },
  errorOnlyVectorAllowed = function() {
    paste("Argument to parameter `x` can only be a vector.")
  },
  errorPackageSettingNotFound = function(settingName, globalEnv) {
    paste0(
      "No global setting with the name '",
      settingName,
      "' exists. Available global settings are:\n",
      paste0(names(globalEnv), collapse = ", ")
    )
  },
  errorMissingType = function() {
    paste0("The 'type' argument must be specified.")
  },
  errorValueRange = function(valueRange) {
    callingFunction <- .getCallingFunctionName()
    if (any(is.na(valueRange))) {
      paste0(
        callingFunction,
        ": 'valueRange' must not contain NA values."
      )
    } else {
      paste0(
        callingFunction,
        ": 'valueRange' must be a vector of length 2 and in ascending order, but got ",
        if (is.null(valueRange)) "NULL" else paste0("'", toString(valueRange), "'"),
        "."
      )
    }
  },
  errorValueRangeType = function(valueRange, type) {
    callingFunction <- .getCallingFunctionName()
    paste0(
      callingFunction,
      ": 'valueRange' is not applicable for the type: ",
      if (is.null(valueRange)) "NULL" else paste0("'", type, "'"),
      "."
    )
  },
  errorNaNotAllowed = function() {
    callingFunction <- .getCallingFunctionName()
    paste0(
      callingFunction,
      ": NA values are not allowed."
    )
  },
  errorOutOfRange = function(valueRange) {
    callingFunction <- .getCallingFunctionName()
    paste0(
      callingFunction,
      ": Value(s) out of the allowed range: ",
      "[",
      toString(valueRange[1]),
      ", ",
      toString(valueRange[2]),
      "]."
    )
  },
  errorValueNotAllowed = function(values, parentValues) {
    callingFunction <- .getCallingFunctionName()
    notIncludedValues <- values[!values %in% parentValues]
    notIncludedValuesStr <- paste(
      head(notIncludedValues, 5),
      collapse = ", "
    )
    notIncludedValuesStr <- ifelse(
      length(notIncludedValues) > 5,
      paste(notIncludedValuesStr, "..."),
      notIncludedValuesStr
    )
    parentValuesStr <- paste(
      head(parentValues, 5),
      collapse = ", "
    )
    parentValuesStr <- ifelse(
      length(parentValues) > 5,
      paste(parentValuesStr, "..."),
      parentValuesStr
    )
    paste0(
      "Value(s) '",
      notIncludedValuesStr,
      "' not in included in allowed values: '",
      parentValuesStr,
      "'."
    )
  },
  errorTypeNotSupported = function(objectName, type, expectedType) {
    callingFunction <- .getCallingFunctionName()
    expectedTypeMsg <- paste0(expectedType, collapse = ", or ")
    paste0(
      callingFunction,
      ": argument '",
      objectName,
      "' is '",
      type,
      "', but only '",
      expectedTypeMsg,
      "' supported!"
    )
  }
)

# utilities ----------------------

#' @keywords internal
.getCallingFunctionName <- function() {
  callingFunctions <- sys.calls()
  callingFunction <- sys.call(-length(callingFunctions) + 1)[[1]]
  return(deparse(callingFunction))
}
