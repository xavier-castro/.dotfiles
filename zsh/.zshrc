# ~/.zshrc - ZSH Configuration File

#------------------------------------------------------------------------------
# PATH Configuration
#------------------------------------------------------------------------------
# Add various directories to PATH
export BUN_INSTALL="$HOME/.bun"
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/scripts:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH="$BUN_INSTALL/bin:$PATH"
export GOPATH="$HOME/go"

#------------------------------------------------------------------------------
# Environment Variables
#------------------------------------------------------------------------------
# Homebrew settings
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ENV_HINTS=1

# Set default editor
export EDITOR='nvim'
export VISUAL='nvim'

#------------------------------------------------------------------------------
# History Configuration
#------------------------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS  # Don't record duplicates
setopt HIST_FIND_NO_DUPS     # Don't show duplicates in search
setopt HIST_SAVE_NO_DUPS     # Don't write duplicates to history file
setopt HIST_IGNORE_SPACE     # Don't record commands that start with space
setopt APPEND_HISTORY        # Append to history file
setopt INC_APPEND_HISTORY    # Add commands as they are typed, not at shell exit
setopt SHARE_HISTORY         # Share history between sessions

#------------------------------------------------------------------------------
# Basic ZSH Options
#------------------------------------------------------------------------------
setopt AUTO_CD               # Change directory without cd command
setopt AUTO_PUSHD            # Push the old directory onto the stack on cd
setopt PUSHD_IGNORE_DUPS     # Do not store duplicates in the stack
setopt PUSHD_SILENT          # Do not print the directory stack after pushd or popd
setopt EXTENDED_GLOB         # Use extended globbing
setopt CORRECT               # Command correction
setopt INTERACTIVE_COMMENTS  # Allow comments in interactive shells

#------------------------------------------------------------------------------
# Completion System
#------------------------------------------------------------------------------
# Initialize the completion system
autoload -Uz compinit && compinit

# Cache completion to speed things up
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Completion options
zstyle ':completion:*' menu select                 # Menu-driven completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Colored completion
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''               # Group results by category
zstyle ':completion:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'

#------------------------------------------------------------------------------
# Key Bindings
#------------------------------------------------------------------------------
# Use emacs key bindings
bindkey -e

# Useful key bindings
bindkey '^[[A' up-line-or-search                   # Up arrow for history search
bindkey '^[[B' down-line-or-search                 # Down arrow for history search
bindkey '^[[H' beginning-of-line                   # Home key
bindkey '^[[F' end-of-line                         # End key
bindkey '^[[3~' delete-char                        # Delete key
bindkey '^[[1;5C' forward-word                     # Ctrl+Right
bindkey '^[[1;5D' backward-word                    # Ctrl+Left

#------------------------------------------------------------------------------
# Syntax Highlighting
#------------------------------------------------------------------------------
# Install fast-syntax-highlighting if not already installed
if [[ ! -d ~/.zsh/fast-syntax-highlighting ]]; then
  echo "Installing fast-syntax-highlighting..."
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ~/.zsh/fast-syntax-highlighting
fi

# Source syntax highlighting
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

#------------------------------------------------------------------------------
# Autosuggestions
#------------------------------------------------------------------------------
# Install zsh-autosuggestions if not already installed
if [[ ! -d ~/.zsh/zsh-autosuggestions ]]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
fi

# Source autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Configure autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#8a8a8a"

#------------------------------------------------------------------------------
# Starship Prompt
#------------------------------------------------------------------------------
# Initialize Starship prompt if installed
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
else
  echo "Starship is not installed. Install it with: brew install starship"
  # Simple fallback prompt if Starship is not available
  PS1='%F{green}%n@%m%f:%F{blue}%~%f$ '
fi

#------------------------------------------------------------------------------
# Eza Aliases (Modern ls replacement)
#------------------------------------------------------------------------------
# Replace standard ls commands with eza
# --icons shows icons, --group-directories-first shows folders first
alias ls="eza --icons --group-directories-first"
alias ll="eza --icons --group-directories-first -l"
alias lla="eza --icons --group-directories-first -la"
alias lt="eza --icons --group-directories-first -T"  # Tree view
alias lg="eza --icons --group-directories-first --git -l"  # Show git status

#------------------------------------------------------------------------------
# Git Aliases
#------------------------------------------------------------------------------
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias gb="git branch"
alias glog="git log --oneline --graph --decorate"

#------------------------------------------------------------------------------
# Other Aliases
#------------------------------------------------------------------------------
alias pip=/usr/bin/pip3
alias tt="tmux new-session -A -s 'MAIN'"
alias tk="tmux kill-server"
alias zshrc="$EDITOR ~/.zshrc"
alias reload="source ~/.zshrc"

#------------------------------------------------------------------------------
# Private Configuration
#------------------------------------------------------------------------------
# Source private configuration if it exists
[[ -f ~/.zsh_private.zshrc ]] && source ~/.zsh_private.zshrc

#------------------------------------------------------------------------------
# Zoxide (Smart cd command)
#------------------------------------------------------------------------------
# Initialize zoxide if installed
eval "$(zoxide init zsh)"

# UV and UVX Configuration for Python package management
# Initialize UV/UVX only if they're installed
if command -v uv &> /dev/null; then
  # Add UV to PATH if not already there
  export PATH="$HOME/.local/bin:$PATH"

  # Enable UV shell completion - lazy-loaded to maintain shell startup speed
  uv_completion_setup() {
    eval "$(uv --completion-script)"
    # Remove this function after first use to avoid repeated evaluation
    unfunction uv_completion_setup
  }

  # Create function aliases that load completion only when needed
  uv() {
    uv_completion_setup
    command uv "$@"
  }

  # Convenient aliases for common operations
  alias pipi='uv pip install'
  alias pipup='uv pip install --upgrade'

  # UVX specific configuration (if installed)
  if command -v uvx &> /dev/null; then
    # Load UVX completion only when needed
    uvx_completion_setup() {
      eval "$(uvx --completion-script)"
      unfunction uvx_completion_setup
    }

    uvx() {
      uvx_completion_setup
      command uvx "$@"
    }
  fi

  # Optional: Use UV as default pip if you want
  # alias pip='uv pip'

  # Create/activate virtual environments more efficiently
  venv() {
    if [ ! -d "$1" ]; then
      uv venv "$1"
    fi
    source "$1/bin/activate"
  }
fi

alias claude="/Users/xavier/.claude/local/claude"

