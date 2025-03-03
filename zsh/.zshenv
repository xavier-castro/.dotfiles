# . "$HOME/.cargo/env"
# Xavier's zsh environment variables
# This file is loaded before .zshrc

# Add your PATH modifications here
export PATH="$HOME/.local/bin:$PATH"

# Set default editors
export EDITOR="nvim"
export VISUAL="nvim"

# pnpm
export PNPM_HOME="/Users/xavier/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Load private environment variables if file exists
# This ensures private keys are available to all zsh sessions
if [[ -f "$HOME/.zshenv_private" ]]; then
  source "$HOME/.zshenv_private"
fi
