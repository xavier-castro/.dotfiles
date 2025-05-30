# Optimization: Compile zcompdump only once a day
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Path configuration
export PATH=$HOME/.config/zsh/scripts:$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# asdf 0.16.0+ configuration
export ASDF_DATA_DIR="$HOME/.asdf"
export PATH="$ASDF_DATA_DIR/shims:$PATH"

# Source private configuration if exists
[[ -f ~/.zsh_private.zshrc ]] && source ~/.zsh_private.zshrc

# Zi Setup - Ultra-flexible and fast Zsh plugin manager
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


# Essential plugins - loaded immediately for better UX
zi light-mode for \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-syntax-highlighting

# Completions - loaded with turbo for faster startup
zi ice wait lucid blockf atpull'zi creinstall -q .'
zi light zsh-users/zsh-completions


# Source additional configuration files
[[ -f ~/.config/zsh/config/aliases.zsh ]] && source ~/.config/zsh/config/aliases.zsh
[[ -f ~/.config/zsh/config/options.zsh ]] && source ~/.config/zsh/config/options.zsh

# FZF configuration
if command -v fzf &> /dev/null; then
  # Source fzf completion and key-bindings
  [[ -f /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh
  [[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh

  export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --follow --exclude .git'
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
fi

# History configuration
HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select

zi ice as"command" from"gh-r" \
  atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
  atpull"%atclone" src"init.zsh"
zi light starship/starship

