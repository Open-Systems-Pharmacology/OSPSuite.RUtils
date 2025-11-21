# toc

Get elapsed time between `tic` trigger and now

## Usage

``` r
toc(tic, unit = "min")
```

## Arguments

- tic:

  Start time

- unit:

  display unit of elapsed time

## Value

Character displaying elapsed time in `unit`

## Examples

``` r
t0 <- tic()
Sys.sleep(2)
# Get elapsed time in seconds
toc(t0, "s")
#> [1] "2.0 s"
# Get elapsed time in minutes
toc(t0, "min")
#> [1] "0.0 min"
```
