# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Performance measurement - uncomment to enable
# zmodload zsh/zprof

# Fast theme loading
ZSH_THEME="robbyrussell"

# Speed optimization: Disable marking untracked files as dirty
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Minimal essential plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
# -----------------

# Aliases
alias tt="tmux new-session -A -s 'MAIN'"

# Fast directory navigation
eval "$(zoxide init zsh)"

# Package managers - LAZY LOADED
# -----------------------------

# Lazy-load NVM (only loads when you actually use node, npm, etc.)
export NVM_DIR="$HOME/.nvm"
nvm() {
  unset -f nvm node npm npx
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && source "/usr/local/opt/nvm/nvm.sh"
  nvm "$@"
}
node() {
  unset -f nvm node npm npx
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && source "/usr/local/opt/nvm/nvm.sh"
  node "$@"
}
npm() {
  unset -f nvm node npm npx
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && source "/usr/local/opt/nvm/nvm.sh"
  npm "$@"
}
npx() {
  unset -f nvm node npm npx
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && source "/usr/local/opt/nvm/nvm.sh"
  npx "$@"
}

# Lazy-load pnpm
export PNPM_HOME="/Users/xavier/Library/pnpm"
pnpm() {
  unset -f pnpm
  export PATH="$PNPM_HOME:$PATH"
  pnpm "$@"
}

# Lazy-load bun
export BUN_INSTALL="$HOME/.bun"
bun() {
  unset -f bun
  export PATH="$BUN_INSTALL/bin:$PATH"
  [ -s "/Users/xavier/.bun/_bun" ] && source "/Users/xavier/.bun/_bun"
  bun "$@"
}

# Load syntax highlighting and autosuggestions last
# These can be slow on large commands
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

# Custom keybindings
bindkey -s '^f' 'tmux-sessionizer\n'

# Performance measurement end - uncomment if you enabled it at the top
# zprof
