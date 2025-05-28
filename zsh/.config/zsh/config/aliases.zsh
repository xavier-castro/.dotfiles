# Modern replacements for common commands
alias cat="bat"
alias ls="eza --icons=always"
alias ll="eza -l -g --icons"
alias lla="ll -a"
alias find="fd"

# Git
alias g="git"
alias lg="lazygit"

# Neovim
alias vim="nvim"
alias vi="nvim"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Tmux
alias tm="tmux new-session -A -s MAIN"
alias s="tmux-sessionizer"
alias tn="tmux new -s $(pwd | sed 's/.*\///g')"

# Docker
alias ld="lazydocker"

# Functions
mkcd() { mkdir -p "$1" && cd "$1" }

# FZF-powered commands
alias manf="compgen -c | fzf | xargs man"

cdf() {
  selected=$(find * -maxdepth 1 -type d 2>/dev/null | fzf \
    --reverse --border=rounded --cycle --height=50% \
    --header='Pick a directory to navigate to')
  [[ -z $selected ]] && echo 'Nothing was selected :(' || cd "$selected"
}

sshf() {
  [[ ! -e ~/.ssh/config ]] && echo 'There is no SSH config file!' && return
  hostnames=$(awk ' $1 == "Host" { print $2 } ' ~/.ssh/config )
  [[ -z "${hostnames}" ]] && echo 'There are no host params in the SSH config file' && return
  selected=$(printf "%s\n" "${hostnames[@]}" | fzf \
    --reverse --border=rounded --cycle --height=30% \
    --header='pick a host')
  [[ -z "${selected}" ]] && echo 'Nothing was selected :(' && return
  echo "SSHing to ${selected}..." && ssh "$selected"
}