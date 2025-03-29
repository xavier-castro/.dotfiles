# Ultra-minimal zshenv - absolute essentials only
export EDITOR="nvim"
export VISUAL="nvim"
export PATH="$HOME/.local/bin:$HOME/.local/scripts:$PATH"

# Load private env vars
[[ -f "$HOME/.zshenv_private" ]] && source "$HOME/.zshenv_private"
. "$HOME/.cargo/env"
