# Download Znap, if it's not there yet.
[[ -r ~/codebase/znap-cli/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/codebase/znap-cli/znap
source ~/codebase/znap-cli/znap/znap.zsh  # Start Znap

# XC Custom Prompt for Zsh
source ~/.zsh_prompt

# XC Profile
source ~/.zsh_profile

# `znap source` starts plugins.
znap source marlonrichert/zsh-autocomplete

# `znap eval` makes evaluating generated command output up to 10 times faster.
znap eval iterm2 'curl -fsSL https://iterm2.com/shell_integration/zsh'

# `znap function` lets you lazy-load features you don't always need.
znap function _pyenv pyenv "znap eval pyenv 'pyenv init - --no-rehash'"
compctl -K    _pyenv pyenv

# `znap install` adds new commands and completions.
znap install aureliojargas/clitest zsh-users/zsh-completions






