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

Added a lot of new but super useful binds:
Terminal

- `<leader>ft` -> toggles floating terminal
- `<leader>to` -> New terminal underneath

LSP

- `<leader>lx` -> Toggles LSP

Tabs

- `<leader>tn` -> New tab
- `<leader>tf` -> Open current tab in new tab
- `<leader>t]` -> Go to next tab
- `<leader>tx` -> Tab close

Splits

- `<leader>sv` -> split vertically
- `<leader>sh` -> horizontally
- `<leader>sm` -> Maximize split toggle
- `<leader>sx` -> Split close

Misc

- `<leader>fp` -> Copys filepath to clipboard

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

- Learn Trouble and Quickfix List
- Refactor a bit (mainly init.lua)
- Better window and split management

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
- [Karabiner-Elements](https://pqrs.org/osx/karabiner/) -[Rectangle Pro](https://rectangleapp.com/pro)
- [Raycast](https://raycast.com/)

### Karabiner

`cd` into the karabiner folder and run the following command:

```bash
yarn
yarn run build
```
