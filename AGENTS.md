# AGENTS.md

## Build, Lint, and Test
- **Karabiner rules**: `cd karabiner/.config/karabiner && yarn && yarn build`
- **Lua**: Lint with `selene` and format with `stylua` (see `.selene.toml` and `.stylua.toml` in `nvim/.config/nvim`).
- **TypeScript**: Format with `prettier`.
- **Run a single test**: No standard test runner; check tool-specific docs or scripts.
- **Install dependencies**: Use `brew bundle` for system deps, `yarn` or `npm` for JS/TS, and `pip` for Python if needed.

## Code Style Guidelines
- **Line length**: 120 characters max.
- **Indentation**: 2 spaces.
- **Quotes**: Prefer double quotes.
- **Imports**: Follow existing import style per language.
- **Formatting**: Use project formatters (`stylua`, `prettier`).
- **Types**: Use explicit types where possible (TS, Lua, etc.).
- **Naming**: Follow conventions in each subproject.
- **Error handling**: Always check and handle errors.
- **General**: Be mindful of different package managers and tool-specific configs. Use `rg` for searching.

No Cursor or Copilot rules present as of July 2025.