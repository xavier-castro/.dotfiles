set fish_greeting ""

# theme
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

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

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
end
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish


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

