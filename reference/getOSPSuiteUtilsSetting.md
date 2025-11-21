# Get the value of a global `{ospsuite.utils}` package setting.

Get the value of a global `{ospsuite.utils}` package setting.

## Usage

``` r
getOSPSuiteUtilsSetting(settingName)
```

## Arguments

- settingName:

  String name of the setting

## Value

Value of the setting stored in `ospsuiteEnv`. If the setting does not
exist, an error is thrown.

## Examples

``` r
getOSPSuiteUtilsSetting("packageName")
#> [1] "ospsuite.utils"
getOSPSuiteUtilsSetting("suiteName")
#> [1] "Open Systems Pharmacology"
getOSPSuiteUtilsSetting("formatNumericsDigits")
#> [1] 2
```
