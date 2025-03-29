# High-performance zsh configuration

# Enable timing measurement (uncomment to enable)
# zmodload zsh/datetime
# LOAD_START=$EPOCHREALTIME

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY          # Share history between sessions
setopt HIST_IGNORE_SPACE      # Don't record commands starting with space
setopt HIST_IGNORE_DUPS       # Don't record duplicated commands
setopt HIST_EXPIRE_DUPS_FIRST # Delete dupes first when HISTFILE size exceeds HISTSIZE

# Basic zsh settings for good UX
setopt AUTO_CD       # If command is directory name, cd into it
setopt NO_CASE_GLOB  # Case insensitive globbing
setopt EXTENDED_GLOB # Extended globbing capabilities
setopt PROMPT_SUBST  # Allow parameter expansion in prompt

# Minimal but useful key bindings
bindkey -e                         # Use emacs keybindings
bindkey '^[[A' up-line-or-search   # Up arrow searches history
bindkey '^[[B' down-line-or-search # Down arrow searches history

# Fixed keybinding for tmux-sessionizer
bindkey -s '^f' 'tmux-sessionizer\n' # Simplified keybinding

# Basic completion system - faster than Oh My Zsh
autoload -Uz compinit
compinit -C # -C flag skips check that speeds up loading
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive tab completion

# Git status function for prompt - much faster than Oh My Zsh git plugin
function git_prompt_info() {
  local ref
  ref=$(git symbolic-ref HEAD 2>/dev/null) || return
  echo " %F{yellow}(${ref#refs/heads/})%f"
}

# Robbyrussell-inspired theme but much faster
PROMPT='%F{cyan}%c%f$(git_prompt_info) %F{red}❯%f '

# Critical aliases
alias tt="tmux new-session -A -s 'MAIN'"
alias ls="ls -G"
alias ll="ls -la"

# Fast zoxide initialization
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

# PNPM lazy loading
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

# MINIMAL PLUGIN REPLACEMENTS
# --------------------------

# Syntax highlighting - minimal and async load
if [[ -f ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]]; then
  source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
elif [[ -f ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  ZSH_HIGHLIGHT_MAXLENGTH=300
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)
  source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Autosuggestions - minimal and async load
if [[ -f ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
  ZSH_AUTOSUGGEST_STRATEGY=(history)
  ZSH_AUTOSUGGEST_USE_ASYNC=1
  source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Uncomment to see total load time
# LOAD_END=$EPOCHREALTIME
# echo "Shell loaded in $((($LOAD_END - $LOAD_START) * 1000)) ms"
