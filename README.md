# convert2pdf

A versatile command line tool to convert between Office formats and PDF.

## Features

- Convert Office documents to PDF (DOCX, PPTX, XLSX, etc.)
- Convert PDF back to Office formats (DOCX, PPTX)
- Batch conversion support
- Cross-platform (macOS, Linux)

## Installation

### Using Homebrew (macOS)

```bash
brew install shar-mayank/tools/convert2pdf
```

Or, if the formula is in homebrew-core:

```bash
brew install convert2pdf
```

### Manual Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/shar-mayank/convert2pdf.git
   ```

2. Make the script executable:
   ```bash
   chmod +x convert2pdf
   ```

3. Install dependencies:
   ```bash
   ./convert2pdf --setup
   ```

4. Move to a directory in your PATH (optional, for global access):
   ```bash
   sudo mv convert2pdf /usr/local/bin/
   ```

## Dependencies

- LibreOffice - Used for document format conversions
- Python 3 - For PDF to Office format conversions
- Python packages (installed automatically with `--setup`):
  - pdf2docx - For PDF to DOCX conversion
  - PyPDF2 - For PDF to PPTX conversion
  - python-pptx - For PDF to PPTX conversion

## Usage

### Basic Usage

Convert an Office document to PDF:
```bash
convert2pdf document.docx
```

Specify output filename:
```bash
convert2pdf presentation.pptx output.pdf
```

Convert PDF to Office format:
```bash
convert2pdf document.pdf
# You'll be prompted to choose DOCX or PPTX output format
```

### Batch Conversion

Convert all DOCX files in current directory to PDF:
```bash
convert2pdf --batch "*.docx"
```

Convert files in one directory and save to another:
```bash
convert2pdf --batch "reports/*.pptx" pdfs/
```

### Options

```
Options:
  -h, --help     Show help message
  -v, --version  Show version information
  --setup        Install required dependencies
  --batch        Process multiple files matching the input pattern
```

### Supported Formats

- To PDF: .doc, .docx, .ppt, .pptx, .xls, .xlsx, .odt, .odp, .ods
- From PDF: Convert to .docx or .pptx

## Examples

1. Convert Word document to PDF:
   ```bash
   convert2pdf document.docx
   ```

2. Convert PowerPoint presentation to PDF with custom name:
   ```bash
   convert2pdf presentation.pptx slides.pdf
   ```

3. Convert PDF to Word document:
   ```bash
   convert2pdf report.pdf report.docx
   ```

4. Convert all Excel files in a directory to PDF:
   ```bash
   convert2pdf --batch "financials/*.xlsx" pdf_reports/
   ```

## Limitations

- PDF to Office conversions preserve text content but may not perfectly maintain all formatting and layout
- Images in PDFs may not be preserved when converting to Office formats

## Shell Completion

This tool includes shell completion for:
- Bash: Command options and file completion
- Zsh: Command options and file completion

When installed via Homebrew, completion scripts are automatically installed.

## License

MIT License

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.