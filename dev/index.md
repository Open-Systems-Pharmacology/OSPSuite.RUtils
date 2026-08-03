## `{ospsuite.utils}`: Utility Functions for Open Systems Pharmacology R Packages

## Installation

[ospsuite.utils](https://github.com/open-systems-pharmacology/OSPSuite.RUtils)
requires R 4.4 or later. Install it from the [OSP
R-universe](https://open-systems-pharmacology.r-universe.dev):

``` r

install.packages(
  "ospsuite.utils",
  repos = c(
    OSP = "https://open-systems-pharmacology.r-universe.dev",
    getOption("repos")
  )
)
```

Get the latest development version from GitHub with:

``` r

# install.packages("pak")
pak::pak("Open-Systems-Pharmacology/OSPSuite.RUtils")
```

## Introduction

This package contains utility functions for R packages in the Open
Systems Pharmacology ecosystem:

- [`{ospsuite}`](https://www.open-systems-pharmacology.org/OSPSuite-R/)
- [`{tlf}`](https://www.open-systems-pharmacology.org/TLF-Library/)
- [`{ospsuite.reportingengine}`](https://www.open-systems-pharmacology.org/OSPSuite.ReportingEngine/)

## Code of Conduct

Please note that the ospsuite.utils project is released with a
[Contributor Code of
Conduct](https://www.open-systems-pharmacology.org/OSPSuite.RUtils/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
