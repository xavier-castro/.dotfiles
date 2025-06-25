# Ultra-Fast ZSH Configuration
# Minimal setup for maximum speed

# ============================================================================
# PATH - Set once, export immediately
# ============================================================================
typeset -U path
path=(
/usr/local/bin
~/bin
~/.cargo/bin
~/go/bin
~/.rustup/toolchains/stable-x86_64-apple-darwin/bin
~/.volta/bin
$path
)
export PATH


# ============================================================================
# SHELL OPTIONS - Minimal set for good UX
# ============================================================================
setopt auto_cd # cd by typing directory name
setopt auto_pushd # push old directory onto stacksetopt pushd_ignore_dups     # don't duplicate directories
setopt extended_history # timestamp in history
setopt hist_ignore_dups # ignore duplicate commands
setopt hist_ignore_space # ignore commands starting with space
setopt share_history # share history between sessions
setopt glob_dots # include dotfiles in globs
setopt complete_in_word # complete from cursor position
setopt prompt_subst # enable prompt expansion

# ============================================================================
# HISTORY
# ============================================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# ============================================================================
# FAST ROBBYRUSSELL PROMPT
# ============================================================================
# Load our custom fast prompt
if [[ -f ~/.dotfiles/zsh/robbyrussell-fast.zsh ]]; then
    source ~/.dotfiles/zsh/robbyrussell-fast.zsh
else
    # Fallback ultra-minimal prompt
    autoload -U colors && colors
    PROMPT='%{$fg[cyan]%}%c%{$reset_color%} %{$fg[green]%}➜%{$reset_color%} '
fi

# ============================================================================
# ESSENTIAL ALIASES
# ============================================================================
alias ls="ls -p -G"
alias la="ls -A"
alias ll="ls -l"
alias lla="ll -A"alias lg="lazygit"
alias tt="tmux new-session -A -s 'MAIN'"
alias ta="tmux"

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================
md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }

# Todoist CLI helper functions
function tadd() {
    local task_content="$1"
    local project=""
    local label=""
    local args=()

    # Parse remaining arguments for p:Project and l:label syntax
    shift
    for arg in "$@"; do
        case "$arg" in
        p:*) project="${arg#p:}" ;;
        l:*) label="${arg#l:}" ;;
        *) args+=("$arg") ;;
        esac
    done

    # Build todoist command
    local cmd=("todoist" "add" "$task_content")
    [[ -n "$project" ]] && cmd+=("--project" "$project")
    [[ -n "$label" ]] && cmd+=("--label" "$label")

    # Add any remaining arguments
    cmd+=("${args[@]}")

    # Execute the command
    "${cmd[@]}"
}

function tnext() {
    todoist list --filter "today | overdue" | fzf --preview "echo 'Task details: {}'"
}

# Quick complete function for today/overdue tasks
function tcomplete() {
    local selected
    selected=$(todoist list --filter "today | overdue" | fzf --prompt="Complete task: ")
    if [[ -n "$selected" ]]; then
        # Extract task ID from the selected line (assuming it's the first field)
        local task_id=$(echo "$selected" | awk '{print $1}')
        todoist complete "$task_id"
        echo "Completed: $selected"
    fi
}

# ============================================================================
# MINIMAL COMPLETION SETUP
# ============================================================================
# Only initialize if not already done (check for cache)
if [[ ! -f ~/.zcompdump || ~/.zshrc -nt ~/.zcompdump ]]; then
    autoload -Uz compinit
    compinit -d ~/.zcompdump
else
    autoload -Uz compinit
    compinit -C -d ~/.zcompdump
fi

# Basic completion settings
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# ============================================================================
# KEY BINDINGS
# ============================================================================
bindkey -v # vi mode
bindkey '^R' history-incremental-search-backward
bindkey '^F' history-incremental-search-forward
bindkey -s '^f' "tmux-sessionizer\n" # ctrl-f for tmux sessionizer

# ============================================================================
# NAVI - Interactive cheatsheet tool
# ============================================================================
_navi_call() {
    local result="$(navi "$@" </dev/tty)"
    printf "%s" "$result"
}

_navi_widget() {
    local -r input="${LBUFFER}"
    local -r last_command="$(echo "${input}" | navi fn widget::last_command)"
    local replacement="$last_command"

    if [ -z "$last_command" ]; then
        replacement="$(_navi_call --print)"
    elif [ "$LASTWIDGET" = "_navi_widget" ] && [ "$input" = "$previous_output" ]; then
        replacement="$(_navi_call --print --query "$last_command")"
    else
        replacement="$(_navi_call --print --best-match --query "$last_command")"
    fi

    if [ -n "$replacement" ]; then
        local -r find="${last_command}_NAVIEND"
        previous_output="${input}_NAVIEND"
        previous_output="${previous_output//$find/$replacement}"
    else
        previous_output="$input"
    fi

    zle kill-whole-line
    LBUFFER="${previous_output}"
    region_highlight=("P0 100 bold")
    zle redisplay
}

zle -N _navi_widget
bindkey '^g' _navi_widget

# ============================================================================
# CONDITIONAL LOADING - Only if files exist
# ============================================================================
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -f ~/.zsh_private ]] && source ~/.zsh_private
[[ -f ~/.cargo/env ]] && source ~/.cargo/env

# ============================================================================
# BACKGROUND COMPILATION for next startup
# ============================================================================
{
    # Compile this file for faster loading
    [[ ~/.zshrc -nt ~/.zshrc.zwc ]] && zcompile ~/.zshrc
    # Compile completion dump
    [[ ~/.zcompdump -nt ~/.zcompdump.zwc ]] && zcompile ~/.zcompdump
} &!
alias j="/Users/xavier/.local/bin/jrnl-daily"
