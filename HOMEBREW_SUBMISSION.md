# Homebrew-core Submission Guide

This document outlines the steps to submit `convert2pdf` to homebrew-core.

## Prerequisites

Before submitting to homebrew-core, ensure:

1. ✅ Your repository is public on GitHub
2. ✅ You have a proper LICENSE file (MIT)
3. ✅ You have a release tag (v0.1.0)
4. ✅ The formula passes `brew audit --new convert2pdf`

## Pre-submission Checklist

### 1. Create a GitHub Release

```bash
# Tag your release
git tag -a v0.1.0 -m "Initial release v0.1.0"
git push origin v0.1.0

# Or create the release via GitHub web UI
```

### 2. Verify the SHA256 Hash

After creating the release, get the SHA256 of the tarball:

```bash
# Download the tarball from GitHub
curl -L https://github.com/shar-mayank/convert2pdf/archive/refs/tags/v0.1.0.tar.gz -o convert2pdf-0.1.0.tar.gz

# Get the SHA256
shasum -a 256 convert2pdf-0.1.0.tar.gz
```

Update `Formula/convert2pdf.rb` with the correct SHA256 if it differs.

### 3. Test the Formula Locally

For personal taps, test installation via the tap:

```bash
# Test via your tap
brew untap shar-mayank/tools
brew tap shar-mayank/tools
brew install --build-from-source shar-mayank/tools/convert2pdf

# Run tests
brew test shar-mayank/tools/convert2pdf

# Audit the formula
brew audit --strict shar-mayank/tools/convert2pdf
```

### 4. Fork homebrew-core

1. Go to https://github.com/Homebrew/homebrew-core
2. Click "Fork" to create your own copy

### 5. Clone Your Fork

```bash
cd $(brew --repository homebrew/core)
git remote add your-fork https://github.com/YOUR_USERNAME/homebrew-core.git
git fetch your-fork
```

### 6. Create a New Branch

```bash
git checkout -b convert2pdf
```

### 7. Copy Your Formula

```bash
cp /path/to/convert2pdf/Formula/convert2pdf.rb Formula/c/convert2pdf.rb
```

### 8. Commit and Push

```bash
git add Formula/c/convert2pdf.rb
git commit -m "convert2pdf 0.1.0 (new formula)

Command-line tool to convert between Office formats and PDF"
git push your-fork convert2pdf
```

### 9. Create Pull Request

1. Go to https://github.com/Homebrew/homebrew-core
2. Click "New pull request"
3. Select "compare across forks"
4. Choose your fork and branch
5. Fill in the PR template

## PR Template Example

```markdown
## Description

convert2pdf is a command-line tool to convert between Office formats and PDF.

### Features
- Convert Office documents (DOC, DOCX, PPT, PPTX, XLS, XLSX) to PDF
- Convert PDF to Office formats (DOCX, PPTX)
- Convert TXT to PDF or DOCX
- Batch conversion support
- Cross-platform (macOS, Linux)

### Dependencies
- LibreOffice (for Office-to-PDF conversion)
- Python 3 with pdf2docx, PyPDF2, python-pptx

## Checklist

- [x] Have you followed the [guidelines for contributing](https://github.com/Homebrew/homebrew-core/blob/HEAD/CONTRIBUTING.md)?
- [x] Have you checked that there aren't other open [pull requests](https://github.com/Homebrew/homebrew-core/pulls) for the same formula update/change?
- [x] Have you built your formula locally with `brew install --build-from-source <formula>`?
- [x] Does your build pass `brew audit --strict <formula>`?
```

## Important Notes for homebrew-core

### Acceptability Criteria

homebrew-core has strict criteria for new formulas:

1. **Popularity**: The software should have significant usage/stars
2. **Stability**: Should be stable and actively maintained
3. **No duplicates**: Shouldn't duplicate functionality of existing formulas
4. **Open source**: Must be open source with a proper license

### Potential Concerns

1. **Python dependencies**: homebrew-core prefers minimal Python dependencies
2. **LibreOffice requirement**: This is a cask dependency, not a formula
3. **Similar tools**: pandoc, unoconv exist - explain what makes convert2pdf unique

### Alternative: Create Your Own Tap

If homebrew-core submission is rejected, you can create your own Homebrew tap:

```bash
# Create a new repo called homebrew-tools
# Then users can install with:
brew tap shar-mayank/tools
brew install convert2pdf
```

## Tap Installation (Alternative)

Create a repository named `homebrew-tools` with the formula:

```
homebrew-tools/
└── Formula/
    └── convert2pdf.rb
```

Users install via:

```bash
brew tap shar-mayank/tools
brew install shar-mayank/tools/convert2pdf
```

## Resources

- [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [Adding a Formula](https://docs.brew.sh/Adding-Software-to-Homebrew)
- [Acceptable Formulae](https://docs.brew.sh/Acceptable-Formulae)
- [homebrew-core CONTRIBUTING.md](https://github.com/Homebrew/homebrew-core/blob/HEAD/CONTRIBUTING.md)
