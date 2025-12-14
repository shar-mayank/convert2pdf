# Contributing to convert2pdf

Thank you for your interest in contributing to convert2pdf! This document provides guidelines and information for contributors.

## Getting Started

1. Fork the repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/convert2pdf.git
   cd convert2pdf
   ```
3. Create a branch for your changes:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## Development Setup

1. Make the script executable:
   ```bash
   chmod +x convert2pdf
   ```

2. Install dependencies:
   ```bash
   ./convert2pdf --setup
   ```

3. Install LibreOffice (required for conversions):
   ```bash
   # macOS
   brew install --cask libreoffice
   ```

## Running Tests

Before submitting changes, run the test suite:

```bash
./test/test_convert2pdf.sh

# For verbose output
./test/test_convert2pdf.sh --verbose
```

## Code Style Guidelines

### Bash Script
- Use `#!/usr/bin/env bash` as the shebang
- Use `[[ ]]` for conditionals instead of `[ ]`
- Quote variables: `"$var"` instead of `$var`
- Use `local` for function variables
- Use meaningful function and variable names
- Add comments for complex logic
- Use `set -o pipefail` for better error handling

### Commit Messages
- Use clear, descriptive commit messages
- Start with a verb (Add, Fix, Update, Remove, etc.)
- Keep the first line under 72 characters
- Reference issues when applicable: `Fix #123`

Example:
```
Add support for RTF file format

- Added RTF to the list of supported formats
- Updated help message to include RTF
- Added test case for RTF conversion
```

## Pull Request Process

1. Update documentation if you're changing functionality
2. Add tests for new features
3. Ensure all tests pass
4. Update the CHANGELOG.md (if it exists)
5. Submit the pull request with a clear description

## Adding New File Format Support

If you want to add support for a new file format:

1. Check if LibreOffice supports the format for conversion
2. Add the extension to the `case` statement in `convert_to_pdf()`
3. Update the help message in `print_usage()`
4. Update the README.md with the new format
5. Add a test case in `test/test_convert2pdf.sh`

## Reporting Issues

When reporting issues, please include:
- Operating system and version
- LibreOffice version
- Python version
- Complete error message
- Steps to reproduce the issue

## Feature Requests

Feature requests are welcome! Please:
- Check if the feature already exists or has been requested
- Provide a clear description of the feature
- Explain the use case

## Questions?

Feel free to open an issue for any questions about contributing.

## License

By contributing to convert2pdf, you agree that your contributions will be licensed under the MIT License.
