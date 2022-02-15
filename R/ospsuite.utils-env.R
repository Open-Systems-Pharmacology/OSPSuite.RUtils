# Environment that holds various global variables and settings for the ospsuite.utils,
# It is not exported and should not be directly manipulated by other packages.
ospsuiteUtilsEnv <- new.env(parent = emptyenv())

# name of the package. This will be used to retrieve information on the package at run time
ospsuiteUtilsEnv$packageName <- "ospsuite.utils"

ospsuiteUtilsEnv$suiteName <- "Open Systems Pharmacology"

# Separator defined in OSPSuite.Core.
ospsuiteUtilsEnv$pathSeparator <- "|"

# Default values for the formatNumerics() helper function
ospsuiteUtilsEnv$formatNumericsDigits <- 2

# Specifies the symbol used for µ. This will be set by the .NET layer
ospsuiteUtilsEnv$muSymbol <- "µ"

#' Names of the settings stored in ospsuiteEnv. Can be used with `getOSPSuiteUtilsSetting()`
#' @export
ospsuiteUtilsSettingNames <- enum(names(ospsuiteUtilsEnv))

#' Get the value of a global ospsuite-R setting.
#'
#' @param settingName String name of the setting
#'
#' @return Value of the setting stored in ospsuiteEnv. If the setting does not exist, an error is thrown.
#' @export
#'
#' @examples
#' getOSPSuiteUtilsSetting("suiteName")
#' getOSPSuiteUtilsSetting("muSymbol")
getOSPSuiteUtilsSetting <- function(settingName) {
  if (!(any(names(ospsuiteUtilsEnv) == settingName))) {
    stop(ospsuite.utils::messages$errorPackageSettingNotFound(settingName, ospsuiteUtilsEnv))
  }

  obj <- ospsuiteUtilsEnv[[settingName]]
  # Evalulate if the object is a function. This is required since some properties are defined as function reference
  if (is.function(obj)) {
    return(obj())
  }

  return(obj)
}
