# Read https://github.com/marlonrichert/zsh-snap for docs

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Download Znap, if it's not there yet.
[[ -r ~/codebase/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/codebase/znap

source ~/codebase/znap/znap.zsh  # Start Znap

# Load prompt fast
znap eval starship 'starship init zsh --print-full-init'
prompt_starship_precmd
znap prompt

# `znap source` starts plugins
znap source marlonrichert/zsh-autocomplete

# `znap install` adds new commands and completions.
znap install zsh-users/zsh-completions


# No special syntax is needed to configure plugins. Just use normal Zsh
# statements:

znap source marlonrichert/zsh-hist
bindkey '^[q' push-line-or-edit
bindkey -r '^Q' '^[Q'

ZSH_AUTOSUGGEST_STRATEGY=( history )
znap source zsh-users/zsh-autosuggestions

ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets )
znap source zsh-users/zsh-syntax-highlighting

# Aliases
alias ll="eza -lah --icons=always --color=auto $@"

# shellcheck shell=bash

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/xavier/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/xavier/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/xavier/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/xavier/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Installs
znap install conda-incubator/conda-zsh-completion
