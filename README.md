# convert2pdf

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-blue.svg)](https://github.com/shar-mayank/convert2pdf)

A versatile command-line tool to convert between Office formats and PDF.

## Features

- 📄 Convert Office documents to PDF (DOCX, PPTX, XLSX, ODS, ODT, ODP, TXT, RTF, CSV)
- 📋 Convert PDF back to Office formats (DOCX, PPTX)
- 🔄 Batch conversion support for processing multiple files
- 🎨 Colored output for better readability
- ⚡ Cross-platform support (macOS, Linux)
- 🐚 Shell completion for Bash and Zsh

## Installation

### Using Homebrew (macOS)

```bash
# Add the tap first
brew tap shar-mayank/tools

# Install convert2pdf
brew install convert2pdf
```

Or install directly:

```bash
brew install shar-mayank/tools/convert2pdf
```

### Manual Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/shar-mayank/convert2pdf.git
   cd convert2pdf
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
   sudo cp convert2pdf /usr/local/bin/
   ```

5. (Optional) Install shell completions:
   ```bash
   # For Bash
   sudo cp completions/convert2pdf.bash /usr/local/etc/bash_completion.d/convert2pdf

   # For Zsh
   sudo cp completions/convert2pdf.zsh /usr/local/share/zsh/site-functions/_convert2pdf
   ```

## Dependencies

### Required
- **LibreOffice** - Used for document format conversions
- **Python 3** (3.8 or later) - For PDF to Office format conversions

### Python Packages
These are installed automatically with `--setup`:
- `pdf2docx` (0.5.8) - For PDF to DOCX conversion
- `PyPDF2` (3.0.1) - For reading PDF files
- `python-pptx` (1.0.2) - For creating PPTX files
- `numpy` (<2.0) - Required by pdf2docx

### Installing LibreOffice

```bash
# macOS
brew install --cask libreoffice

# Ubuntu/Debian
sudo apt-get install libreoffice

# Fedora
sudo dnf install libreoffice

# CentOS/RHEL
sudo yum install libreoffice
```

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

**To PDF:**
- Word: `.doc`, `.docx`
- PowerPoint: `.ppt`, `.pptx`
- Excel: `.xls`, `.xlsx`
- OpenDocument: `.odt`, `.odp`, `.ods`
- Text: `.txt`, `.rtf`, `.csv`

**From PDF:**
- Word Document: `.docx`
- PowerPoint: `.pptx`

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
- **Bash**: Command options and file completion
- **Zsh**: Command options and file completion

When installed via Homebrew, completion scripts are automatically installed.

For manual installation, see the [Installation](#installation) section.

## Testing

Run the test suite to verify the installation:

```bash
./test/test_convert2pdf.sh

# For verbose output
./test/test_convert2pdf.sh --verbose
```

## Troubleshooting

### LibreOffice not found
Make sure LibreOffice is installed and accessible. On macOS, it should be in `/Applications/LibreOffice.app`.

### Python dependencies missing
Run `convert2pdf --setup` to install required Python packages automatically.

### Permission denied
Make sure the script is executable: `chmod +x convert2pdf`

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Author

**Mayank Sharma** - [GitHub](https://github.com/shar-mayank)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request