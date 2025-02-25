# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"


alias lla "ll -A"
alias g git
command -qv nvim && alias vim nvim

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH /usr/local/bin $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

if type -q eza
  alias ls "eza -l --icons"
  alias ll "eza -l -g --icons"
  alias lla "ll -a"
end

# Fzf
set -g FZF_PREVIEW_FILE_CMD "bat --style=numbers --color=always --line-range :500"
set -g FZF_LEGACY_KEYBINDINGS 0
set -x LOCAL_CONFIG ~/.config/fish/config-local.fish

# Keybinds
bind \cf "~/.local/scripts/tmux-sessionizer; commandline -f execute"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/xavier/miniconda3/bin/conda
    eval /Users/xavier/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/Users/xavier/miniconda3/etc/fish/conf.d/conda.fish"
        . "/Users/xavier/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/Users/xavier/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

# Add at end of file
starship init fish | source
