# ~/.zshenv
# Universal environment variables and PATH (runs for every shell)
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# Homebrew
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# Add user bin directories
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# Node.js/npm global packages
export PATH="$HOME/.npm-global/bin:$PATH"

# Rust
. "$HOME/.cargo/env"

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Volta (Node.js version manager)
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export PATH="/Applications/Emacs.app/Contents/MacOS:$PATH"
export PATH="$HOME/nb/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"

# Default editor
export EDITOR="nvim"
export VISUAL="nvim"

# Language settings
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
