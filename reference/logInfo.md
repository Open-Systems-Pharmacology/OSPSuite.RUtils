# logInfo

Log information with time stamp accounting for message type. Message
type will point toward the most appropriate `cli` function display.

## Usage

``` r
logInfo(msg, type = "info")
```

## Arguments

- msg:

  Character values of message to log that leverages `cli` formatting.

- type:

  Name of the message type to toward best `cli` display:

  - `"info"`: uses
    [`cli::cli_alert_info()`](https://cli.r-lib.org/reference/cli_alert.html)

  - `"success"`: uses
    [`cli::cli_alert_success()`](https://cli.r-lib.org/reference/cli_alert.html)

  - `"h1"`: uses
    [`cli::cli_h1()`](https://cli.r-lib.org/reference/cli_h1.html)

  - `"h2"`: uses
    [`cli::cli_h2()`](https://cli.r-lib.org/reference/cli_h1.html)

  - `"h3"`: uses
    [`cli::cli_h3()`](https://cli.r-lib.org/reference/cli_h1.html)

  - `"text"`: uses
    [`cli::cli_text()`](https://cli.r-lib.org/reference/cli_text.html)

  - `"alert"`: uses
    [`cli::cli_alert()`](https://cli.r-lib.org/reference/cli_alert.html)

  - `"li"`: uses
    [`cli::cli_li()`](https://cli.r-lib.org/reference/cli_li.html)

  - `"ol"`: uses
    [`cli::cli_ol()`](https://cli.r-lib.org/reference/cli_ol.html)

  - `"progress_step"`: uses
    [`cli::cli_progress_step()`](https://cli.r-lib.org/reference/cli_progress_step.html)

## Examples

``` r
# Log information
logInfo(cliFormat("This is an {.strong info} message"))
#> ℹ Info [21/11/2025 - 14:06:16]:  This is an info message
#> 

# Log a title
logInfo(cliFormat("Task: {.strong tic toc test}"), type = "h1")
#> 
#> ── Task: tic toc test ──────────────────────────────────────────────────────────

# Log success
t0 <- tic()
Sys.sleep(3)
logInfo(cliFormat("Task: {.strong tic toc test} completed [{toc(t0, \"s\")}]"), type = "success")
#> ✔ Info [21/11/2025 - 14:06:19]:  Task: tic toc test completed [3.0 s]
#> 
```
