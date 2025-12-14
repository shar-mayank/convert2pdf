#!/usr/bin/env bash
#
# Test suite for convert2pdf
# Author: Mayank Sharma
# Repository: https://github.com/shar-mayank/convert2pdf
#
# Usage: ./test/test_convert2pdf.sh [--verbose]
#

set -o pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counters
TESTS_PASSED=0
TESTS_FAILED=0
TESTS_SKIPPED=0
VERBOSE=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        *)
            shift
            ;;
    esac
done

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
CONVERT2PDF="$PROJECT_DIR/convert2pdf"
TEST_DIR="$SCRIPT_DIR/test_files"

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[PASS]${NC} $1"
}

log_fail() {
    echo -e "${RED}[FAIL]${NC} $1"
}

log_skip() {
    echo -e "${YELLOW}[SKIP]${NC} $1"
}

log_verbose() {
    if [[ "$VERBOSE" == true ]]; then
        echo -e "${BLUE}[DEBUG]${NC} $1"
    fi
}

# Test result tracking
pass_test() {
    local test_name="$1"
    log_success "$test_name"
    TESTS_PASSED=$((TESTS_PASSED + 1))
}

fail_test() {
    local test_name="$1"
    local reason="${2:-}"
    if [[ -n "$reason" ]]; then
        log_fail "$test_name: $reason"
    else
        log_fail "$test_name"
    fi
    TESTS_FAILED=$((TESTS_FAILED + 1))
}

skip_test() {
    local test_name="$1"
    local reason="${2:-}"
    if [[ -n "$reason" ]]; then
        log_skip "$test_name: $reason"
    else
        log_skip "$test_name"
    fi
    TESTS_SKIPPED=$((TESTS_SKIPPED + 1))
}

# Setup test environment
setup() {
    log_info "Setting up test environment..."

    # Create test directory
    mkdir -p "$TEST_DIR"

    # Create sample test files
    create_test_files

    log_info "Test environment ready"
}

# Create sample test files
create_test_files() {
    # Create a simple text file
    cat > "$TEST_DIR/sample.txt" << 'EOF'
Sample Text Document
====================

This is a test document for convert2pdf.

Features:
- Convert Office documents to PDF
- Convert PDF to Office formats
- Batch processing support
EOF

    # Create a simple CSV file
    cat > "$TEST_DIR/sample.csv" << 'EOF'
Name,Age,City
John Doe,30,New York
Jane Smith,25,Los Angeles
Bob Johnson,35,Chicago
EOF

    # Create a simple RTF file
    cat > "$TEST_DIR/sample.rtf" << 'EOF'
{\rtf1\ansi\deff0
{\fonttbl{\f0 Times New Roman;}}
\f0\fs24 This is a sample RTF document for testing convert2pdf.
\par
It contains some basic formatting.
}
EOF

    log_verbose "Created test files in $TEST_DIR"
}

# Cleanup test environment
cleanup() {
    log_info "Cleaning up test environment..."
    rm -rf "$TEST_DIR"
    log_info "Cleanup complete"
}

# ============================================================================
# TEST FUNCTIONS
# ============================================================================

test_version_flag() {
    local test_name="Version flag (--version)"
    local output

    output=$("$CONVERT2PDF" --version 2>&1)

    if [[ "$output" == *"convert2pdf version"* ]]; then
        pass_test "$test_name"
    else
        fail_test "$test_name" "Expected 'convert2pdf version' in output"
    fi
}

test_version_flag_short() {
    local test_name="Version flag short (-v)"
    local output

    output=$("$CONVERT2PDF" -v 2>&1)

    if [[ "$output" == *"convert2pdf version"* ]]; then
        pass_test "$test_name"
    else
        fail_test "$test_name" "Expected 'convert2pdf version' in output"
    fi
}

test_help_flag() {
    local test_name="Help flag (--help)"
    local output

    output=$("$CONVERT2PDF" --help 2>&1)

    if [[ "$output" == *"Usage:"* ]] && [[ "$output" == *"convert2pdf"* ]]; then
        pass_test "$test_name"
    else
        fail_test "$test_name" "Expected usage information in output"
    fi
}

test_help_flag_short() {
    local test_name="Help flag short (-h)"
    local output

    output=$("$CONVERT2PDF" -h 2>&1)

    if [[ "$output" == *"Usage:"* ]] && [[ "$output" == *"convert2pdf"* ]]; then
        pass_test "$test_name"
    else
        fail_test "$test_name" "Expected usage information in output"
    fi
}

test_no_arguments() {
    local test_name="No arguments error handling"
    local output
    local exit_code

    output=$("$CONVERT2PDF" 2>&1)
    exit_code=$?

    if [[ $exit_code -ne 0 ]] && [[ "$output" == *"Error"* || "$output" == *"No input file"* ]]; then
        pass_test "$test_name"
    else
        fail_test "$test_name" "Expected error message for no arguments"
    fi
}

test_nonexistent_file() {
    local test_name="Non-existent file error handling"
    local output
    local exit_code

    output=$("$CONVERT2PDF" "nonexistent_file.docx" 2>&1)
    exit_code=$?

    if [[ $exit_code -ne 0 ]] && [[ "$output" == *"not found"* || "$output" == *"does not exist"* || "$output" == *"Error"* ]]; then
        pass_test "$test_name"
    else
        fail_test "$test_name" "Expected error message for non-existent file"
    fi
}

test_unsupported_format() {
    local test_name="Unsupported format error handling"
    local output
    local exit_code

    # Create a dummy file with unsupported extension
    touch "$TEST_DIR/test.xyz"

    output=$("$CONVERT2PDF" "$TEST_DIR/test.xyz" 2>&1)
    exit_code=$?

    rm -f "$TEST_DIR/test.xyz"

    if [[ $exit_code -ne 0 ]] && [[ "$output" == *"Unsupported"* || "$output" == *"Error"* ]]; then
        pass_test "$test_name"
    else
        fail_test "$test_name" "Expected error message for unsupported format"
    fi
}

test_libreoffice_detection() {
    local test_name="LibreOffice detection"

    # Check if LibreOffice is installed
    if [[ -d "/Applications/LibreOffice.app" ]] || \
       [[ -d "$HOME/Applications/LibreOffice.app" ]] || \
       command -v libreoffice &> /dev/null || \
       command -v soffice &> /dev/null; then
        pass_test "$test_name"
    else
        skip_test "$test_name" "LibreOffice not installed"
    fi
}

test_txt_to_pdf_conversion() {
    local test_name="TXT to PDF conversion"
    local output_file="$TEST_DIR/sample_converted.pdf"
    local output
    local exit_code

    # Check if LibreOffice is available
    if ! command -v soffice &> /dev/null && \
       ! [[ -d "/Applications/LibreOffice.app" ]] && \
       ! [[ -d "$HOME/Applications/LibreOffice.app" ]]; then
        skip_test "$test_name" "LibreOffice not installed"
        return
    fi

    output=$("$CONVERT2PDF" "$TEST_DIR/sample.txt" "$output_file" 2>&1)
    exit_code=$?

    if [[ $exit_code -eq 0 ]] && [[ -f "$output_file" ]]; then
        pass_test "$test_name"
        rm -f "$output_file"
    else
        fail_test "$test_name" "Conversion failed or output file not created"
    fi
}

test_csv_to_pdf_conversion() {
    local test_name="CSV to PDF conversion"
    local output_file="$TEST_DIR/sample_csv.pdf"
    local output
    local exit_code

    # Check if LibreOffice is available
    if ! command -v soffice &> /dev/null && \
       ! [[ -d "/Applications/LibreOffice.app" ]] && \
       ! [[ -d "$HOME/Applications/LibreOffice.app" ]]; then
        skip_test "$test_name" "LibreOffice not installed"
        return
    fi

    output=$("$CONVERT2PDF" "$TEST_DIR/sample.csv" "$output_file" 2>&1)
    exit_code=$?

    if [[ $exit_code -eq 0 ]] && [[ -f "$output_file" ]]; then
        pass_test "$test_name"
        rm -f "$output_file"
    else
        fail_test "$test_name" "Conversion failed or output file not created"
    fi
}

test_rtf_to_pdf_conversion() {
    local test_name="RTF to PDF conversion"
    local output_file="$TEST_DIR/sample_rtf.pdf"
    local output
    local exit_code

    # Check if LibreOffice is available
    if ! command -v soffice &> /dev/null && \
       ! [[ -d "/Applications/LibreOffice.app" ]] && \
       ! [[ -d "$HOME/Applications/LibreOffice.app" ]]; then
        skip_test "$test_name" "LibreOffice not installed"
        return
    fi

    output=$("$CONVERT2PDF" "$TEST_DIR/sample.rtf" "$output_file" 2>&1)
    exit_code=$?

    if [[ $exit_code -eq 0 ]] && [[ -f "$output_file" ]]; then
        pass_test "$test_name"
        rm -f "$output_file"
    else
        fail_test "$test_name" "Conversion failed or output file not created"
    fi
}

test_output_directory_creation() {
    local test_name="Output directory auto-creation"
    local output_dir="$TEST_DIR/new_output_dir"
    local output_file="$output_dir/sample.pdf"
    local output
    local exit_code

    # Check if LibreOffice is available
    if ! command -v soffice &> /dev/null && \
       ! [[ -d "/Applications/LibreOffice.app" ]] && \
       ! [[ -d "$HOME/Applications/LibreOffice.app" ]]; then
        skip_test "$test_name" "LibreOffice not installed"
        return
    fi

    # Ensure output directory doesn't exist
    rm -rf "$output_dir"

    output=$("$CONVERT2PDF" "$TEST_DIR/sample.txt" "$output_file" 2>&1)
    exit_code=$?

    if [[ -d "$output_dir" ]] && [[ -f "$output_file" ]]; then
        pass_test "$test_name"
        rm -rf "$output_dir"
    else
        fail_test "$test_name" "Output directory was not created"
        rm -rf "$output_dir"
    fi
}

test_python_dependencies_check() {
    local test_name="Python dependencies available"
    local has_all=true

    python3 -c "import pdf2docx" &> /dev/null || has_all=false
    python3 -c "import PyPDF2" &> /dev/null || has_all=false
    python3 -c "import pptx" &> /dev/null || has_all=false

    if [[ "$has_all" == true ]]; then
        pass_test "$test_name"
    else
        skip_test "$test_name" "Some Python dependencies not installed (run --setup)"
    fi
}

test_batch_no_pattern() {
    local test_name="Batch mode without pattern error"
    local output
    local exit_code

    output=$("$CONVERT2PDF" --batch 2>&1)
    exit_code=$?

    if [[ $exit_code -ne 0 ]] && [[ "$output" == *"Error"* || "$output" == *"Missing"* ]]; then
        pass_test "$test_name"
    else
        fail_test "$test_name" "Expected error for batch without pattern"
    fi
}

test_batch_no_matches() {
    local test_name="Batch mode with no matching files"
    local output
    local exit_code

    output=$("$CONVERT2PDF" --batch "*.nonexistent" 2>&1)
    exit_code=$?

    if [[ $exit_code -ne 0 ]] && [[ "$output" == *"No files found"* || "$output" == *"ERROR"* ]]; then
        pass_test "$test_name"
    else
        fail_test "$test_name" "Expected 'No files found' message"
    fi
}

test_script_executable() {
    local test_name="Script is executable"

    if [[ -x "$CONVERT2PDF" ]]; then
        pass_test "$test_name"
    else
        fail_test "$test_name" "Script is not executable"
    fi
}

test_shebang() {
    local test_name="Script has proper shebang"
    local first_line

    first_line=$(head -n 1 "$CONVERT2PDF")

    if [[ "$first_line" == "#!/usr/bin/env bash" ]] || [[ "$first_line" == "#!/bin/bash" ]]; then
        pass_test "$test_name"
    else
        fail_test "$test_name" "Expected bash shebang, got: $first_line"
    fi
}

# ============================================================================
# MAIN TEST RUNNER
# ============================================================================

print_header() {
    echo ""
    echo "=============================================="
    echo "  convert2pdf Test Suite"
    echo "=============================================="
    echo ""
}

print_summary() {
    local total=$((TESTS_PASSED + TESTS_FAILED + TESTS_SKIPPED))

    echo ""
    echo "=============================================="
    echo "  Test Summary"
    echo "=============================================="
    echo -e "  ${GREEN}Passed:${NC}  $TESTS_PASSED"
    echo -e "  ${RED}Failed:${NC}  $TESTS_FAILED"
    echo -e "  ${YELLOW}Skipped:${NC} $TESTS_SKIPPED"
    echo "  Total:   $total"
    echo "=============================================="
    echo ""

    if [[ $TESTS_FAILED -gt 0 ]]; then
        return 1
    fi
    return 0
}

run_tests() {
    print_header

    # Setup
    setup

    echo "Running tests..."
    echo ""

    # Basic functionality tests
    log_info "=== Basic Functionality Tests ==="
    test_script_executable
    test_shebang
    test_version_flag
    test_version_flag_short
    test_help_flag
    test_help_flag_short

    echo ""

    # Error handling tests
    log_info "=== Error Handling Tests ==="
    test_no_arguments
    test_nonexistent_file
    test_unsupported_format
    test_batch_no_pattern
    test_batch_no_matches

    echo ""

    # Dependency tests
    log_info "=== Dependency Tests ==="
    test_libreoffice_detection
    test_python_dependencies_check

    echo ""

    # Conversion tests (require LibreOffice)
    log_info "=== Conversion Tests ==="
    test_txt_to_pdf_conversion
    test_csv_to_pdf_conversion
    test_rtf_to_pdf_conversion
    test_output_directory_creation

    # Cleanup
    cleanup

    # Print summary
    print_summary
}

# Run tests
run_tests
exit $?
