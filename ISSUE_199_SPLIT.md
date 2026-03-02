# Split Issues for Performance Optimization #199

This document contains the individual issues to be created from the comprehensive performance optimization analysis in issue #199.

## Instructions

Create the following GitHub issues using the `gh` CLI or the GitHub web interface. Each section below represents one issue.

---

## Issue 1: Optimize Vector and Mathematical Operations

**Priority:** CRITICAL

**Labels:** performance, enhancement

**Description:**

### Summary
Optimize performance-critical vector operations in `R/utilities.R`, particularly `logSafe()` and `foldSafe()` functions.

**Related to:** #199

### Tasks

#### 1.1 logSafe - Vectorize Element-wise Processing (CRITICAL)

**File:** `R/utilities.R:120-131`

**Problem:**
- Element-wise processing using `sapply()` instead of vectorized operations
- Calls `toMissingOfType()` for each element individually
- Three conditional branches evaluated per element
- Function call overhead for every vector element

**Current Implementation:**
```r
logSafe <- function(x, base = exp(1), epsilon = ospsuiteUtilsEnv$LOG_SAFE_EPSILON) {
  x <- sapply(X = x, function(element) {
    element <- ospsuite.utils::toMissingOfType(element, type = "double")
    if (is.na(element)) {
      return(NA_real_)
    } else if (element < epsilon) {
      return(log(epsilon, base = base))
    } else {
      return(log(element, base = base))
    }
  })
  return(x)
}
```

**Recommended Implementation:**
```r
logSafe <- function(x, base = exp(1), epsilon = ospsuiteUtilsEnv$LOG_SAFE_EPSILON) {
  # Vectorized handling of special values
  x <- ifelse(is.null(x) | is.nan(x) | is.infinite(x), NA_real_, as.double(x))

  # Vectorized threshold application
  x[!is.na(x) & x < epsilon] <- epsilon

  # Single log call on entire vector
  result <- log(x, base = base)

  return(result)
}
```

**Expected Impact:** 40-60% performance improvement

#### 1.2 foldSafe - Optimize Threshold Application (MEDIUM)

**File:** `R/utilities.R:154-160`

**Problem:**
- Validation overhead on every call
- Two separate threshold checks
- No handling of NA values explicitly

**Current Implementation:**
```r
foldSafe <- function(x, y, epsilon = ospsuiteUtilsEnv$LOG_SAFE_EPSILON) {
  validateIsSameLength(x, y)
  x[x <= epsilon] <- epsilon
  y[y <= epsilon] <- epsilon
  return(x / y)
}
```

**Recommended Implementation:**
```r
foldSafe <- function(x, y, epsilon = ospsuiteUtilsEnv$LOG_SAFE_EPSILON) {
  # Quick length check without full validation overhead
  if (length(x) != length(y)) {
    stop(messages$errorNotSameLength("x", "y", length(x), length(y)))
  }

  # Combined threshold application
  x_safe <- pmax(x, epsilon, na.rm = FALSE)
  y_safe <- pmax(y, epsilon, na.rm = FALSE)

  return(x_safe / y_safe)
}
```

**Expected Impact:** 15-25% performance improvement

### Testing Requirements
- Create benchmarks using `microbenchmark` package
- Ensure all existing tests pass
- Test with various vector sizes
- Verify NA/NaN/Inf handling

---

## Issue 2: Optimize Logging Infrastructure

**Priority:** HIGH

**Labels:** performance, enhancement

**Description:**

### Summary
Optimize performance bottlenecks in the logging system, particularly in error trace processing and pattern masking.

**Related to:** #199

### Tasks

#### 2.1 logCatch - Optimize Error Trace Processing (HIGH)

**File:** `R/logger.R:134-149`

**Problem:**
- O(n × m) complexity with nested loops
- `sapply()` + `grepl()` called for every call in stack
- Dynamic vector growth with `c()` (no pre-allocation)
- Multiple pattern compilations

**Current Implementation:**
```r
calls <- sys.calls()
errorTrace <- NULL
for (call in calls) {
  textCall <- deparse(call, nlines = 1)
  callNotDisplayed <- any(sapply(
    ospsuiteUtilsEnv$logging$errorMasking,
    FUN = function(pattern) {
      grepl(textCall, pattern = pattern, ignore.case = TRUE)
    }
  ))
  if (callNotDisplayed) {
    next
  }
  errorTrace <- c(
    errorTrace,
    gsub(pattern = "(\\{)|(\\})", replacement = "", textCall)
  )
}
```

**Recommended Implementation:**
```r
calls <- sys.calls()
errorTrace <- vector("character", length(calls))
traceIndex <- 0

# Pre-compile masking patterns (do once at initialization)
if (is.null(ospsuiteUtilsEnv$logging$.compiledErrorPatterns)) {
  ospsuiteUtilsEnv$logging$.compiledErrorPatterns <-
    lapply(ospsuiteUtilsEnv$logging$errorMasking, function(p) {
      list(pattern = p, ignore.case = TRUE)
    })
}

for (call in calls) {
  textCall <- deparse(call, nlines = 1)

  # Check all patterns with early exit
  callNotDisplayed <- FALSE
  for (compiledPattern in ospsuiteUtilsEnv$logging$.compiledErrorPatterns) {
    if (grepl(compiledPattern$pattern, textCall, ignore.case = TRUE)) {
      callNotDisplayed <- TRUE
      break
    }
  }

  if (!callNotDisplayed) {
    traceIndex <- traceIndex + 1
    errorTrace[traceIndex] <- gsub("[{}]", "", textCall)
  }
}

# Trim to actual size
errorTrace <- errorTrace[1:traceIndex]
```

**Expected Impact:** 30-50% faster error handling

#### 2.2 logCatch - Optimize Warning and Message Masking (MEDIUM)

**File:** `R/logger.R:156-165, 187-196`

**Problem:**
- Duplicate code pattern
- `sapply()` evaluates all patterns without early exit
- Pattern matching repeated for every warning/message

**Recommended Implementation:**
```r
# Helper function
.shouldMaskMessage <- function(message, maskingPatterns) {
  for (pattern in maskingPatterns) {
    if (grepl(pattern, message, ignore.case = TRUE)) {
      return(TRUE)
    }
  }
  return(FALSE)
}

# In warning handler
if (.shouldMaskMessage(warningCondition$message, ospsuiteUtilsEnv$logging$warningMasking)) {
  logDebug(warningCondition$message)
} else {
  logWarning(warningCondition$message)
}

# In message handler
if (.shouldMaskMessage(messageCondition$message, ospsuiteUtilsEnv$logging$infoMasking)) {
  logDebug(messageCondition$message)
} else {
  logInfo(messageCondition$message)
}
```

**Expected Impact:** 20-30% faster warning/message handling

#### 2.3 consoleLayout - Optimize String Operations (LOW)

**File:** `R/logger.R:77-84`

**Problem:**
- Unnecessary `unlist()` call
- Vector concatenation overhead
- Loop over tail messages

**Recommended Implementation:**
```r
msg <- strsplit(msg, "\n", fixed = TRUE)[[1]]
cliFunction <- cliFromLevel(logLevel)

if (length(msg) > 0) {
  cliFunction(paste0(msgHeader(logLevel), msg[1]))

  if (length(msg) > 1) {
    for (i in 2:length(msg)) {
      cli::cli_alert(msg[i])
    }
  }
}
```

**Expected Impact:** 10-15% faster log message formatting

### Testing Requirements
- Benchmark with `microbenchmark` package
- Test with various call stack depths
- Verify error message formatting
- Ensure pattern masking works correctly

---

## Issue 3: Optimize Printing and Display Functions

**Priority:** MEDIUM

**Labels:** performance, enhancement

**Description:**

### Summary
Optimize display and printing utilities to eliminate redundant iterations and checks.

**Related to:** #199

### Tasks

#### 3.1 ospPrintItems - Eliminate Dual Pass (MEDIUM)

**File:** `R/osp_print.R:165-173, 219-254`

**Problem:**
- Two complete iterations over the same collection
- First pass only to determine if all items are empty
- Duplicate emptiness checks

**Current Pattern:**
```r
# First pass: Count items
for (i in seq_along(x)) {
  value <- x[[i]]
  if (!.isEmpty(value)) {
    all_items_empty <- FALSE
    items_to_print <- items_to_print + 1
  } else if (print_empty) {
    items_to_print <- items_to_print + 1
  }
}

# Second pass: Print items
for (i in seq_along(x)) {
  value <- x[[i]]
  if (.isEmpty(value) && !print_empty) {
    next
  }
  # Format and print
}
```

**Recommended Implementation:**
```r
# Single pass approach
if (!.isEmpty(x)) {
  itemsToShow <- list()

  for (i in seq_along(x)) {
    value <- x[[i]]
    if (!.isEmpty(value) || print_empty) {
      itemsToShow[[length(itemsToShow) + 1]] <- list(
        index = i,
        name = if (!is.null(names(x))) names(x)[i] else NULL,
        value = value
      )
    }
  }

  if (length(itemsToShow) > 0 || !is.null(title)) {
    # Print logic here (single pass)
  }
}
```

**Expected Impact:** ~40% faster for large lists

#### 3.2 .isEmpty - Optimize Checks (LOW)

**File:** `R/osp_print.R:79-94`

**Problem:**
- Multiple `length()` calls
- Redundant type checks

**Recommended Implementation:**
```r
.isEmpty <- function(val) {
  if (is.null(val)) return(TRUE)

  len <- length(val)
  if (len == 0) return(TRUE)

  if (is.atomic(val) && len == 1) {
    return(is.na(val) || identical(val, ""))
  }

  return(FALSE)
}
```

**Expected Impact:** 10-15% faster

### Testing Requirements
- Test with various list sizes
- Verify empty item handling
- Ensure output formatting is preserved

---

## Issue 4: Optimize Validation Functions

**Priority:** MEDIUM

**Labels:** performance, enhancement

**Description:**

### Summary
Reduce overhead in validation functions through caching and optimized checks.

**Related to:** #199

### Tasks

#### 4.1 validateVector - Cache Type Checks (MEDIUM)

**File:** `R/validation-vector.R:101-106`

**Problem:**
- `isOfType()` may be called multiple times
- Separate function calls for range and values
- `class(x)[1]` called multiple times

**Current Implementation:**
```r
if (!isOfType(x, type, nullAllowed = FALSE)) {
  stop(messages$errorWrongType("x", class(x)[1], type))
}

validateVectorRange(x, type, valueRange)
validateVectorValues(x, type, allowedValues, naAllowed)
```

**Recommended Implementation:**
```r
# Cache type check result and class
objectClass <- class(x)[1]
if (!isOfType(x, type, nullAllowed = FALSE)) {
  stop(messages$errorWrongType("x", objectClass, type))
}

# Inline validation to reduce function call overhead if critical
if (!is.null(valueRange)) {
  # Direct validation logic here
}

if (!is.null(allowedValues)) {
  # Direct validation logic here
}
```

**Expected Impact:** 15-25% faster validation

#### 4.2 validateVectorRange - Optimize Checks (LOW-MEDIUM)

**File:** `R/validation-vector.R:113-144`

**Problem:**
- `%in%` operator overhead for small vector
- Multiple `length()`, `any()` calls
- Range check creates intermediate logical vector

**Recommended Implementation:**
```r
validateVectorRange <- function(x, type, valueRange) {
  if (is.null(valueRange)) return()

  # Quick type check
  validRangeType <- type == "numeric" || type == "integer" ||
                    type == "character" || type == "Date"

  if (!validRangeType) {
    stop(messages$errorValueRangeType(valueRange, type), call. = FALSE)
  }

  if (!isOfType(valueRange, type)) {
    stop(messages$errorWrongType("valueRange", class(valueRange)[1], type), call. = FALSE)
  }

  # Combined range validation
  if (length(valueRange) != 2L || is.na(valueRange[1]) || is.na(valueRange[2]) ||
      valueRange[1] > valueRange[2]) {
    stop(messages$errorValueRange(valueRange), call. = FALSE)
  }

  # Vectorized range check with early exit
  outOfRange <- (x < valueRange[1]) | (x > valueRange[2])
  if (any(outOfRange, na.rm = TRUE)) {
    stop(messages$errorOutOfRange(valueRange), call. = FALSE)
  }
}
```

**Expected Impact:** 10-20% faster

### Testing Requirements
- Benchmark validation overhead
- Test with various data types
- Ensure error messages are preserved

---

## Issue 5: Optimize Enumeration Operations

**Priority:** LOW-MEDIUM

**Labels:** performance, enhancement

**Description:**

### Summary
Optimize enumeration operations with early exit strategies and efficient lookups.

**Related to:** #199

### Tasks

#### 5.1 enumGetKey - Add Early Exit (LOW-MEDIUM)

**File:** `R/enum.R:68-76`

**Problem:**
- `enum == value` creates full logical vector
- `which()` scans entire vector even if match found early
- No early exit on first match

**Current Implementation:**
```r
enumGetKey <- function(enum, value) {
  output <- names(which(enum == value))

  if (length(output) == 0) {
    return(NULL)
  }

  return(output)
}
```

**Recommended Implementation:**
```r
enumGetKey <- function(enum, value) {
  # Early exit approach
  for (i in seq_along(enum)) {
    if (isTRUE(enum[[i]] == value)) {
      return(names(enum)[i])
    }
  }
  return(NULL)
}
```

**Expected Impact:** 15-30% faster for large enums

#### 5.2 enumHasKey - Use %in% Operator (LOW)

**File:** `R/enum.R:142-144`

**Problem:**
- Creates full logical vector
- `any()` must scan entire vector

**Current Implementation:**
```r
enumHasKey <- function(key, enum) {
  return(any(enumKeys(enum) == key))
}
```

**Recommended Implementation:**
```r
enumHasKey <- function(key, enum) {
  return(key %in% names(enum))
}
```

**Expected Impact:** 20-30% faster

#### 5.3 enumPut - Batch Key Checking (LOW)

**File:** `R/enum.R:169-175`

**Problem:**
- `enumHasKey()` called for each key
- Function call overhead

**Current Implementation:**
```r
for (i in seq_along(keys)) {
  if (enumHasKey(keys[[i]], enum) && !overwrite) {
    stop(messages$errorKeyInEnumPresent(keys[[i]]))
  }
  enum[[keys[[i]]]] <- values[[i]]
}
```

**Recommended Implementation:**
```r
if (!overwrite) {
  existingKeys <- keys %in% names(enum)
  if (any(existingKeys)) {
    firstDuplicate <- which(existingKeys)[1]
    stop(messages$errorKeyInEnumPresent(keys[[firstDuplicate]]))
  }
}

for (i in seq_along(keys)) {
  enum[[keys[[i]]]] <- values[[i]]
}
```

**Expected Impact:** 10-20% faster

### Testing Requirements
- Test with various enum sizes
- Verify key lookup correctness
- Ensure error handling works

---

## Issue 6: Optimize Collection Processing

**Priority:** LOW-MEDIUM

**Labels:** performance, enhancement

**Description:**

### Summary
Improve collection processing utilities with safer iteration patterns and optimized recursion.

**Related to:** #199

### Tasks

#### 6.1 formatNumerics - Fix Iteration Pattern (LOW-MEDIUM)

**File:** `R/formatNumerics.R:48-50`

**Problem:**
- Uses `1:length(object)` instead of `seq_along(object)`
- Edge case: if `length(object) == 0`, creates `1:0` = `c(1, 0)`
- Could use `lapply()` instead of loop

**Current Implementation:**
```r
if (isOfType(object, c("list", "data.frame"))) {
  for (field in 1:length(object)) {
    object[[field]] <- formatNumerics(object[[field]], digits, scientific)
  }
}
```

**Recommended Implementation:**
```r
if (isOfType(object, c("list", "data.frame"))) {
  # Option 1: Safer iteration
  for (field in seq_along(object)) {
    object[[field]] <- formatNumerics(object[[field]], digits, scientific)
  }
  return(object)
}

# Option 2: Use lapply (may be faster)
if (isOfType(object, c("list", "data.frame"))) {
  object[] <- lapply(object, formatNumerics, digits = digits, scientific = scientific)
  return(object)
}
```

**Expected Impact:** 10-15% faster, fixes edge case bug

### Testing Requirements
- Test with empty lists/data.frames
- Test nested structures
- Verify recursion works correctly

---

## Issue 7: Optimize Option Validation System

**Priority:** MEDIUM

**Labels:** performance, enhancement

**Description:**

### Summary
Reduce overhead in option validation system by optimizing error collection and reducing try-catch usage.

**Related to:** #199

### Tasks

#### 7.1 validateIsOption - Optimize Error Collection (MEDIUM)

**File:** `R/validation-options.R:355-370`

**Problem:**
- `tryCatch()` for every option (expensive in R)
- `Map()` creates intermediate list

**Current Implementation:**
```r
validOptions <- Map(.normalizeSpec, validOptions, names(validOptions))

errors <- list()
for (name in names(validOptions)) {
  result <- tryCatch(
    {
      .validateValue(options[[name]], validOptions[[name]], name)
      TRUE
    },
    error = function(e) e$message
  )

  if (!isTRUE(result)) {
    errors[[name]] <- result
  }
}
```

**Recommended Implementation:**
```r
# Pre-allocate errors list
errors <- vector("list", length(validOptions))
names(errors) <- names(validOptions)

# Normalize all specs first
validOptions <- lapply(seq_along(validOptions), function(i) {
  .normalizeSpec(validOptions[[i]], names(validOptions)[i])
})
names(validOptions) <- names(validOptions)

# Validate all, collecting errors
errorCount <- 0
for (name in names(validOptions)) {
  result <- tryCatch(
    {
      .validateValue(options[[name]], validOptions[[name]], name)
      NULL
    },
    error = function(e) e$message
  )

  if (!is.null(result)) {
    errorCount <- errorCount + 1
    errors[[name]] <- result
  }
}

# Only process errors if any exist
if (errorCount > 0) {
  errors <- errors[!sapply(errors, is.null)]
  stop(
    paste(
      messages$errorOptionValidationFailed(),
      paste(names(errors), ":", unlist(errors), collapse = "\n"),
      sep = "\n"
    ),
    call. = FALSE
  )
}
```

**Expected Impact:** 15-25% faster

#### 7.2 .normalizeSpec - Consider Direct Calls (LOW)

**File:** `R/validation-options.R:253-262`

**Problem:**
- `do.call()` adds overhead

**Note:** This is a low-priority optimization. The current implementation is clean and maintainable.

### Testing Requirements
- Test with various option configurations
- Ensure error messages are preserved
- Benchmark validation overhead

---

## Summary Statistics

**Total Issues Created:** 7

**Priority Breakdown:**
- CRITICAL: 1 issue (Vector Operations)
- HIGH: 1 issue (Logging Infrastructure)
- MEDIUM: 4 issues (Printing, Validation, Option Validation)
- LOW-MEDIUM: 2 issues (Enumeration, Collection Processing)

**Expected Overall Impact:**
- 30-60% improvement in validation-heavy code paths
- 20-40% reduction in logging overhead
- 15-25% improvement in vector operations
- 10-20% overall package performance improvement

**Implementation Notes:**
- All changes maintain backward compatibility
- Extensive testing required for each optimization
- Use `microbenchmark` package for performance validation
- Ensure all existing tests pass after each change
