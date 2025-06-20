# Personal Zsh configuration file with zinit
# Fast and lightweight zsh plugin manager

# Initialize zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

# Load the pure theme, with zsh-async library that's bundled with it.
zi ice pick"async.zsh" src"pure.zsh"
zi light sindresorhus/pure

# A glance at the new for-syntax – load all of the above
# plugins with a single command. For more information see:
# https://zdharma-continuum.github.io/zinit/wiki/For-Syntax/
zinit for \
    light-mode \
    zsh-users/zsh-autosuggestions \
    light-mode \
    zdharma-continuum/fast-syntax-highlighting \
    zdharma-continuum/history-search-multi-word \
    light-mode \
    pick"async.zsh" \
    src"pure.zsh" \
    sindresorhus/pure

# Binary release in archive, from GitHub-releases page.
# After automatic unpacking it provides program "fzf".
zi ice from"gh-r" as"program"
zi light junegunn/fzf

# Zoxide - smarter cd command
zi ice from"gh-r" as"program" mv"zoxide* -> zoxide" pick"zoxide"
zi light ajeetdsouza/zoxide

# Eza - modern replacement for ls
zi ice from"gh-r" as"program" mv"eza* -> eza" pick"eza"
zi light eza-community/eza

# Bat - cat with syntax highlighting
zi ice from"gh-r" as"program" mv"bat* -> bat" pick"bat"
zi light sharkdp/bat

# Ripgrep - fast grep alternative
zi ice from"gh-r" as"program" mv"rg* -> rg" pick"rg"
zi light BurntSushi/ripgrep

# Fd - fast find alternative
zi ice from"gh-r" as"program" mv"fd* -> fd" pick"fd"
zi light sharkdp/fd

# Delta - better git diff
zi ice from"gh-r" as"program" mv"delta* -> delta" pick"delta"
zi light dandavison/delta

# One other binary release, it needs renaming from `docker-compose-Linux-x86_64`.
# This is done by ice-mod `mv'{from} -> {to}'. There are multiple packages per
# single version, for OS X, Linux and Windows – so ice-mod `bpick' is used to
# select Linux package – in this case this is actually not needed, Zinit will
# grep operating system name and architecture automatically when there's no `bpick'.
zi ice from"gh-r" as"program" mv"docker* -> docker-compose" bpick"*linux*"
zi load docker/compose

# Vim repository on GitHub – a typical source code that needs compilation – Zinit
# can manage it for you if you like, run `./configure` and other `make`, etc.
# Ice-mod `pick` selects a binary program to add to $PATH. You could also install the
# package under the path $ZPFX, see: https://zdharma-continuum.github.io/zinit/wiki/Compiling-programs
zi ice \
    as"program" \
    atclone"rm -f src/auto/config.cache; ./configure" \
    atpull"%atclone" \
    make \
    pick"src/vim"
zi light vim/vim

# Scripts built at install (there's single default make target, "install",
# and it constructs scripts by `cat'ing a few files). The make'' ice could also be:
# `make"install PREFIX=$ZPFX"`, if "install" wouldn't be the only default target.
zi ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zi light tj/git-extras

# Handle completions without loading any plugin; see "completions" command.
# This one is to be ran just once, in interactive session.
# Essential plugins for speed and functionality
zinit light  %HOME/my_completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma-continuum/fast-syntax-highlighting

# Additional useful plugins
zinit light Aloxaf/fzf-tab                    # Replace tab completion with fzf
zinit light wfxr/forgit                       # Interactive git commands with fzf
zinit light hlissner/zsh-autopair             # Auto-close brackets and quotes
zinit light MichaelAquilina/zsh-you-should-use # Suggest aliases for commands

# Load completions
autoload -Uz compinit && compinit

# Optimized PATH configuration using zsh4humans
export VOLTA_HOME="$HOME/.volta"

# Use zsh array for clean PATH management (typeset -U ensures uniqueness)
typeset -U path
path=(
    ~/.local/scripts                 # Personal scripts (highest priority)
    ~/.dotfiles/bin/.local/scripts   # Dotfiles scripts
    ~/bin                           # Personal binaries
    ~/.local/bin                    # Local user binaries
    ~/.local/share/mise/shims       # Mise tool shims
    ~/.orbstack/bin                 # OrbStack (Docker/K8s tools)
    $VOLTA_HOME/bin                 # Volta (Node.js)
    ~/.cargo/bin                    # Rust binaries
    ~/go/bin                        # Go binaries
    ~/.config/emacs/bin             # Emacs binaries
    ~/.config/tmux/plugins/tmuxifier/bin  # Tmux session manager
    ~/Library/Python/3.13/bin      # Python user packages
    $path                           # Preserve existing system PATH
)

# Tool version management
eval "$(mise activate zsh)"

# Initialize zoxide (smarter cd)
eval "$(zoxide init zsh)"

# FZF configuration
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --inline-info"

# Use fd for fzf if available
if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi

# Use bat for fzf preview if available
if command -v bat >/dev/null 2>&1; then
    export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
fi

# Export environment variables.
export GPG_TTY=$TTY

# Enable direnv if available
if command -v direnv >/dev/null 2>&1; then
    eval "$(direnv hook zsh)"
fi

# Source additional local files if they exist
[[ -f ~/.env.zsh ]] && source ~/.env.zsh

# Autoload functions.
autoload -Uz zmv

# Define functions and completions.
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories md

# Enhanced functions using new tools
function fzf-cd() {
    local dir
    dir=$(fd --type d --hidden --follow --exclude .git | fzf --preview 'eza --tree --level=2 {}') && cd "$dir"
}

function fzf-edit() {
    local file
    file=$(fd --type f --hidden --follow --exclude .git | fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}') && ${EDITOR:-nvim} "$file"
}

# Git functions with fzf
function fzf-git-branch() {
    git branch -a | grep -v HEAD | sed 's/.* //' | sed 's#remotes/[^/]*/##' | sort -u | fzf | xargs git checkout
}

function fzf-git-log() {
    git log --oneline --color=always | fzf --ansi --preview 'git show --color=always {1}' | cut -d' ' -f1 | xargs git show
}

# Define aliases
alias tree='tree -a -I .git'

# Modern replacements (fallback to traditional if not available)
if command -v eza >/dev/null 2>&1; then
    alias ls="eza --icons --group-directories-first"
    alias la="eza --icons --group-directories-first -a"
    alias ll="eza --icons --group-directories-first -l"
    alias lla="eza --icons --group-directories-first -la"
    alias lt="eza --icons --group-directories-first --tree"
else
    alias ls="ls -p -G"
    alias la="ls -A"
    alias ll="ls -l"
    alias lla="ll -A"
fi

if command -v bat >/dev/null 2>&1; then
    alias cat="bat --paging=never"
    alias less="bat"
fi

# Zoxide aliases
alias cd="z"
alias cdi="zi"  # interactive cd

# Git and other tools
alias g="git"
alias c="claude"
alias tt="tmux a || tmux new-session -A -s 'MAIN'"

# Search aliases
if command -v rg >/dev/null 2>&1; then
    alias grep="rg"
fi

if command -v fd >/dev/null 2>&1; then
    alias find="fd"
fi
# Set shell options
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu
setopt hist_ignore_dups
setopt hist_ignore_space
setopt share_history

# History configuration
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Key bindings for enhanced functions
bindkey -s '^p' 'fzf-cd\n'
bindkey -s '^o' 'fzf-edit\n'

# Source additional profile configurations
source ~/.dotfiles/zsh/.zsh_profile
