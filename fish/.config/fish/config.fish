# Unset the default fish greeting text which messes up Zellij
set fish_greeting ""
# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias npm pnpm
alias npx pnpx
alias g git
alias claude="/Users/xavier/.claude/local/claude"
alias c claude
command -qv nvim && alias vim nvim

if type -q eza
    alias ll "eza -l -g --icons"
    alias lla "ll -a"
end

set -gx EDITOR nvim
set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
# NodeJS
set -gx PATH node_modules/.bin $PATH
# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

# Fzf
set -g FZF_PREVIEW_FILE_CMD "bat --style=numbers --color=always --line-range :500"
set -g FZF_LEGACY_KEYBINDINGS 0

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
end

# pnpm
set -gx PNPM_HOME /Users/xavier/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
mise activate fish --shims | source

# Bind Ctrl+F (denoted \cf) to call the function
bind \cf ~/.local/scripts/tmux-sessionizer
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
