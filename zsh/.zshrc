# Performance optimizations
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

# Cache completions aggressively
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    compinit
else
    compinit -C
fi

# Oh My Zsh path
export ZSH="$HOME/.oh-my-zsh"
export EDITOR=nvim

# Theme config
ZSH_THEME="spaceship"
# ZSH_THEME="robbyrussell"

# Spaceship settings
SPACESHIP_PROMPT_ASYNC=true
SPACESHIP_PROMPT_ADD_NEWLINE=true
# SPACESHIP_CHAR_SYMBOL="⚡"

# Minimal spaceship sections for performance
SPACESHIP_PROMPT_ORDER=(
    time
    user
    dir
    git
    line_sep
    char
)

# Carefully ordered plugins (syntax highlighting must be last)
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Autosuggest settings
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#663399,standout"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="10"
ZSH_AUTOSUGGEST_USE_ASYNC=1
#
# # Alias expansion function
# globalias() {
#    if [[ $LBUFFER =~ '[a-zA-Z0-9]+$' ]]; then
#        zle _expand_alias
#        zle expand-word
#    fi
#    zle self-insert
# }
# zle -N globalias
# bindkey " " globalias
# bindkey "^[[Z" magic-space
# bindkey -M isearch " " magic-space

# Lazy load SSH agent
function _load_ssh_agent() {
    if [ -z "$$SSH_AUTH_SOCK" ]; then
        eval "$(ssh-agent -s)" > /dev/null
        ssh-add ~/.ssh/id_github_sign_and_auth 2>/dev/null
    fi
}

autoload -U add-zsh-hook
add-zsh-hook precmd _load_ssh_agent

# Path configurations
export VOLTA_HOME="$HOME/.volta"
PATH="$VOLTA_HOME/bin:$PATH:/home/xavier/.turso:/home/xavier/.local/bin"
export PATH

# Aliases

# Eza
alias -g ls='eza -g --icons'
alias -g la='ls -a'
alias -g ll='eza -l -g --icons'
alias -g lla='ll -a'


source ~/.zsh_profile
