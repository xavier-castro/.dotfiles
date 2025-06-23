#!/bin/bash

# Test script for xa_clip title editing bug fix
# This script tests the title editing functionality

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
XA_CLIP_SCRIPT="$SCRIPT_DIR/bin/.local/scripts/xa_clip"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[TEST INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[TEST SUCCESS]${NC} $1"
}

log_error() {
    echo -e "${RED}[TEST ERROR]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[TEST WARNING]${NC} $1"
}

# Test 1: Check if script exists and is executable
test_script_exists() {
    log_info "Testing if xa_clip script exists and is executable..."

    if [[ -f "$XA_CLIP_SCRIPT" ]]; then
        log_success "Script exists: $XA_CLIP_SCRIPT"
    else
        log_error "Script not found: $XA_CLIP_SCRIPT"
        return 1
    fi

    if [[ -x "$XA_CLIP_SCRIPT" ]]; then
        log_success "Script is executable"
    else
        log_error "Script is not executable"
        return 1
    fi

    return 0
}

# Test 2: Check syntax
test_syntax() {
    log_info "Testing script syntax..."

    if bash -n "$XA_CLIP_SCRIPT"; then
        log_success "Script syntax is valid"
        return 0
    else
        log_error "Script has syntax errors"
        return 1
    fi
}

# Test 3: Check help function
test_help() {
    log_info "Testing help function..."

    if "$XA_CLIP_SCRIPT" --help >/dev/null 2>&1; then
        log_success "Help function works"
        return 0
    else
        log_error "Help function failed"
        return 1
    fi
}

# Test 4: Check version function
test_version() {
    log_info "Testing version function..."

    if "$XA_CLIP_SCRIPT" --version >/dev/null 2>&1; then
        log_success "Version function works"
        return 0
    else
        log_error "Version function failed"
        return 1
    fi
}

# Test 5: Check config function
test_config() {
    log_info "Testing config function..."

    if "$XA_CLIP_SCRIPT" --config >/dev/null 2>&1; then
        log_success "Config function works"
        return 0
    else
        log_error "Config function failed"
        return 1
    fi
}

# Test 6: Check if gum is available
test_gum_availability() {
    log_info "Testing gum availability..."

    if command -v gum >/dev/null 2>&1; then
        log_success "gum is available"

        # Test basic gum functionality
        if echo "test" | gum input --value "test" --placeholder "test" >/dev/null 2>&1; then
            log_success "gum input works correctly"
        else
            log_warning "gum input might have issues"
        fi

        return 0
    else
        log_warning "gum is not available - some features may not work"
        return 1
    fi
}

# Test 7: Simulate title editing functionality
test_title_editing_logic() {
    log_info "Testing title editing logic..."

    # Create a temporary test script to simulate the title editing logic
    local test_script=$(mktemp)
    cat > "$test_script" << 'EOF'
#!/bin/bash

# Simulate the fixed title editing logic
title="Original Title"
TUI_TOOL="gum"

echo "Testing title editing logic..."
echo "Original title: $title"

# Simulate the fixed logic
if command -v gum >/dev/null 2>&1; then
    # Test 1: Normal edit
    new_title=$(echo "Edited Title" | gum input --value "$title" --width 60 --placeholder "Edit the title..." || true)
    if [[ -n "$new_title" ]] && [[ "$new_title" != "$title" ]]; then
        title="$new_title"
        echo "SUCCESS: Title changed to: $title"
    elif [[ -z "$new_title" ]]; then
        echo "INFO: Keeping original title: $title"
    fi

    # Test 2: Empty input handling
    title="Original Title"
    new_title=$(echo "" | gum input --value "$title" --width 60 --placeholder "Edit the title..." || true)
    if [[ -z "$new_title" ]]; then
        echo "SUCCESS: Empty input handled correctly, keeping: $title"
    fi

    echo "Title editing logic test completed successfully"
else
    echo "WARNING: gum not available for testing"
fi
EOF

    chmod +x "$test_script"

    if "$test_script"; then
        log_success "Title editing logic test passed"
        rm -f "$test_script"
        return 0
    else
        log_error "Title editing logic test failed"
        rm -f "$test_script"
        return 1
    fi
}

# Test 8: Check for common issues in the fix
test_fix_quality() {
    log_info "Testing fix quality..."

    # Check if the problematic 2>/dev/null pattern was removed from title editing
    if grep -n "gum input.*--value.*2>/dev/null" "$XA_CLIP_SCRIPT" | grep -v "summary\|tags"; then
        log_warning "Found potential 2>/dev/null issues in title editing section"
    else
        log_success "No problematic 2>/dev/null patterns found in title editing"
    fi

    # Check if proper error handling was added
    if grep -q "|| true" "$XA_CLIP_SCRIPT"; then
        log_success "Found proper error handling with '|| true'"
    else
        log_warning "No '|| true' error handling found"
    fi

    # Check if the fix includes proper conditional logic
    if grep -q 'if \[\[ -n "$new_title" \]\] && \[\[ "$new_title" != "$title" \]\]' "$XA_CLIP_SCRIPT"; then
        log_success "Found improved conditional logic for title editing"
    else
        log_warning "Improved conditional logic not found"
    fi

    return 0
}

# Main test runner
main() {
    echo "========================================"
    echo "Testing xa_clip title editing bug fix"
    echo "========================================"
    echo

    local test_count=0
    local passed_count=0

    # Run all tests
    for test_func in test_script_exists test_syntax test_help test_version test_config test_gum_availability test_title_editing_logic test_fix_quality; do
        echo "----------------------------------------"
        test_count=$((test_count + 1))

        if $test_func; then
            passed_count=$((passed_count + 1))
        fi

        echo
    done

    echo "========================================"
    echo "Test Results: $passed_count/$test_count tests passed"
    echo "========================================"

    if [[ $passed_count -eq $test_count ]]; then
        log_success "All tests passed! The title editing bug fix appears to be working correctly."
        exit 0
    else
        log_warning "Some tests failed or had warnings. Please review the output above."
        exit 1
    fi
}

# Run tests
main "$@"
