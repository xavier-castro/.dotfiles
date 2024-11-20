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

# `znap function` lets you lazy-load features you don't always need.
znap function _pyenv pyenv "znap eval pyenv 'pyenv init - --no-rehash'"
compctl -K    _pyenv pyenv


# `znap install` adds new commands and completions.
znap install zsh-users/zsh-completions

# Aliases
