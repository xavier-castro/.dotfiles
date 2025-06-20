# Agent Guidelines for Xavier's Dotfiles

## Build/Test/Lint Commands

- **Karabiner**: `cd karabiner/.config/karabiner && yarn build` (builds TypeScript rules)
- **Watch mode**: `cd karabiner/.config/karabiner && yarn watch` (auto-rebuild on changes)
- **No tests**: This is a personal dotfiles repository with no test suite

## Code Style Guidelines

### TypeScript (Karabiner rules)

- Use 2-space indentation (follows existing prettier config)
- Import statements: ES6 imports, group by type (fs, local types, utils)
- Naming: camelCase for variables/functions, PascalCase for types
- Use const for immutable values, prefer arrow functions
- Template literals for multi-line strings with shell commands

### Lua (Neovim config)

- Use tabs for indentation (4-space equivalent)
- Snake_case for variables, PascalCase for groups/modules
- Prefer `vim.opt` over `vim.o` for options
- Group related autocmds and keymaps together
- Use descriptive function names and local variables

### Shell/Config Files

- Use tabs or spaces consistently within each file
- Follow existing patterns for aliases and exports
- Keep PATH modifications grouped together
- Comment complex shell functions and aliases

## File Structure

- Each tool has its own directory under `.config/`
- Symlink dotfiles from their respective directories
- Keep build artifacts (like karabiner.json) in their target locations

