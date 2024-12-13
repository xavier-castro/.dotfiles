# Skip all initialization if not running interactively
[[ $- != *i* ]] && return

# Add to top of .zshrc
PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true ]]; then
    zmodload zsh/zprof
fi

# Add to bottom of .zshrc
if [[ "$PROFILE_STARTUP" == true ]]; then
    zprof
fi

source ~/.dotfiles/zsh/.zsh_prompt

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
source ~/.zsh_profile

# Cycle through private keys inside `~/.zshenv_private/` and load them
if [ -f ~/.zshenv_private ]; then
  source ~/.zshenv_private
fi


autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load plugins with optimized turbo mode
zinit wait'0a' lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \

zinit wait'0b' lucid light-mode for \
    atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

zinit wait'0c' lucid light-mode for \
    blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions

# Load Git plugin with delay
zinit wait'1' lucid for \
    OMZP::git

# Load helper module with delay
zinit wait'1' lucid for \
    PZT::modules/helper/init.zsh

# Load colors with delay
zinit wait'2' lucid light-mode for \
    atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"' \
    trapd00r/LS_COLORS


# Load fzf binary and completion
zinit wait'1' lucid for \
    atload"source ~/.fzf.zsh" \
    junegunn/fzf

# Load fzf-tab for better completion
zinit wait'1' lucid for \
    Aloxaf/fzf-tab

# Remove zprof as it's adding overhead

