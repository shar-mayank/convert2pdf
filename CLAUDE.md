# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

convert2pdf is a command-line tool written in Bash that converts between Office formats and PDF. It uses LibreOffice for Office-to-PDF conversions and Python libraries (pdf2docx, PyPDF2, python-pptx) for PDF-to-Office conversions.

## Key Commands

```bash
# Install dependencies (Python packages from requirements.txt)
./convert2pdf --setup

# Run the tool
./convert2pdf <input_file> [output_file]

# Batch conversion
./convert2pdf --batch "*.docx" [output_directory]

# Version/help
./convert2pdf --version
./convert2pdf --help

# Run tests
./test/test_convert2pdf.sh [--verbose]
```

## Architecture

The project is a single Bash script (`convert2pdf`) with supporting files:

- **convert2pdf**: Main executable Bash script containing all conversion logic
  - `log_*()`: Colored logging functions (info, success, warning, error)
  - `check_libreoffice()`: Detects LibreOffice installation on macOS/Linux
  - `convert_to_pdf()`: Uses LibreOffice for Office→PDF conversion
  - `convert_pdf_to_docx()`: Uses pdf2docx Python library
  - `convert_pdf_to_pptx()`: Uses PyPDF2 + python-pptx
  - `convert_pdf_to_pptx_lo()`: LibreOffice fallback for PDF→PPTX
  - `process_batch()`: Handles glob patterns for bulk processing
  - `get_absolute_path()`: Resolves and normalizes file paths

- **convert2pdf.rb**: Homebrew formula for distribution via `brew install shar-mayank/tools/convert2pdf`

- **completions/**: Shell completion scripts for Bash and Zsh

- **test/**: Test suite for the project

## Project Structure

```
convert2pdf/
├── convert2pdf              # Main executable script
├── Formula/
│   └── convert2pdf.rb       # Homebrew formula
├── requirements.txt         # Python dependencies
├── README.md                # User documentation
├── CLAUDE.md                # AI assistant guidance
├── CONTRIBUTING.md          # Contributor guidelines
├── HOMEBREW_SUBMISSION.md   # Guide for homebrew-core submission
├── LICENSE                  # MIT License
├── completions/
│   ├── convert2pdf.bash     # Bash completion
│   └── convert2pdf.zsh      # Zsh completion
└── test/
    └── test_convert2pdf.sh  # Test suite
```

## Dependencies

External tools:
- LibreOffice (checked at runtime via `check_libreoffice()`)
- Python 3.8+

Python packages (in requirements.txt):
- pdf2docx==0.5.8
- PyPDF2==3.0.1
- python-pptx==1.0.2
- numpy<2.0

## Supported Formats

- **To PDF**: .doc, .docx, .ppt, .pptx, .xls, .xlsx, .odt, .odp, .ods, .txt, .rtf, .csv
- **From PDF**: .docx, .pptx

## Homebrew Distribution

### Via Personal Tap
The project can be distributed via a Homebrew tap:

1. Create a repository named `homebrew-tools` on GitHub
2. Copy `Formula/convert2pdf.rb` to the tap
3. Users install with: `brew install shar-mayank/tools/convert2pdf`

### Via homebrew-core
See `HOMEBREW_SUBMISSION.md` for the full guide to submit to homebrew-core.

## Code Style

- Use `[[ ]]` for conditionals
- Use `local` for function variables
- Quote all variables: `"$var"`
- Use colored logging functions for output
- Handle errors gracefully with meaningful messages
