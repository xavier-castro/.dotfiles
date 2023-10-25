# What I do on a Fresh Install Mac

[iterm2](https://iterm2.com/downloads.html)
[arc](https://arc.net)
[raycast](https://www.raycast.com/)
[1password](https://1password.com/downloads/mac)
[rectangle](https://rectangleapp.com/pro)
[karabiner](https://karabiner-elements.pqrs.org/)
`yarn`
`yarn run build`
[alttab](https://alt-tab-macos.netlify.app/)

## Ubuntu MacOS Compatibility

[Apple Patches](https://github.com/t2linux/T2-Ubuntu-Kernel#using-the-kernel-upgrade-script)
[Setting Up Brew on Ubuntu on Fish Shell](https://cnu.hashnode.dev/set-up-homebrew-on-linux-with-fish-shell)

## CLI

### Scripts

Remove Mouse Acceleration
`defaults write .GlobalPreferences com.apple.mouse.scaling -1`

### Downloads

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install git
brew install gh (gh auth login)
brew install stow
brew install fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install jorgebucaran/nvm.fish
fisher install IlanCosman/tide@v5
chsh -s /usr/local/bin/fish
gh repo clone xavier-castro/.dotfiles
brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.config/tmux/tmux.conf
brew install neovim
brew install fzf
brew install pnpm
brew install nvm
brew install prettier
brew install eslint_d
brew install stylelint
nvm install latest
nvm use latest
set --universal nvm_default_version latest
brew install go
brew install visual-studio-code —cask
brew install efm-langserver
brew install tailwindcss-language-server
brew install sqlite
brew install peco
brew install exa
brew install lazygit
brew install zoxide
brew install fsouza/prettierd/prettierd
npm install turbo --global
brew install commitizen
brew install tig
brew install todoist --cask
```

## Mac App Store Downloads

- Fanstastical
- 1Password
- Xcode

## System Settings

### Keyboard

Shortcuts -> Spotlight -> Both off (replaced with Recast)
Show F1 Keys
Adjust Key Repeat

### Battery

Low Power Mode -> On Battery
Options -> Disable All

### Lock Screen

Set everything that puts my laptop to sleep off
