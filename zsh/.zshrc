# ~/.zshrc - Interactive shell configuration

# --- Zinit plugin manager ---
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

# zinit light mafredri/zsh-async # dependency
# zinit ice pick"async.zsh" src"pure.zsh"
# zinit light sindresorhus/pure

# --- Source Rust environment for interactive shells ---
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# --- Shell options ---
setopt auto_cd           # cd by typing directory name
setopt auto_pushd        # push old directory onto stack
setopt pushd_ignore_dups # don't duplicate directories
setopt extended_history  # timestamp in history
setopt hist_ignore_dups  # ignore duplicate commands
setopt hist_ignore_space # ignore commands starting with space
setopt share_history     # share history between sessions
setopt glob_dots         # include dotfiles in globs
setopt complete_in_word  # complete from cursor position
setopt prompt_subst      # enable prompt expansion

# --- History ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# --- Fast RobbyRussell Prompt ---
if [[ -f ~/.dotfiles/zsh/robbyrussell-fast.zsh ]]; then
    source ~/.dotfiles/zsh/robbyrussell-fast.zsh
else
    autoload -U colors && colors
    PROMPT='%{$fg[cyan]%}%c%{$reset_color%} %{$fg[green]%}➜%{$reset_color%} '
fi

# --- PATH additions for interactive shells only ---
export PATH="/Users/xavier/.opencode/bin:$PATH"
export PATH="/Users/xavier/.dotfiles/bin/.local/scripts:$PATH"

# --- Aliases ---
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

# --- Key bindings ---
bindkey -v # vi mode
bindkey '^R' history-incremental-search-backward
bindkey '^F' history-incremental-search-forward
bindkey -s '^f' "tmux-sessionizer\n"
bindkey -s '\eh' "tmux-sessionizer -s 0\n"
bindkey -s '\et' "tmux-sessionizer -s 1\n"
bindkey -s '\en' "tmux-sessionizer -s 2\n"
bindkey -s '\es' "tmux-sessionizer -s 3\n"

# --- Todoist CLI helper functions ---
tadd() {
    local task_content="$1"
    local project=""
    local label=""
    local args=()
    shift
    for arg in "$@"; do
        case "$arg" in
            p:*) project="${arg#p:}" ;;
            l:*) label="${arg#l:}" ;;
            *) args+=("$arg") ;;
        esac
    done
    local cmd=("todoist" "add" "$task_content")
    [[ -n "$project" ]] && cmd+=("--project" "$project")
    [[ -n "$label" ]] && cmd+=("--label" "$label")
    cmd+=("${args[@]}")
    "${cmd[@]}"
}

tnext() {
    todoist list --filter "today | overdue" | fzf --preview "echo 'Task details: {}'"
}

tcomplete() {
    local selected
    selected=$(todoist list --filter "today | overdue" | fzf --prompt="Complete task: ")
    if [[ -n "$selected" ]]; then
        local task_id=$(echo "$selected" | awk '{print $1}')
        todoist complete "$task_id"
        echo "Completed: $selected"
    fi
}

# --- Completion setup ---
if [[ ! -f ~/.zcompdump || ~/.zshrc -nt ~/.zcompdump ]]; then
    autoload -Uz compinit
    compinit -d ~/.zcompdump
else
    autoload -Uz compinit
    compinit -C -d ~/.zcompdump
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# --- navi and zoxide ---
eval "$(navi widget zsh)"
eval "$(zoxide init zsh)"
