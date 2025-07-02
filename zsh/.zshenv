# Fast ZSH Environment Configuration (.zshenv)
# This file is sourced for all zsh invocations
# Keep this minimal for fastest startup times

# Skip global RC files for better control and speed
setopt no_global_rcs

# Set umask for file permissions
umask o-w

# Essential environment variables that all shells need
export ZDOTDIR=${ZDOTDIR:-$HOME}

# XDG Base Directory Specification (for better organization)
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

# Essential PATH components that need to be available to all processes
# (GUI applications launched from desktop, scripts, etc.)
typeset -U path
path=(
    $HOME/bin
    $HOME/.local/bin
    $HOME/.cargo/bin
    /usr/local/bin
    $path
)

# Export PATH for subprocesses
export PATH

# Language and locale settings
export LANG=${LANG:-en_US.UTF-8}
export LC_ALL=${LC_ALL:-en_US.UTF-8}

# Terminal settings
export TERM=${TERM:-xterm-256color}

# Default applications
export EDITOR=${EDITOR:-nvim}
export VISUAL=${VISUAL:-nvim}
export PAGER=${PAGER:-less}

# Development tool settings
export GOPATH=${GOPATH:-$HOME/go}
export CARGO_HOME=${CARGO_HOME:-$HOME/.cargo}
export RUSTUP_HOME=${RUSTUP_HOME:-$HOME/.rustup}

# Performance: Skip some checks if we're not in an interactive shell
[[ $- == *i* ]] || return

# Only continue with interactive shell setup if needed
[[ -o interactive ]] || return

. "$HOME/.cargo/env"
