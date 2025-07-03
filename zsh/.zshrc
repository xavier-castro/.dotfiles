# ~/.zshrc - Optimized configuration for speed

# === PERFORMANCE OPTIMIZATIONS ===
# Skip global compinit (we'll do it once at the end)
skip_global_compinit=1

# === ENVIRONMENT VARIABLES ===
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

# === SHELL OPTIONS ===
setopt auto_cd auto_pushd pushd_ignore_dups
setopt extended_history hist_ignore_dups hist_ignore_space share_history
setopt glob_dots complete_in_word prompt_subst

# === PATH SETUP ===
# Build PATH efficiently (only if directories exist)
typeset -U path  # Keep PATH unique
path_additions=(
    "$HOME/.cargo/bin"
    "$HOME/.opencode/bin"
    "$HOME/.dotfiles/bin/.local/scripts"
    "$HOME/.bun/bin"
    "/Applications/Emacs.app/Contents/MacOS/bin"
)

for dir in $path_additions; do
    [[ -d "$dir" ]] && path=("$dir" $path)
done

# === PROMPT ===
# Fast minimal prompt (fallback if custom prompt unavailable)
if [[ -f ~/.dotfiles/zsh/robbyrussell-fast.zsh ]]; then
    source ~/.dotfiles/zsh/robbyrussell-fast.zsh
else
    autoload -U colors && colors
    PROMPT='%{$fg[cyan]%}%c%{$reset_color%} %{$fg[green]%}➜%{$reset_color%} '
fi

# === ALIASES ===
alias ls="ls -p -G"
alias la="ls -A"
alias ll="eza -l -g --icons"
alias lla="ll -a"
alias tt="tmux new-session -A -s 'MAIN'"
alias tk="tmux kill-server"
alias lg="lazygit"
alias claude="$HOME/.claude/local/claude"
alias c="claude"
alias g="gemini"
alias j="$HOME/.local/bin/jrnl-daily"
alias ec="emacsclient -n -e '(make-frame)'"

# === KEY BINDINGS ===
bindkey -v  # vi mode
bindkey -s '^f' "tmux-sessionizer\n"
bindkey -s '\eh' "tmux-sessionizer -s 0\n"
bindkey -s '\et' "tmux-sessionizer -s 1\n"
bindkey -s '\en' "tmux-sessionizer -s 2\n"
bindkey -s '\es' "tmux-sessionizer -s 3\n"

# === LAZY LOADING FUNCTIONS ===
# Only load these when actually needed

# Zinit lazy loader
load_zinit() {
    ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
    [[ ! -d $ZINIT_HOME ]] && mkdir -p "$(dirname $ZINIT_HOME)"
    [[ ! -d $ZINIT_HOME/.git ]] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
    source "${ZINIT_HOME}/zinit.zsh"

    # Load essential plugins only
    zinit wait lucid light-mode for \
        atinit"zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
        atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions

    unfunction load_zinit
}

# FZF lazy loader
load_fzf() {
    [[ -f "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" ]] && \
        source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
    unfunction load_fzf
}

# Zoxide lazy loader
load_zoxide() {
    command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
    unfunction load_zoxide
}

# Navi lazy loader
load_navi() {
    command -v navi >/dev/null && eval "$(navi widget zsh)"
    unfunction load_navi
}

# === COMPLETION SETUP ===
# Optimized completion initialization
if [[ ! -f ~/.zcompdump || ~/.zshrc -nt ~/.zcompdump ]]; then
    autoload -Uz compinit
    compinit -d ~/.zcompdump
else
    autoload -Uz compinit
    compinit -C -d ~/.zcompdump
fi

# Docker completions (if available)
[[ -d ~/.docker/completions ]] && fpath=(~/.docker/completions $fpath)

# Completion styles
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# === CONDITIONAL LOADING ===
# Load tools only when needed via command hooks

# Auto-load zinit on first plugin-related command
zinit() { load_zinit && zinit "$@"; }

# Auto-load fzf on first fzf command
fzf() { load_fzf && fzf "$@"; }

# Auto-load zoxide on first z command
z() { load_zoxide && z "$@"; }

# Auto-load navi on first navi command
navi() { load_navi && navi "$@"; }

# === EXTERNAL SOURCES ===
# Source additional configs if they exist
[[ -f ~/.zsh_private.zshrc ]] && source ~/.zsh_private.zshrc
[[ -f ~/.cargo/env ]] && source ~/.cargo/env
[[ -s ~/.bun/_bun ]] && source ~/.bun/_bun

# === AUTO-LOAD ON STARTUP (Optional) ===
# Uncomment these if you want immediate loading instead of lazy loading
load_zinit  # Enable for syntax highlighting and autosuggestions
# load_fzf
# load_zoxide

# nb - Personal Knowledge Base System
export PATH="$HOME/nb/bin:$PATH"
