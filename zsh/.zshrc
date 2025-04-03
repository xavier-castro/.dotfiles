# High-performance zsh configuration
export EDITOR="nvim"
export VISUAL="nvim"
export PATH="$HOME/.local/bin:$HOME/.local/scripts:$PATH"
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
setopt AUTO_CD              # If command is directory name, cd into it
setopt NO_CASE_GLOB         # Case insensitive globbing
setopt EXTENDED_GLOB        # Extended globbing capabilities
setopt PROMPT_SUBST         # Allow parameter expansion in prompt

# Minimal but useful key bindings
bindkey -e                  # Use emacs keybindings
bindkey '^[[A' up-line-or-search    # Up arrow searches history
bindkey '^[[B' down-line-or-search  # Down arrow searches history

# Fixed keybinding for tmux-sessionizer
bindkey -s '^f' 'tmux-sessionizer\n'  # Simplified keybinding

# Basic completion system - faster than Oh My Zsh
autoload -Uz compinit
compinit -C # -C flag skips check that speeds up loading
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive tab completion

# Git status function for prompt - much faster than Oh My Zsh git plugin
function git_prompt_info() {
  local ref
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " %F{yellow}(${ref#refs/heads/})%f"
}

# Robbyrussell-inspired theme but much faster
PROMPT='%F{cyan}%c%f$(git_prompt_info) %F{red}❯%f '

# Critical aliases
alias tt="tmux new-session -A -s 'MAIN'"
alias tk="tmux kill-server"
alias ls="eza --icons --group-directories-first --color=auto"
alias ll="eza --icons --group-directories-first -la --git --header --color-scale --time-style=long-iso"
alias lt="eza --icons --group-directories-first -laT --git-ignore --level=2"

# Fast zoxide initialization
eval "$(zoxide init zsh --hook prompt)"

# ULTRA LAZY LOADING
# ------------------

autoload -U compinit && compinit

export PATH="$HOME/.cargo/bin:$PATH"
# So pipx works correctly

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


export PATH="$HOME/.cargo/bin:$PATH"

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


# Highlighting and Autosuggestions
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load private env vars
[[ -f "$HOME/.zshenv_private" ]] && source "$HOME/.zshenv_private"
#
# Uncomment to see total load time
# LOAD_END=$EPOCHREALTIME
# echo "Shell loaded in $((($LOAD_END - $LOAD_START) * 1000)) ms"
eval "$(starship init zsh)" # CLI theme

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
