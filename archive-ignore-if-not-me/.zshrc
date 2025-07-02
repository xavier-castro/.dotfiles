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


zinit light mafredri/zsh-async  # dependency
# zinit ice pick"async.zsh" src"pure.zsh"
# zinit light sindresorhus/pure

source ~/.dotfiles/zsh/xc_rr_fast_prompt.zsh

# opencode
export PATH=/Users/xavier/.opencode/bin:$PATH
# personal scripts
export PATH=/Users/xavier/.dotfiles/bin/.local/scripts:$PATH

# navi (ctrl+g cheatsheet)
eval "$(navi widget zsh)"                    # load the zsh widget

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


bindkey -s ^f "tmux-sessionizer\n"
bindkey -s '\eh' "tmux-sessionizer -s 0\n"
bindkey -s '\et' "tmux-sessionizer -s 1\n"
bindkey -s '\en' "tmux-sessionizer -s 2\n"
bindkey -s '\es' "tmux-sessionizer -s 3\n"
