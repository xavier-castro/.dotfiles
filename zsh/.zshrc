# Fig pre block. Keep at the top of this file.
# MARK: PLUGINS
path+=("/usr/local/bin")
path+=("/usr/local/bin/nvim/bin")
path+=("$HOME/.local/scripts")
path+=("/usr/local/opt/gawk/libexec/gnubin")
path+=("/usr/local/opt/coreutils/libexec/gnubin")
export PATH

source ~/.zplug/init.zsh
zplug "zsh-users/zsh-history-substring-search"
zplug "Jxck/dotfiles", as:command, use:"bin/{histuniq,color}"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Supports checking out a specific branch/tag/commit
zplug "b4b4r07/enhancd", at:v1
zplug "mollifier/anyframe", at:4c23cb60

zplug "plugins/git",   from:oh-my-zsh
#
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose
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

export OPENAI_API_KEY=env
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

