# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#######################
# INITIALIZATION
#######################

# Skip all initialization if not running interactively
[[ $- != *i* ]] && return

# Profiling support (disabled by default)
PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true ]]; then
    zmodload zsh/zprof
fi

#######################
# ZINIT INSTALLATION
#######################

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

#######################
# SOURCE FILES
#######################

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
source ~/.zsh_prompt
source ~/.zsh_profile

# Load private environment variables
if [ -f ~/.zshenv_private ]; then
    source ~/.zshenv_private
fi

#######################
# ZINIT SETUP
#######################

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

#######################
# CORE PLUGINS (0-delay)
#######################

# Syntax highlighting (load first)
zinit wait'0a' lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting

# Auto-suggestions
zinit wait'0b' lucid light-mode for \
    atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

# Completions
zinit wait'0c' lucid light-mode for \
    blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions

#######################
# UTILITY PLUGINS (1-delay)
#######################

# Git integration
zinit wait'1' lucid for \
    OMZP::git

# Helper functions
zinit wait'1' lucid for \
    PZT::modules/helper/init.zsh

# FZF integration
zinit wait'1' lucid for \
    atload"source ~/.fzf.zsh" \
    junegunn/fzf

# FZF tab completion
zinit wait'1' lucid for \
    Aloxaf/fzf-tab

#######################
# THEMING (2-delay)
#######################

# Colors
zinit wait'2' lucid light-mode for \
    atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"' \
    trapd00r/LS_COLORS


# After finishing the configuration wizard change the atload'' ice to:
# -> atload'source ~/.p10k.zsh; _p9k_precmd'
zinit ice wait'!' lucid atload'true; _p9k_precmd' nocd
zinit light romkatv/powerlevel10k

#######################
# FINALIZATION
#######################

# Output profiling info if enabled
if [[ "$PROFILE_STARTUP" == true ]]; then
    zprof
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
