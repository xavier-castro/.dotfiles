# [Znap Guide](https://github.com/marlonrichert/zsh-snap/blob/main/README.md)

# Download Znap, if it's not there yet.
[[ -r ~/codebase/znap-cli/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/codebase/znap-cli/znap

source ~/codebase/znap-cli/znap/znap.zsh

export XDG_CONFIG_HOME=$HOME/.config
VIM="nvim"

# Prompt
source ~/.zsh_prompt # XC Prompt

# addToPathFront $HOME/.local/bin
path+=('$HOME/.local/bin')
path+=('$HOME/.local/scripts')
path+=('$HOME/.local/pipx')
path+=('/usr/local/bin')

# Where should I put you?
bindkey -s ^f "tmux-sessionizer\n"

# Aliases
# Next level of an ls
# options :  --no-filesize --no-time --no-permissions
alias ls="eza --no-filesize --long --color=always --icons=always --no-user"

# tree
alias tree="tree -L 3 -a -I '.git' --charset X "
alias dtree="tree -L 3 -a -d -I '.git' --charset X "


# Completion functions
znap install junegunn/fzf


# Evals
znap eval zoxide "zoxide init zsh"
znap eval fzf "fzf --zsh"







