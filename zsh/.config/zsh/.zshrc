# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Path configuration
export PATH=$HOME/.config/zsh/scripts:$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Source private configuration
source ~/.zsh_private.zshrc

# Aliases
alias aider="aider --no-auto-commits --watch-files --model openrouter/google/gemini-2.0-flash-001 --architect --model r1 --editor-model sonnet"
alias tm="tmux new-session -A -s MAIN"
alias cat="bat"
alias ls="eza"
alias find="fd"
alias histgrep='echo "[Tip] Use !number to execute the command" && history -i | grep' # -i for the timestamp
alias l='ls -A -l -h --color=auto' # All file except . and .., list view, display unit suffix for the size

##### Functions #####
mkcd() { mkdir -p $1; cd $1 }

numfiles() {
  num=$(ls -A $1 | wc -l)
  echo "$num files in $1"
}

# c for archive, z for gzip, v for verbose, f for file
tarmake() { tar -czvf ${1}.tar.gz $1 }

# x for extracting, v for verbose, f for file
tarunmake() { tar -zxvf $1 }


# eza (modern ls replacement)
if command -v eza &> /dev/null; then
  alias ll="eza -l -g --icons"
  alias lla="ll -a"
fi

# Fzf configuration
# ##### FZF #####
# I mean it is my machine so I would assume fd is installed
#type -P fd &> /dev/null && export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude ".git"'
#whence -p fd &> /dev/null && export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude ".git"'

source <(fzf --zsh)

cdf() {
  selected=$(find * -maxdepth 1 -type d 2>/dev/null | fzf \
    --reverse --border=rounded --cycle --height=50% \
    --header='Pick a directory to navigate to')
  [[ -z $selected ]] && echo 'Nothing was selected :(' || cd "$selected"
}

alias manf="compgen -c | fzf | xargs man"

sshf() {
  [[ ! -e ~/.ssh/config ]] && echo 'There are no SSH config file!'
  hostnames=$(awk ' $1 == "Host" { print $2 } ' ~/.ssh/config )
  [[ -z "${hostnames}" ]] && echo 'There are no host param in the SSH config file'
  selected=$(printf "%s\n" "${hostnames[@]}" | fzf \
    --reverse --border=rounded --cycle --height=30% \
    --header='pick a host')
  [[ -z "${selected}" ]] && echo 'Nothing was selected :(' && return
  echo "SSHing to ${selected}..." && ssh "$selected"
}

export FZF_PREVIEW_FILE_CMD="bat --style=numbers --color=always --line-range :500"
export FZF_LEGACY_KEYBINDINGS=0

# === ZI Setup ===
# Clone and initialize Zi if not installed
if [[ ! -f $HOME/.config/zsh/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.config/zsh/.zi" && command chmod go-rwX "$HOME/.config/zsh/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.config/zsh/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

# Source Zi
source "$HOME/.config/zsh/.zi/bin/zi.zsh"

# Enable Zi completions
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
zicompinit

# === Zi Plugins & Snippets ===

# Core Zi tools & annexes - load without turbo to ensure availability
zi light-mode for \
  z-shell/z-a-meta-plugins \
  z-shell/zzcomplete

zi light z-shell/z-a-bin-gem-node


# nb package
zi pack for nb

# remark
zi pack for remark

# Command-line productivity tools - load with turbo for faster startup
zi ice wait lucid
zi light-mode for \
  z-shell/zui \
  z-shell/zbrowse \
  z-shell/zsh-navigation-tools


# Syntax highlighting and autosuggestions - optimized loading
zi ice wait lucid atload'!_zsh_autosuggest_start'
zi light zsh-users/zsh-autosuggestions

zi ice wait lucid atinit'zicompinit; zicdreplay'
zi light z-shell/F-Sy-H

# Oh-My-Zsh and Prezto snippets - load with turbo
zi ice wait lucid
zi snippet PZT::modules/helper/init.zsh

# Git integration
zi ice wait lucid
zi snippet OMZL::git.zsh

zi ice wait lucid
zi snippet OMZP::git

# Theme components
zi ice wait lucid
zi snippet OMZL::theme-and-appearance.zsh

zi ice wait lucid
zi snippet OMZL::prompt_info_functions.zsh

# Theme - PowerLevel10k
# zi ice depth"1" lucid
# zi light romkatv/powerlevel10k

zi light-mode for @sindresorhus/pure

##### Greeting #####
function zsh_greeting() {
  fastfetch
}

zsh_greeting

# Load PowerLevel10k configuration
# [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# === End of Zi configuration ===
