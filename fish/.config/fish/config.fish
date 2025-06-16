# Unset the default fish greeting text which messes up Zellij
set fish_greeting ""

# # Check if we're in an interactive shell
# if status is-interactive
#  # Check if we are already in tmux
#     if not set -q TMUX
#         # Create session 'main' or attach to 'main' if it already exists
#         tmux new-session -A -s MAIN
#     end
# end

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always


set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH ~/.config/tmux/plugins/tmuxifier/bin $PATH

# NodeJ

# Title options
set -g theme_title_display_process yes
set -g theme_title_display_path yes
set -g theme_title_display_user yes
set -g theme_title_use_abbreviated_path yes

# Prompt options
set -g theme_display_ruby yes
set -g theme_display_virtualenv yes
set -g theme_display_vagrant no
set -g theme_display_vi yes
set -g theme_display_k8s_context no # yes
set -g theme_display_user yes
set -g theme_display_hostname yes
set -g theme_show_exit_status yes
set -g theme_git_worktree_support no
set -g theme_display_git yes
set -g theme_display_git_dirty yes
set -g theme_display_git_untracked yes
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_dirty_verbose yes
set -g theme_display_git_master_branch yes
set -g theme_display_date yes
set -g theme_display_cmd_duration yes
set -g theme_powerline_fonts yes
set -g theme_nerd_fonts yes
set -g theme_color_scheme solarized-dark

bind -M insert \cg forget
bind -M insert \cf ~/.dotfiles/bin/.local/scripts/tmux-sessionizer

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git
alias c claude
command -qv nvim && alias vim nvim


if type -q eza
  alias ll "eza -l -g --icons"
  alias lla "ll -a"
end

# Fzf
set -g FZF_PREVIEW_FILE_CMD "bat --style=numbers --color=always --line-range :500"
set -g FZF_LEGACY_KEYBINDINGS 0

if which asdf > /dev/null; status --is-interactive; and source (brew --prefix asdf)/asdf.fish; end
if which direnv > /dev/null; direnv hook fish | source; end
if which goenv > /dev/null; status --is-interactive; and source (goenv init -|psub); end
if which rbenv > /dev/null; status --is-interactive; and source (rbenv init -|psub); end
if which swiftenv > /dev/null; status --is-interactive; and source (swiftenv init -|psub); end

eval (tmuxifier init - fish)

# Private Keys
set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
end
