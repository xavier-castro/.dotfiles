# Fast startup zshrc configuration
# Uncomment to measure startup time
# zmodload zsh/datetime
# setopt PROMPT_SUBST
# PS1='%D{%M:%S.%.} '$PS1
# LOAD_START=$EPOCHREALTIME

# Skip zbcompinit (big speedup)
skip_global_compinit=1

# Oh My Zsh with minimal settings
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
DISABLE_UNTRACKED_FILES_DIRTY="true"
DISABLE_AUTO_UPDATE="true"  # Manual updates only
COMPLETION_WAITING_DOTS="false"
DISABLE_MAGIC_FUNCTIONS="true"  # Faster paste
plugins=(git)

# Faster Oh My Zsh loading
source $ZSH/oh-my-zsh.sh

# Critical aliases
alias tt="tmux new-session -A -s 'MAIN'"

# Faster zoxide initialization  
eval "$(zoxide init zsh --hook prompt)"

# ULTRA LAZY LOADING
# ------------------

# NVM ultra-lazy loading with caching
export NVM_DIR="$HOME/.nvm"
function load_nvm() {
  export NVM_LOADED=1
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && source "/usr/local/opt/nvm/nvm.sh" --no-use
}
function nvm_commands() {
  [[ -z "$NVM_LOADED" ]] && load_nvm
  "$@"
}
alias nvm='nvm_commands nvm'
alias npm='nvm_commands npm'
alias node='nvm_commands node'
alias npx='nvm_commands npx'

# PNPM lazy loading with immediate path addition for faster first use
export PNPM_HOME="/Users/xavier/Library/pnpm"
function pnpm() {
  unset -f pnpm
  export PATH="$PNPM_HOME:$PATH"
  pnpm "$@"
}

# Bun lazy loading
export BUN_INSTALL="$HOME/.bun"
function bun() {
  unset -f bun
  export PATH="$BUN_INSTALL/bin:$PATH"
  [ -s "/Users/xavier/.bun/_bun" ] && source "/Users/xavier/.bun/_bun"
  bun "$@"
}

# Custom keybindings
bindkey -s '^f' 'tmux-sessionizer\n'

# Deferred loading - load at the very end of startup
# Use a function to defer loading even further
function load_deferred() {
  # Load syntax highlighting and autosuggestions with optimized settings
  if [[ -f ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    ZSH_HIGHLIGHT_MAXLENGTH=300
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)
    source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  fi
  
  if [[ -f ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
    ZSH_AUTOSUGGEST_STRATEGY=(history)
    source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  fi
}

# Call the deferred loading function in the background
(load_deferred &)

# Uncomment to see total load time
# LOAD_END=$EPOCHREALTIME
# echo "Shell loaded in $((($LOAD_END - $LOAD_START) * 1000)) ms"
