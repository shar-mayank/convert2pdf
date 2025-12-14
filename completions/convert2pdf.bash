# Bash completion for convert2pdf
# Author: Mayank Sharma
# Repository: https://github.com/shar-mayank/convert2pdf

_convert2pdf() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # All available options
    opts="-h --help -v --version --setup --batch"

    # Supported file extensions for completion
    local extensions="doc docx ppt pptx xls xlsx odt odp ods pdf txt rtf csv"

    # Handle options
    if [[ ${cur} == -* ]]; then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi

    case "${prev}" in
        --batch)
            # For batch mode, suggest glob patterns
            COMPREPLY=( $(compgen -f "${cur}") )
            return 0
            ;;
        -h|--help|-v|--version|--setup)
            # These options don't take arguments
            return 0
            ;;
        convert2pdf)
            # First argument: input file or option
            COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) $(compgen -f "${cur}") )
            return 0
            ;;
        *)
            # Complete with file paths (for output file)
            COMPREPLY=( $(compgen -f "${cur}") )
            return 0
            ;;
    esac
}

complete -o filenames -o bashdefault -F _convert2pdf convert2pdf