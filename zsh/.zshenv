# ~/.zshenv - Minimal, for all zsh invocations

setopt no_global_rcs
umask o-w

# XDG Base Directory Specification
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

# Zsh config directory
export ZDOTDIR="${ZDOTDIR:-$HOME}"

# Universal PATH (for all shells, including GUI apps)
typeset -U path
path=(
    $HOME/bin
    $HOME/.local/bin
    $HOME/.cargo/bin
    /usr/local/bin
    $HOME/RepoPrompt
    $path
)
export PATH

# Locale and terminal
export LANG="${LANG:-en_US.UTF-8}"
export LC_ALL="${LC_ALL:-en_US.UTF-8}"
export TERM="${TERM:-xterm-256color}"

# Default applications
export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-nvim}"
export PAGER="${PAGER:-less}"

# Development tool settings
export GOPATH="${GOPATH:-$HOME/go}"
export CARGO_HOME="${CARGO_HOME:-$HOME/.cargo}"
export RUSTUP_HOME="${RUSTUP_HOME:-$HOME/.rustup}"

# Only continue with interactive shell setup if needed
[[ $- == *i* ]] || return
[[ -o interactive ]] || return