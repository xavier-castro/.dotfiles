# Zsh environment file
# This file is sourced by all zsh instances

if [ -n "${ZSH_VERSION-}" ]; then
  # Export environment variables that need to be available to all shells
  # Add any global environment variables here if needed
  
  # Example:
  # export GOPATH=$HOME/go
  
  : ${ZDOTDIR:=~}
fi
