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
#' # example display with warning
#' warning(messages$errorPropertyReadOnly("age"))
#' 
#' # example display using logs
#' logInfo(messages$errorPropertyReadOnly("age"))
#'
#' @export
messages <- list(
  errorGetEntityMultipleOutputs = function(path, container, optionalMessage = NULL) {
    callingFunction <- .getCallingFunctionName()
    cliFormat(
      paste(
        "{.fn {callingFunction}}: the path {.val {toString(path)}}",
        "located under container {.url {container$path}}",
        "leads to more than {.strong one entity}!"
        ),
      paste(
        "Use {.fn getAllXXXMatching} to get the list of all entities matching the path,",
        "where {.val XXX} stands for the entity type (e.g. {.emph Containers})"
      ),
      optionalMessage
    )
  },
  errorEntityNotFound = function(path, container, optionalMessage = NULL) {
    callingFunction <- .getCallingFunctionName()
    cliFormat(
      paste(
        "{.fn {callingFunction}}: no entity exists for path {.val {toString(path)}}",
        "located under container {.url {container$path}}!"
        ),
      optionalMessage
    )
  },
  errorResultNotFound = function(path, individualId, optionalMessage = NULL) {
    callingFunction <- .getCallingFunctionName()
    cliFormat(
      paste(
        "{.fn {callingFunction}}: no results exist for path {.val {toString(path)}}",
        "for individual ID{?s} {.val {individualId}}!"
      ),
      optionalMessage
    )
  },
  errorCannotSetRHSFormula = "Creating a RHS Formula is not supported at the moment. This should be done in MoBi.",
  errorPKParameterNotFound = function(pkParameterName, allPKParameterNames) {
    cliFormat(
      "PK-Parameter {.val {pkParameterName}} not found.",
      "Available PK-Parameters are: {.field {allPKParameterNames}}"
    )
  },
  errorSimulationBatchNothingToVary = "You need to vary at least one parameter or one molecule in order to use the SimulationBatch",
  errorMultipleMetaDataEntries = function(optionalMessage = NULL) {
    cliFormat(
      "Can only add a strong single meta data entry at once", 
      optionalMessage
      )
  },
  errorMultipleSimulationsCannotBeUsedWithPopulation = "Multiple simulations cannot be run concurrently with a population.",
  errorDataSetNameMissing = "Argument `name` is missing, must be provided when
  creating an empty `DataSet`!",
  errorWrongType = function(objectName,
                            type,
                            expectedType,
                            optionalMessage = NULL) {
    callingFunction <- .getCallingFunctionName()
    cliFormat(
      paste(
        "{.fn {callingFunction}}: argument {.val {objectName}} is of type {.cls {type}},",
        "but expected {.cls {expectedType}}!"
        ),
      optionalMessage
    )
  },
  errorDifferentLength = function(objectNames, optionalMessage = NULL) {
    callingFunction <- .getCallingFunctionName()
    cliFormat(
      "Arguments {.val {objectNames}} must have the {.strong same length}, but they don't!",
      optionalMessage
    )
  },
  errorWrongLength = function(object, nbElements, optionalMessage = NULL) {
    # Name of the calling function
    callingFunctions <- sys.calls()
    callingFunction <- sys.call(-length(callingFunctions) + 1)[[1]]
    cliFormat(
      paste(
        "{.fn {callingFunction}}: {.field Object} should be of length {.val {nbElements}},",
        "but is of length {.val {length(object)}} instead."
        ),
        optionalMessage
    )
  },
  errorWrongFileExtension = function(actualExtension, expectedExtension, optionalMessage = NULL) {
    cliFormat(
      paste(
        "Provided file has extension {.file {actualExtension}},",
        "while {.file {expectedExtension}} was expected instead."
        ),
      optionalMessage
    )
  },
  errorEmpty = function(objectName, optionalMessage = NULL) {
    callingFunction <- .getCallingFunctionName()
    cliFormat(
      "{.fn {callingFunction}}: argument {.val {objectName}} is {.strong empty}!",
      optionalMessage
    )
  },
  errorEmptyString = function(objectName, optionalMessage = NULL) {
    callingFunction <- .getCallingFunctionName()
    cliFormat(
      "{.fn {callingFunction}}: argument {.val {objectName}} has {.strong empty} {.field strings}!",
      optionalMessage
    )
  },
  errorPropertyReadOnly = function(propertyName, optionalMessage = NULL) {
    cliFormat("Property {.field ${propertyName}} is readonly")
  },
  errorCannotSetRHSFormula = "Creating a RHS Formula is not supported at the moment. This should be done in MoBi.",
  errorEnumNotAllNames = "The enumValues has some but not all names assigned.\nThey must be all assigned or none assigned",
  errorValueNotInEnum = function(enum, value) {
    cliFormat("Value {.val {value}} is not in defined enumeration values: {.field {names(enum)}}.")
  },
  errorEnumValueUndefined = function(enum) {
    cliFormat("Provided value is not in defined enumeration values: {.field {names(enum)}}.")
  },
  errorKeyInEnumPresent = function(key, optionalMessage = NULL) {
    cliFormat(
      "enum already contains the key {.field {key}}!",
      "Use {.code overwrite = TRUE} to overwrite the value.",
      optionalMessage
    )
  },
  errorKeyNotInEnum = function(key) {
    cliFormat("No value with the key {.field {key}} is present in the enum!")
  },
  errorUnitNotDefined = function(quantityName, dimension, unit) {
    cliFormat("Unit {.val {unit}} is not defined in dimension {.field {dimension}} used by {.url {quantityName}}.")
  },
  errorDimensionNotSupported = function(dimension, optionalMessage = NULL) {
    cliFormat(
      "Dimension {.val dimension} is {.strong not} supported!",
      "See enum {.code ospsuite::ospDimensions} for the list of supported dimensions.",
      optionalMessage
    )
  },
  errorUnitNotSupported = function(unit, dimension, optionalMessage = NULL) {
    cliFormat(
      "Unit {.val {unit}} is not supported by dimension {.field {dimension}}!",
      optionalMessage
    )
  },
  errorNotIncluded = function(values, parentValues) {
    cliFormat("{length(values)} value{?s} ({.val {values}}) {?is/are} not included in parent values: {.field {parentValues}}.")
  },
  errorEntityPathNotAbsolute = function(path) {
    callingFunction <- .getCallingFunctionName()
    cliFormat(paste(
      "{.fn {callingFunction}}: Only absolute paths (i.e. without the wildcard(s) {.strong *}) are allowed,",
      "but the given path is: {.val {path}}"
      ))
  },
  errorOnlyOneValuesSetAllowed = function(argumentName) {
    callingFunction <- .getCallingFunctionName()
    cliFormat(paste(
      "{.fn {callingFunction}}: argument {.val {argumentName}} is a list with multiple value sets,",
      "but {.strong only one value set} is allowed!"
    ))
  },
  errorOnlyOneSupported = function(optionalMessage = NULL) {
    cliFormat(
      "Can only add a single instance of this object", 
      optionalMessage
      )
  },
  errorDuplicatedValues = function(optionalMessage = NULL) {
    cliFormat(
      "Object has duplicated values; only unique values are allowed.", 
      optionalMessage
      )
  },
  errorOnlyVectorAllowed = function() {
    cliFormat("Argument to parameter {.val x} can only be a vector.")
  },
  errorPackageSettingNotFound = function(settingName, globalEnv) {
    cliFormat(
      "No global setting with the name {.val {settingName}} exists.",
      "Available global settings are: {.field {names(globalEnv)}}"
    )
  },
  errorMissingType = function() {
    cliFormat("The {.val type} argument must be specified.")
  },
  errorValueRange = function(valueRange) {
    callingFunction <- .getCallingFunctionName()
    if (any(is.na(valueRange))) {
      cliFormat("{.fn {callingFunction}}: {.val valueRange} must not contain {.strong NA} values.")
    } else {
      cliFormat(
        "{.fn {callingFunction}}: {.val valueRange} must be a vector of {.strong length 2} and in {.strong ascending order}",
        '{.field valueRange} was {.val {ifelse(is.null(valueRange), "NULL", toString(valueRange))}}.'
        )
    }
  },
  errorValueRangeType = function(valueRange, type) {
    callingFunction <- .getCallingFunctionName()
    cliFormat(
      paste(
        "{.fn {callingFunction}}: {.val valueRange} is not applicable for the type",
        '{.cls {ifelse(is.null(valueRange), "NULL", type)}}.'
      )
    )
  },
  errorNaNotAllowed = function() {
    callingFunction <- .getCallingFunctionName()
    cliFormat("{.fn {callingFunction}}: {.emph NA} values are not allowed.")
  },
  errorOutOfRange = function(valueRange) {
    callingFunction <- .getCallingFunctionName()
    cliFormat(paste(
      "{.fn {callingFunction}}: Value(s) out of the allowed range",
      "{.strong [{toString(valueRange)}]}."
    ))
  },
  errorValueNotAllowed = function(values, parentValues) {
    callingFunction <- .getCallingFunctionName()
    notIncludedValues <- values[!values %in% parentValues]
    notIncludedValuesStr <- paste(head(notIncludedValues, 5), collapse = ", ")
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
    cliFormat(
      "{length(notIncludedValues)} value{?s} ({.val {notIncludedValuesStr}}) not included in allowed values.",
      "Allowed values: {.val {parentValuesStr}}"
      )
  },
  errorTypeNotSupported = function(objectName, type, expectedType) {
    callingFunction <- .getCallingFunctionName()
    cliFormat(
      "{.fn {callingFunction}}: argument {.val {objectName}} is of type {.cls {type}}",
      "Only {.cls {expectedType}} supported!"
    )
  },
  errorFileNotUTF8 = function(file) {
    callingFunction <- .getCallingFunctionName()
    cliFormat("{.fn {callingFunction}}: File {.file {file}} is {.strong not} UTF-8 encoded.")
  }
)

# utilities ----------------------

#' @keywords internal
.getCallingFunctionName <- function() {
  callingFunctions <- sys.calls()
  callingFunction <- sys.call(-length(callingFunctions) + 1)[[1]]
  return(deparse(callingFunction))
}
