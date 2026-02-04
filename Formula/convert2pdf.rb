class Convert2pdf < Formula
  desc "Command-line tool to convert between Office formats and PDF"
  homepage "https://github.com/shar-mayank/convert2pdf"
  url "https://github.com/shar-mayank/convert2pdf/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "143b7abe1592ffc21a13f66c75d6df5f201b3df9f48b962e4d3643d71b64bbad"
  license "MIT"
  head "https://github.com/shar-mayank/convert2pdf.git", branch: "main"

  depends_on "python@3.13"

  def install
    bin.install "convert2pdf"
    bash_completion.install "completions/convert2pdf.bash" => "convert2pdf"
    zsh_completion.install "completions/convert2pdf.zsh" => "_convert2pdf"
    pkgshare.install "requirements.txt"
  end

  def caveats
    <<~EOS
      convert2pdf requires additional setup:

      1. Install LibreOffice for Office-to-PDF conversions:
           brew install --cask libreoffice

      2. Install Python dependencies:
           convert2pdf --setup
         Or manually:
           pip3 install pdf2docx PyPDF2 python-pptx "numpy<2.0"
    EOS
  end

  test do
    assert_match "convert2pdf version", shell_output("#{bin}/convert2pdf --version")
    assert_match "Usage:", shell_output("#{bin}/convert2pdf --help")
    assert_predicate bin/"convert2pdf", :executable?
  end
end
