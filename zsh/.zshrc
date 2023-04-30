# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
    compinit -i
else
    compinit -C -i
fi
zmodload -i zsh/complist

# Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'
alias less='less -R'
alias g='git'
alias gs='git status'
alias gd='git diff'

OS="$(uname)"
if [[ "$OS" == "Linux" ]]; then
    alias bat='batcat --theme base16 -p'
    alias ls='ls -h --color=auto'
    alias la='ls -lah --color=auto'
fi

# Exports
export TERM="xterm-256color"
export LANGUAGE="C.UTF-8"
export LANG="C.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_ALL="en_US.UTF-8"
export LC_MESSAGES="C.UTF-8"
export OPENAI_API_KEY=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

# sources
source $HOME/.zsh/powerlevel10k/powerlevel10k.zsh-theme
source $HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $HOME/.zsh/completion.zsh
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/history.zsh
source $HOME/.zsh/key-bindings.zsh
