# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# MARK: PLUGINS
path+=("/usr/local/bin")
path+=("/usr/local/bin/nvim/bin")
path+=("$HOME/.local/scripts")
path+=("/usr/local/opt/gawk/libexec/gnubin")
path+=("/usr/local/opt/coreutils/libexec/gnubin")
export PATH

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

source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
