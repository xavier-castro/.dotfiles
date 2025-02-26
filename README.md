# README

## I3 Setup philosophy

workspace 1 -> general use browser
workspace 2 -> developer use browser
workspace 3 -> work terminal
worksapce 4 -> mystery (lol)
workspace 5 -> slack/messages
workspace 6 -> gimp (primeagen)
workspace 7 -> vpn (primeagen)
workspace 9 -> utility window

## Things to Re-remember

### [UV](https://docs.astral.sh/uv/#scripts)

```
uv init example
cd example
uv add ruff
uv run ruff check
uv lock
uv sync
```

## TODO

- [x] Grab all configs you think you'd like to keep before deleting lazyvim branch
- [ ] Learn power of primeagen plugins (UndoTree, Trouble, QF, harpoon, git-worktrees)
- [x] Stow fish config correctly
- [x] Edit Zenmode to how you like it
- [x] Maybe add more helpful telescope binds?
- [ ] Create personal journaling folder (private)
- [ ] Relearn git-worktrees and how to use primeagens
- [ ] Figure out how to get a floating terminal
- [x] Install Rust
- [ ] Learn how to use grep better
- [ ] Make better markdown, latex, obsidian for best note taking setup

## Plugins considering while still keeping it minimal

- [ ] tpope/surround (use keybind sr)
- [ ] the dot repeat one

## Cli Commands

Homebrew `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
Rust `curl https://sh.rustup.rs -sSf | sh`
UV (pip pipx virtualenv written in Rust) `curl -LsSf https://astral.sh/uv/install.sh | sh`

```bash
brew install fish exa fzf z neovim ripgrep zoxide fd uv go yarn
```

## Neat Commands I need to use more

`Alt+l` -> In fish shell, lists whats in the current directory you are in

## CLI Essentials

- [Zoxide]
- [Fzf]
- [Ripgrep]
- [exa]
- [Neovim]

## Mac Setup

- [Homebrew](https://brew.sh/)
- [UTM](https://mac.getutm.app/)
- [Karabiner-Elements](https://pqrs.org/osx/karabiner/)
- [Rectangle Pro](https://rectangleapp.com/pro)
- [Raycast](https://raycast.com/)

### Karabiner

`cd` into the karabiner folder and run the following command:

```bash
yarn
yarn run build
```
