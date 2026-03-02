#!/bin/bash

# Script to create GitHub issues from the performance optimization analysis #199
# This script requires the gh CLI to be installed and authenticated

REPO="Open-Systems-Pharmacology/OSPSuite.RUtils"

echo "Creating issues for performance optimization (split from #199)..."
echo ""

# Issue 1: Vector and Mathematical Operations
echo "Creating Issue 1: Optimize Vector and Mathematical Operations..."
gh issue create \
  --repo "$REPO" \
  --title "Optimize Vector and Mathematical Operations" \
  --label "performance,enhancement" \
  --body "### Summary
Optimize performance-critical vector operations in \`R/utilities.R\`, particularly \`logSafe()\` and \`foldSafe()\` functions.

**Related to:** #199
**Priority:** CRITICAL

### Tasks

#### 1.1 logSafe - Vectorize Element-wise Processing (CRITICAL)

**File:** \`R/utilities.R:120-131\`

**Problem:**
- Element-wise processing using \`sapply()\` instead of vectorized operations
- Calls \`toMissingOfType()\` for each element individually
- Three conditional branches evaluated per element
- Function call overhead for every vector element

**Expected Impact:** 40-60% performance improvement

See the full analysis in #199 section 1.1 for detailed implementation recommendations.

#### 1.2 foldSafe - Optimize Threshold Application (MEDIUM)

**File:** \`R/utilities.R:154-160\`

**Problem:**
- Validation overhead on every call
- Two separate threshold checks
- No handling of NA values explicitly

**Expected Impact:** 15-25% performance improvement

See the full analysis in #199 section 1.2 for detailed implementation recommendations.

### Testing Requirements
- Create benchmarks using \`microbenchmark\` package
- Ensure all existing tests pass
- Test with various vector sizes
- Verify NA/NaN/Inf handling"

echo "✓ Issue 1 created"
echo ""

# Issue 2: Logging Infrastructure
echo "Creating Issue 2: Optimize Logging Infrastructure..."
gh issue create \
  --repo "$REPO" \
  --title "Optimize Logging Infrastructure" \
  --label "performance,enhancement" \
  --body "### Summary
Optimize performance bottlenecks in the logging system, particularly in error trace processing and pattern masking.

**Related to:** #199
**Priority:** HIGH

### Tasks

#### 2.1 logCatch - Optimize Error Trace Processing (HIGH)

**File:** \`R/logger.R:134-149\`

**Problem:**
- O(n × m) complexity with nested loops
- \`sapply()\` + \`grepl()\` called for every call in stack
- Dynamic vector growth with \`c()\` (no pre-allocation)
- Multiple pattern compilations

**Expected Impact:** 30-50% faster error handling

See the full analysis in #199 section 2.1 for detailed implementation recommendations.

#### 2.2 logCatch - Optimize Warning and Message Masking (MEDIUM)

**File:** \`R/logger.R:156-165, 187-196\`

**Problem:**
- Duplicate code pattern
- \`sapply()\` evaluates all patterns without early exit
- Pattern matching repeated for every warning/message

**Expected Impact:** 20-30% faster warning/message handling

See the full analysis in #199 section 2.2 for detailed implementation recommendations.

#### 2.3 consoleLayout - Optimize String Operations (LOW)

**File:** \`R/logger.R:77-84\`

**Problem:**
- Unnecessary \`unlist()\` call
- Vector concatenation overhead
- Loop over tail messages

**Expected Impact:** 10-15% faster log message formatting

See the full analysis in #199 section 2.3 for detailed implementation recommendations.

### Testing Requirements
- Benchmark with \`microbenchmark\` package
- Test with various call stack depths
- Verify error message formatting
- Ensure pattern masking works correctly"

echo "✓ Issue 2 created"
echo ""

# Issue 3: Printing and Display Functions
echo "Creating Issue 3: Optimize Printing and Display Functions..."
gh issue create \
  --repo "$REPO" \
  --title "Optimize Printing and Display Functions" \
  --label "performance,enhancement" \
  --body "### Summary
Optimize display and printing utilities to eliminate redundant iterations and checks.

**Related to:** #199
**Priority:** MEDIUM

### Tasks

#### 3.1 ospPrintItems - Eliminate Dual Pass (MEDIUM)

**File:** \`R/osp_print.R:165-173, 219-254\`

**Problem:**
- Two complete iterations over the same collection
- First pass only to determine if all items are empty
- Duplicate emptiness checks

**Expected Impact:** ~40% faster for large lists

See the full analysis in #199 section 3.1 for detailed implementation recommendations.

#### 3.2 .isEmpty - Optimize Checks (LOW)

**File:** \`R/osp_print.R:79-94\`

**Problem:**
- Multiple \`length()\` calls
- Redundant type checks

**Expected Impact:** 10-15% faster

See the full analysis in #199 section 3.2 for detailed implementation recommendations.

### Testing Requirements
- Test with various list sizes
- Verify empty item handling
- Ensure output formatting is preserved"

echo "✓ Issue 3 created"
echo ""

# Issue 4: Validation Functions
echo "Creating Issue 4: Optimize Validation Functions..."
gh issue create \
  --repo "$REPO" \
  --title "Optimize Validation Functions" \
  --label "performance,enhancement" \
  --body "### Summary
Reduce overhead in validation functions through caching and optimized checks.

**Related to:** #199
**Priority:** MEDIUM

### Tasks

#### 4.1 validateVector - Cache Type Checks (MEDIUM)

**File:** \`R/validation-vector.R:101-106\`

**Problem:**
- \`isOfType()\` may be called multiple times
- Separate function calls for range and values
- \`class(x)[1]\` called multiple times

**Expected Impact:** 15-25% faster validation

See the full analysis in #199 section 4.1 for detailed implementation recommendations.

#### 4.2 validateVectorRange - Optimize Checks (LOW-MEDIUM)

**File:** \`R/validation-vector.R:113-144\`

**Problem:**
- \`%in%\` operator overhead for small vector
- Multiple \`length()\`, \`any()\` calls
- Range check creates intermediate logical vector

**Expected Impact:** 10-20% faster

See the full analysis in #199 section 4.2 for detailed implementation recommendations.

### Testing Requirements
- Benchmark validation overhead
- Test with various data types
- Ensure error messages are preserved"

echo "✓ Issue 4 created"
echo ""

# Issue 5: Enumeration Operations
echo "Creating Issue 5: Optimize Enumeration Operations..."
gh issue create \
  --repo "$REPO" \
  --title "Optimize Enumeration Operations" \
  --label "performance,enhancement" \
  --body "### Summary
Optimize enumeration operations with early exit strategies and efficient lookups.

**Related to:** #199
**Priority:** LOW-MEDIUM

### Tasks

#### 5.1 enumGetKey - Add Early Exit (LOW-MEDIUM)

**File:** \`R/enum.R:68-76\`

**Problem:**
- \`enum == value\` creates full logical vector
- \`which()\` scans entire vector even if match found early
- No early exit on first match

**Expected Impact:** 15-30% faster for large enums

See the full analysis in #199 section 5.1 for detailed implementation recommendations.

#### 5.2 enumHasKey - Use %in% Operator (LOW)

**File:** \`R/enum.R:142-144\`

**Problem:**
- Creates full logical vector
- \`any()\` must scan entire vector

**Expected Impact:** 20-30% faster

See the full analysis in #199 section 5.2 for detailed implementation recommendations.

#### 5.3 enumPut - Batch Key Checking (LOW)

**File:** \`R/enum.R:169-175\`

**Problem:**
- \`enumHasKey()\` called for each key
- Function call overhead

**Expected Impact:** 10-20% faster

See the full analysis in #199 section 5.3 for detailed implementation recommendations.

### Testing Requirements
- Test with various enum sizes
- Verify key lookup correctness
- Ensure error handling works"

echo "✓ Issue 5 created"
echo ""

# Issue 6: Collection Processing
echo "Creating Issue 6: Optimize Collection Processing..."
gh issue create \
  --repo "$REPO" \
  --title "Optimize Collection Processing" \
  --label "performance,enhancement" \
  --body "### Summary
Improve collection processing utilities with safer iteration patterns and optimized recursion.

**Related to:** #199
**Priority:** LOW-MEDIUM

### Tasks

#### 6.1 formatNumerics - Fix Iteration Pattern (LOW-MEDIUM)

**File:** \`R/formatNumerics.R:48-50\`

**Problem:**
- Uses \`1:length(object)\` instead of \`seq_along(object)\`
- Edge case: if \`length(object) == 0\`, creates \`1:0\` = \`c(1, 0)\`
- Could use \`lapply()\` instead of loop

**Expected Impact:** 10-15% faster, fixes edge case bug

See the full analysis in #199 section 6.1 for detailed implementation recommendations.

### Testing Requirements
- Test with empty lists/data.frames
- Test nested structures
- Verify recursion works correctly"

echo "✓ Issue 6 created"
echo ""

# Issue 7: Option Validation System
echo "Creating Issue 7: Optimize Option Validation System..."
gh issue create \
  --repo "$REPO" \
  --title "Optimize Option Validation System" \
  --label "performance,enhancement" \
  --body "### Summary
Reduce overhead in option validation system by optimizing error collection and reducing try-catch usage.

**Related to:** #199
**Priority:** MEDIUM

### Tasks

#### 7.1 validateIsOption - Optimize Error Collection (MEDIUM)

**File:** \`R/validation-options.R:355-370\`

**Problem:**
- \`tryCatch()\` for every option (expensive in R)
- \`Map()\` creates intermediate list

**Expected Impact:** 15-25% faster

See the full analysis in #199 section 7.1 for detailed implementation recommendations.

#### 7.2 .normalizeSpec - Consider Direct Calls (LOW)

**File:** \`R/validation-options.R:253-262\`

**Problem:**
- \`do.call()\` adds overhead

**Note:** This is a low-priority optimization. The current implementation is clean and maintainable.

### Testing Requirements
- Test with various option configurations
- Ensure error messages are preserved
- Benchmark validation overhead"

echo "✓ Issue 7 created"
echo ""

echo "All issues created successfully!"
echo ""
echo "Summary:"
echo "- Total issues: 7"
echo "- Priority breakdown:"
echo "  * CRITICAL: 1 (Vector Operations)"
echo "  * HIGH: 1 (Logging Infrastructure)"
echo "  * MEDIUM: 4 (Printing, Validation, Option Validation)"
echo "  * LOW-MEDIUM: 2 (Enumeration, Collection Processing)"
echo ""
echo "These issues split the comprehensive analysis from #199 into actionable tasks."
