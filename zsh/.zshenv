# Xavier's minimal zshenv - essential environment variables only
# This file is loaded before .zshrc

# Critical PATH exports
export PATH="$HOME/.local/bin:$HOME/.local/scripts:$PATH"

# Set default editors
export EDITOR="nvim"
export VISUAL="nvim"

# Load private environment variables if file exists
if [[ -f "$HOME/.zshenv_private" ]]; then
  source "$HOME/.zshenv_private"
fi
