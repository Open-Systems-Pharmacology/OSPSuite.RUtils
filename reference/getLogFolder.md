# getLogFolder

Get current log folder where logs are saved

## Usage

``` r
getLogFolder()
```

## Examples

``` r
if (FALSE) { # \dontrun{
# Set/get log folder to a temporary directory
setLogFolder(tempdir())
getLogFolder()

# Set/get logFolder to `NULL`, cancel saving of logs
setLogFolder()
getLogFolder()
} # }
```
