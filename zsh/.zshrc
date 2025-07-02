ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions


# zinit light mafredri/zsh-async  # dependency
# zinit ice pick"async.zsh" src"pure.zsh"
# zinit light sindresorhus/pure

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
    # autoload -U colors && colors
    # PROMPT='%{$fg[cyan]%}%c%{$reset_color%} %{$fg[green]%}➜%{$reset_color%} '
fi

    autoload -U colors && colors
    PROMPT='%{$fg[cyan]%}%c%{$reset_color%} %{$fg[green]%}➜%{$reset_color%} '

# opencode
export PATH=/Users/xavier/.opencode/bin:$PATH
# personal scripts
export PATH=/Users/xavier/.dotfiles/bin/.local/scripts:$PATH

# navi (ctrl+g cheatsheet)
eval "$(navi widget zsh)"                    # load the zsh widget

# ============================================================================
# ESSENTIAL ALIASES
# ============================================================================
# Aliases
alias ls="ls -p -G"
alias la="ls -A"
alias ll="eza -l -g --icons"
alias lla="ll -a"
alias tt="tmux new-session -A -s 'MAIN'"
alias tk="tmux kill-server"
alias lg="lazygit"
alias claude="/Users/xavier/.claude/local/claude"
alias c="claude"
alias g="gemini"
alias j="/Users/xavier/.local/bin/jrnl-daily"


bindkey -s ^f "tmux-sessionizer\n"
bindkey -s '\eh' "tmux-sessionizer -s 0\n"
bindkey -s '\et' "tmux-sessionizer -s 1\n"
bindkey -s '\en' "tmux-sessionizer -s 2\n"
bindkey -s '\es' "tmux-sessionizer -s 3\n"

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


