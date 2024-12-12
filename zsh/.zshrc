export XDG_CONFIG_HOME=$HOME/.config
VIM="nvim"


# Prompt
source ~/.zsh_prompt # XC Prompt

# addToPathFront $HOME/.local/bin
path+=('$HOME/.local/bin')
path+=('$HOME/.local/scripts')
path+=('$HOME/.local/pipx')
path+=('/usr/local/bin')

##? Clone a plugin, identify its init file, source it, and add it to your fpath.
# where do you want to store your plugins?
ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}

# get zsh_unplugged and store it with your other plugins
if [[ ! -d $ZPLUGINDIR/zsh_unplugged ]]; then
  git clone --quiet https://github.com/mattmc3/zsh_unplugged $ZPLUGINDIR/zsh_unplugged
fi
source $ZPLUGINDIR/zsh_unplugged/zsh_unplugged.zsh

# make list of the Zsh plugins you use
repos=(

  # other plugins
  zsh-users/zsh-completions
  rupa/z
  # ...

  # plugins you want loaded last
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-history-substring-search
  zsh-users/zsh-autosuggestions
)

# now load your plugins
plugin-load $repos

# Source Private Keys from `~/.zshenv_private`
if [ -f ~/.zshenv_private ]; then
  source ~/.zshenv_private
fi







