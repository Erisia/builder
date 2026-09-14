# Call out unread crash analyses at every prompt. Works in bash and zsh.
#
# Source this from ~/.bashrc and ~/.zshrc:
#   [[ -f ~/builder/tools/crash-analysis-notice.sh ]] && source ~/builder/tools/crash-analysis-notice.sh
#
# start.py (via crash_analysis.py) writes one <stamp>.md per crash into
# <server>/crash-analysis/. A report counts as unread until it is older than the
# directory's .seen marker; `crash-analysis-ack` refreshes the marker. The
# account is shared, so the notice keeps repeating until somebody acknowledges
# it on purpose rather than disappearing after one person has seen it.

crash_analysis_unread() {
    [[ -n "${ZSH_VERSION:-}" ]] && setopt local_options null_glob
    local dir report
    for dir in "$HOME"/*/crash-analysis; do
        [[ -d "$dir" ]] || continue
        for report in "$dir"/*.md; do
            [[ -f "$report" ]] || continue
            if [[ ! -e "$dir/.seen" || "$report" -nt "$dir/.seen" ]]; then
                printf '%s\n' "$report"
            fi
        done
    done
}

crash_analysis_notice() {
    local unread count shown=0 report
    unread=$(crash_analysis_unread)
    [[ -n "$unread" ]] || return 0
    count=$(printf '%s\n' "$unread" | wc -l)
    printf '\033[1;33m%s unread Minecraft crash %s\033[0m (crash-analysis-ack to dismiss):\n' \
        "$count" "$([[ "$count" -eq 1 ]] && echo analysis || echo analyses)"
    while IFS= read -r report; do
        if [[ "$shown" -ge 5 ]]; then
            printf '  ... and %s more\n' "$((count - shown))"
            break
        fi
        printf '  \033[33m%s\033[0m\n' "${report#"$HOME"/}"
        shown=$((shown + 1))
    done <<< "$unread"
}

# Mark all crash analyses as read, or only those of the given server directories.
crash-analysis-ack() {
    [[ -n "${ZSH_VERSION:-}" ]] && setopt local_options null_glob
    local dir
    if [[ $# -eq 0 ]]; then
        set -- "$HOME"/*/
    fi
    for dir in "$@"; do
        dir="${dir%/}"
        [[ -d "$dir" || ! -d "$HOME/$dir" ]] || dir="$HOME/$dir"   # bare server names are relative to $HOME
        [[ "$dir" == */crash-analysis ]] || dir="$dir/crash-analysis"
        if [[ -d "$dir" ]]; then
            touch "$dir/.seen" && printf 'acknowledged %s\n' "${dir#"$HOME"/}"
        else
            printf 'no such directory: %s\n' "$dir" >&2
        fi
    done
}

if [[ -n "${ZSH_VERSION:-}" ]]; then
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd crash_analysis_notice   # idempotent
elif [[ -n "${BASH_VERSION:-}" ]]; then
    case ";${PROMPT_COMMAND:-};" in
        *";crash_analysis_notice;"*) ;;
        *) PROMPT_COMMAND="crash_analysis_notice${PROMPT_COMMAND:+;$PROMPT_COMMAND}" ;;
    esac
fi
