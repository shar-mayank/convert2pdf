class Convert2pdf < Formula
  desc "Command line tool to convert between Office formats and PDF"
  homepage "https://github.com/shar-mayank/convert2pdf"
  url "https://github.com/shar-mayank/convert2pdf/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "35292b336703fe263713aca0b556e8a9d2cb80170254420a8d1e16c0975ffe11"
  license "MIT"

  depends_on "python@3.12"
  depends_on "libreoffice" => :recommended

  resource "pdf2docx" do
    url "https://files.pythonhosted.org/packages/f4/ba/be939a4a52fb8715a8b141c0a51ee82aecf1988b8f3d3688c54cbc90af71/pdf2docx-0.5.8.tar.gz"
    sha256 "892eca8f7c418025af549e9bc92ce18168c5e0ee97343ef8dedf465bdd1dee08"
  end

  resource "PyPDF2" do
    url "https://files.pythonhosted.org/packages/cd/b5/4dc32c349b534f9bde506c5c119bd201c3e558a57cc6901a82df7750a865/PyPDF2-3.0.1.tar.gz"
    sha256 "a74408f69ba6271f71b9352ef4ed03dc53a31aa404d29b5d31f53bfecb1a3f6a"
  end

  resource "python-pptx" do
    url "https://files.pythonhosted.org/packages/eb/b3/9051d64853b89b085487a20759fb48aa5c147c761e04788f10f2648dd399/python-pptx-0.6.21.tar.gz"
    sha256 "7798a2aaf89563565b3c41c0b43b3b7bbc21f855bcea5a6458d38c128049ecfe"
  end

  def install
    # Install Python dependencies
    python = Formula["python@3.12"].opt_bin/"python3.12"
    venv = virtualenv_create(libexec, python)
    resources.each do |r|
      venv.pip_install r
    end

    # Install convert2pdf script
    bin.install "convert2pdf"

    # Install completion scripts
    bash_completion.install "convert2pdf.bash" => "convert2pdf"
    zsh_completion.install "convert2pdf.zsh" => "_convert2pdf"
  end

  def caveats
    <<~EOS
      This formula depends on LibreOffice for document conversions.
      If you did not install it as a dependency, please install it with:
        brew install --cask libreoffice
    EOS
  end

  test do
    # Basic version test
    assert_match "convert2pdf version #{version}", shell_output("#{bin}/convert2pdf --version")

    # A simple text file to test conversion
    (testpath/"test.txt").write("Hello, Homebrew!")
    system bin/"convert2pdf", "test.txt", "output.pdf"
    assert_predicate testpath/"output.pdf", :exist?
  end
end