# Logging utils

``` r
library(ospsuite.utils)
```

The
[ospsuite.utils](https://github.com/open-systems-pharmacology/OSPSuite.RUtils)
package includes a set of utilities to help with logging in R. The
logging system takes avantage of 2 CRAN packages:
[`{logger}`](https://daroczig.github.io/logger/) and
[`{cli}`](https://cli.r-lib.org/).

## Get started

The function
[`setLogFolder()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/setLogFolder.md)
aims at initializing the logging system. Its only argument is
`logFolder`, which is `NULL` by default.

When `logFolder=NULL`, no log file is created, and all logs are
displayed in the console. When `logFolder` is set to a valid folder
path, it will create a `log.txt` file in that folder, which will record
all the log utilities defined below.

The example below sets a log folder within the sub-directory `test-logs`
of the current working directory. Thus, the log file will be located in
`test-logs/log.txt`

``` r
dir.create("test-logs")
setLogFolder("test-logs")
```

> 💡 Note that you can use
> [`setLogFolder()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/setLogFolder.md)
> without argument to stop logging.

The log utilities define 4 levels of logging below. Each log message is
associated with a time stamp and the level of logging.

\*1 **Debug**: for debugging purposes, its content are not displayed on
the console

``` r
logDebug("Message for debugging purposes")
```

\*2 **Info**: for general information, displayed in blue

``` r
logInfo("Message for general information")
#> ℹ Info [21/11/2025 - 14:06:27]:  Message for general information
```

\*3 **Warning**: for warnings, displayed in yellow

``` r
logWarning("Warning message")
#> ! Warning [21/11/2025 - 14:06:27]:  Warning message
```

\*4 **Error**: for errors, displayed in red

``` r
logError("Error message")
#> ✖ Error [21/11/2025 - 14:06:27]:  Error message
```

Check the content of the log file `test-logs/log.txt` to see the logged
messages.

``` r
readLines("test-logs/log.txt")
#> [1] "DEBUG [2025-11-21 14:06:27] Message for debugging purposes"
#> [2] "INFO [2025-11-21 14:06:27] Message for general information"
#> [3] "WARN [2025-11-21 14:06:27] Warning message"                
#> [4] "ERROR [2025-11-21 14:06:27] Error message"
```

## Taking advantage of glue and cli formatting

The logging utilities are designed to work with the
[`{glue}`](https://glue.tidyverse.org/) and
[`{cli}`](https://cli.r-lib.org/) packages to format messages.

Especially, the
[`logInfo()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/logInfo.md)
function includes a second argument `type` that allows you to specify
the type of message you want to log.

Here is a first example using glue/cli formatting:

``` r
logInfo("A logging example", type = "h1")
#> 
#> ── A logging example ───────────────────────────────────────────────────────────
# tic() and toc() functions were implemented in ospsuite.utils
t0 <- tic()
logInfo("Some {.strong useful} information taking advantage of {.code logger}")
#> ℹ Info [21/11/2025 - 14:06:27]:  Some useful information taking advantage of `logger`
Sys.sleep(2)
logInfo("First logging example done [{.field {toc(t0, 's')}}]", type = "success")
#> ✔ Info [21/11/2025 - 14:06:29]:  First logging example done [2.0 s]
```

The content of the log has been appended to `test-logs/log.txt` removing
most of the formatting displayed on console.

``` r
readLines("test-logs/log.txt")
#> [1] "DEBUG [2025-11-21 14:06:27] Message for debugging purposes"                     
#> [2] "INFO [2025-11-21 14:06:27] Message for general information"                     
#> [3] "WARN [2025-11-21 14:06:27] Warning message"                                     
#> [4] "ERROR [2025-11-21 14:06:27] Error message"                                      
#> [5] "DEBUG [2025-11-21 14:06:27] A logging example"                                  
#> [6] "INFO [2025-11-21 14:06:27] Some useful information taking advantage of `logger`"
#> [7] "SUCCESS [2025-11-21 14:06:29] First logging example done [2.0 s]"
```

The package
[ospsuite.utils](https://github.com/open-systems-pharmacology/OSPSuite.RUtils)
also provides a wrapper to store cli formatted messages:
[`cliFormat()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/cliFormat.md).

> 💡 Note that, when an array of messages is provided to the log
> utilities, it is expected that the first element is usually the
> information, warning, or error message and subsequent elements are
> additional information that aims at helping refine or troubleshoot the
> first message. Thus, they are indicated through arrows in both console
> and logs.

Here is a second example using
[`cliFormat()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/cliFormat.md),
whose warning will provide information about the class and length of the
variable `x`:

``` r
myWarning <- function(x) {
  cliFormat(
    "Warning example about {.val x} !",
    "{.val x} is of class {.code {class(x)}} and length {.strong {length(x)}}",
    "The {length(x)} value{?s} of {.val x} {?is/are}: {.val {x}}"
  )
}

x <- 10
logWarning(myWarning(x))
#> ! Warning [21/11/2025 - 14:06:29]:  Warning example about "x" !
#> → "x" is of class `numeric` and length 1
#> → The 1 value of "x" is: 10

x <- letters[5:8]
logWarning(myWarning(x))
#> ! Warning [21/11/2025 - 14:06:29]:  Warning example about "x" !
#> → "x" is of class `character` and length 4
#> → The 4 values of "x" are: "e", "f", "g", and "h"
```

The content of the log has also been appended to `test-logs/log.txt`
removing most of the formatting displayed on console.

``` r
readLines("test-logs/log.txt")
#>  [1] "DEBUG [2025-11-21 14:06:27] Message for debugging purposes"                     
#>  [2] "INFO [2025-11-21 14:06:27] Message for general information"                     
#>  [3] "WARN [2025-11-21 14:06:27] Warning message"                                     
#>  [4] "ERROR [2025-11-21 14:06:27] Error message"                                      
#>  [5] "DEBUG [2025-11-21 14:06:27] A logging example"                                  
#>  [6] "INFO [2025-11-21 14:06:27] Some useful information taking advantage of `logger`"
#>  [7] "SUCCESS [2025-11-21 14:06:29] First logging example done [2.0 s]"               
#>  [8] "WARN [2025-11-21 14:06:29] Warning example about \"x\" !"                       
#>  [9] "\"x\" is of class `numeric` and length 1"                                       
#> [10] "The 1 value of \"x\" is: 10"                                                    
#> [11] "WARN [2025-11-21 14:06:29] Warning example about \"x\" !"                       
#> [12] "\"x\" is of class `character` and length 4"                                     
#> [13] "The 4 values of \"x\" are: \"e\", \"f\", \"g\", and \"h\""
```

## Catching messages

The logging utilities also provide a way to catch information provided
by [`message()`](https://rdrr.io/r/base/message.html),
[`warning()`](https://rdrr.io/r/base/warning.html) and
[`stop()`](https://rdrr.io/r/base/stop.html).

You can use the
[`logCatch()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/logCatch.md)
function to catch these messages and log them accordingly.

``` r
logCatch({
  logInfo("Testing {.fn logCatch}", type = "h1")
  x <- c(
    "This is a string",
    "This is another string",
    "This is a third string"
  )
  warning(cliFormat(
    "Warning about {.val x} !",
    "{.val x} is of class {.code {class(x)}} and length {.strong {length(x)}}",
    "The {length(x)} value{?s} of {.val x} {?is/are}: {.val {x}}"
  ))
  logInfo("Warning message was caught", type = "success")
})
#> 
#> ── Testing `logCatch()` ────────────────────────────────────────────────────────
#> ! Warning [21/11/2025 - 14:06:29]:  Warning about "x" !
#> → "x" is of class `character` and length 3
#> → The 3 values of "x" are: "This is a string", "This is another string", and "This is a third string"
#> ✔ Info [21/11/2025 - 14:06:29]:  Warning message was caught
```

The content caught by the
[`logCatch()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/logCatch.md)
has also been appended to `test-logs/log.txt` removing most of the
formatting displayed on console.

``` r
readLines("test-logs/log.txt")
#>  [1] "DEBUG [2025-11-21 14:06:27] Message for debugging purposes"                                                 
#>  [2] "INFO [2025-11-21 14:06:27] Message for general information"                                                 
#>  [3] "WARN [2025-11-21 14:06:27] Warning message"                                                                 
#>  [4] "ERROR [2025-11-21 14:06:27] Error message"                                                                  
#>  [5] "DEBUG [2025-11-21 14:06:27] A logging example"                                                              
#>  [6] "INFO [2025-11-21 14:06:27] Some useful information taking advantage of `logger`"                            
#>  [7] "SUCCESS [2025-11-21 14:06:29] First logging example done [2.0 s]"                                           
#>  [8] "WARN [2025-11-21 14:06:29] Warning example about \"x\" !"                                                   
#>  [9] "\"x\" is of class `numeric` and length 1"                                                                   
#> [10] "The 1 value of \"x\" is: 10"                                                                                
#> [11] "WARN [2025-11-21 14:06:29] Warning example about \"x\" !"                                                   
#> [12] "\"x\" is of class `character` and length 4"                                                                 
#> [13] "The 4 values of \"x\" are: \"e\", \"f\", \"g\", and \"h\""                                                  
#> [14] "DEBUG [2025-11-21 14:06:29] Testing `logCatch()`"                                                           
#> [15] "WARN [2025-11-21 14:06:29] Warning about \"x\" !"                                                           
#> [16] "\"x\" is of class `character` and length 3"                                                                 
#> [17] "The 3 values of \"x\" are: \"This is a string\", \"This is another string\", and \"This is a third string\""
#> [18] "SUCCESS [2025-11-21 14:06:29] Warning message was caught"
```

### Masking messages

You can use masking utilities to prevent the display of messages on the
console. The masking will use
[`grepl()`](https://rdrr.io/r/base/grep.html) to check for patterns and
will not display the message if a match is found.

For **messages** and **warnings**, the masking can be set by the
functions
[`setInfoMasking()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/setInfoMasking.md)
and
[`setWarningMasking()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/setWarningMasking.md).

The example below will mask mask warning message that includes the
following patterns: `not useful` and `another package`

``` r
setWarningMasking("(not useful)*(another package)")

logCatch({
  warning("This is a not useful message that is warned by another package")
  warning("This is a useful message that I want displayed")
})
#> ! Warning [21/11/2025 - 14:06:30]:  This is a useful message that I want displayed
```

The content caught by the
[`logCatch()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/logCatch.md)
includes the first warning as debug message:

``` r
readLines("test-logs/log.txt")
#>  [1] "DEBUG [2025-11-21 14:06:27] Message for debugging purposes"                                                 
#>  [2] "INFO [2025-11-21 14:06:27] Message for general information"                                                 
#>  [3] "WARN [2025-11-21 14:06:27] Warning message"                                                                 
#>  [4] "ERROR [2025-11-21 14:06:27] Error message"                                                                  
#>  [5] "DEBUG [2025-11-21 14:06:27] A logging example"                                                              
#>  [6] "INFO [2025-11-21 14:06:27] Some useful information taking advantage of `logger`"                            
#>  [7] "SUCCESS [2025-11-21 14:06:29] First logging example done [2.0 s]"                                           
#>  [8] "WARN [2025-11-21 14:06:29] Warning example about \"x\" !"                                                   
#>  [9] "\"x\" is of class `numeric` and length 1"                                                                   
#> [10] "The 1 value of \"x\" is: 10"                                                                                
#> [11] "WARN [2025-11-21 14:06:29] Warning example about \"x\" !"                                                   
#> [12] "\"x\" is of class `character` and length 4"                                                                 
#> [13] "The 4 values of \"x\" are: \"e\", \"f\", \"g\", and \"h\""                                                  
#> [14] "DEBUG [2025-11-21 14:06:29] Testing `logCatch()`"                                                           
#> [15] "WARN [2025-11-21 14:06:29] Warning about \"x\" !"                                                           
#> [16] "\"x\" is of class `character` and length 3"                                                                 
#> [17] "The 3 values of \"x\" are: \"This is a string\", \"This is another string\", and \"This is a third string\""
#> [18] "SUCCESS [2025-11-21 14:06:29] Warning message was caught"                                                   
#> [19] "DEBUG [2025-11-21 14:06:30] This is a not useful message that is warned by another package"                 
#> [20] "WARN [2025-11-21 14:06:30] This is a useful message that I want displayed"
```

For **errors**, the masking is set by the function
[`setErrorMasking()`](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/reference/setErrorMasking.md).
The masking only affects the **error trace** simplifying the final
output.
