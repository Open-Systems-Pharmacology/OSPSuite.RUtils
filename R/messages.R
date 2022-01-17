messages <- list(
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
  }
)

# utilities ----------------------

.getCallingFunctionName <- function() {
  callingFunctions <- sys.calls()
  callingFunction <- sys.call(-length(callingFunctions) + 1)[[1]]
  return(deparse(callingFunction))
}
