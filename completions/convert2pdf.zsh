#compdef convert2pdf
# Zsh completion for convert2pdf
# Author: Mayank Sharma
# Repository: https://github.com/shar-mayank/convert2pdf

_convert2pdf() {
    local -a opts
    local -a file_patterns

    opts=(
        '(-h --help)'{-h,--help}'[Show help message]'
        '(-v --version)'{-v,--version}'[Show version information]'
        '--setup[Install required dependencies]'
        '--batch[Process multiple files matching input pattern]:pattern:_files'
    )

    file_patterns=(
        '*.doc' '*.docx' '*.ppt' '*.pptx' '*.xls' '*.xlsx'
        '*.odt' '*.odp' '*.ods' '*.pdf' '*.txt' '*.rtf' '*.csv'
    )

    _arguments -s \
        $opts \
        '1:input file:_files -g "*(#i)(doc|docx|ppt|pptx|xls|xlsx|odt|odp|ods|pdf|txt|rtf|csv)"' \
        '2:output file:_files'
}

_convert2pdf "$@"