## Build, Lint, and Test

- **Karabiner rules**: `cd karabiner/.config/karabiner && yarn && yarn build`
- **Lua**: Lint with `selene` and format with `stylua`. See `.selene.toml` and `.stylua.toml` in `nvim/.config/nvim`.
- **TypeScript**: Format with `prettier`.

## Code Style

- **Line length**: 120 characters.
- **Indentation**: 2 spaces.
- **Quotes**: Double quotes are preferred.
- **Error Handling**: Check for errors and handle them appropriately.
- **Naming Conventions**: Follow existing conventions in the codebase.

## General

- This repository contains dotfiles for various tools like `nvim`, `tmux`, and `karabiner`.
- Use `brew bundle` to install dependencies from the `Brewfile`.
- Use `ripgrep` (`rg`) for searching.
- Be mindful of the different package managers used (`npm`, `yarn`, `brew`).
