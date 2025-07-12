ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions

# ============================================================================
# HISTORY
# ============================================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# navi (ctrl+g cheatsheet)
eval "$(navi widget zsh)"                    # load the zsh widget

# ============================================================================
# ESSENTIAL ALIASES
# ============================================================================
# Aliases
alias ls="ls -p -G"
alias la="ls -A"
alias ll="eza -l -g --icons"
alias lla="ll -a"
alias tt="tmux new-session -A -s 'MAIN'"
alias tk="tmux kill-server"
alias lg="lazygit"
alias c="claude"
alias g="gemini"

source ~/.zsh_profile
source <(zsp --zsh)

# ============================================================================
# MINIMAL COMPLETION SETUP
# ============================================================================
# Only initialize if not already done (check for cache)
if [[ ! -f ~/.zcompdump || ~/.zshrc -nt ~/.zcompdump ]]; then
    autoload -Uz compinit
    compinit -d ~/.zcompdump
else
    autoload -Uz compinit
    compinit -C -d ~/.zcompdump
fi

# Basic completion settings
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Performance: Skip some checks if we're not in an interactive shell
[[ $- == *i* ]] || return

# Only continue with interactive shell setup if needed
[[ -o interactive ]] || return

# ============================================================================
# KEY BINDINGS
# ============================================================================
bindkey -v # vi mode
bindkey '^R' history-incremental-search-backward
bindkey -s ^f "tmux-sessionizer\n"

