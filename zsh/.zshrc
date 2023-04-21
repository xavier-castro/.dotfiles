# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"

# MARK: PLUGINS
plugins=(
  git
  macos
  colored-man-pages
  fancy-ctrl-z
  z
  fzf
  zsh-syntax-highlighting
)

# MARK: SOURCING
source $ZSH/oh-my-zsh.sh

# User configuration

# MARK: PATH
path+=("/usr/local/bin")
path+=("/usr/local/bin/nvim/bin")
path+=("$HOME/.local/scripts")

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# MARK: Alias
alias .zsh="nvim ~/.zshrc"
alias g="git"
alias gs="git status"
alias vim="nvim"
alias python="python3"
alias pip="pip3"

