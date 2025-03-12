# . "$HOME/.cargo/env"
# Xavier's zsh environment variables
# This file is loaded before .zshrc

# Add your PATH modifications here
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/scripts:$PATH"

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


# bun completions
[ -s "/Users/xavier/.bun/_bun" ] && source "/Users/xavier/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"



# Load private environment variables if file exists
# This ensures private keys are available to all zsh sessions
if [[ -f "$HOME/.zshenv_private" ]]; then
  source "$HOME/.zshenv_private"
fi
