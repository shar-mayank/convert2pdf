# Bash completion for convert2pdf
_convert2pdf() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="-h --help -v --version"

    if [[ ${cur} == -* ]]; then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi

    case "${prev}" in
        convert2pdf)
            # Complete with file paths
            COMPREPLY=( $(compgen -f "${cur}") )
            return 0
            ;;
        *)
            # Complete with file paths
            COMPREPLY=( $(compgen -f "${cur}") )
            return 0
            ;;
    esac
}
complete -F _convert2pdf convert2pdf