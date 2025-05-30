# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Neovim configuration based on Kickstart.nvim - a minimal, documented starting point for Neovim configs. The configuration is structured as a single-file setup (`init.lua`) with optional modular plugin additions in `lua/xavier/plugins/`.

## Architecture

### Core Structure
- `init.lua` - Main configuration file containing:
  - Basic Neovim options and settings
  - Key mappings
  - Lazy.nvim plugin manager setup
  - Core plugin configurations (LSP, Telescope, Treesitter, etc.)
  - Plugin loading from `lua/xavier/plugins/`

### Plugin System
- Uses [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager
- Core plugins configured directly in `init.lua`
- Additional plugins can be added in `lua/xavier/plugins/` directory
- Plugins are automatically loaded via `{ import = 'xavier.plugins' }`

### Key Components
1. **LSP (Language Server Protocol)**
   - Mason.nvim for LSP server installation
   - Native LSP configuration with nvim-lspconfig
   - Blink.cmp for autocompletion

2. **Fuzzy Finding**
   - Telescope.nvim for file finding, grep, and more
   - FZF integration for better performance

3. **Syntax Highlighting**
   - Treesitter for advanced syntax highlighting and code understanding

4. **Additional Features**
   - Gitsigns for git integration
   - Which-key for key binding help
   - Mini.nvim for various utilities (surround, statusline, etc.)

## Common Commands

### Plugin Management
```vim
:Lazy               " Open Lazy plugin manager UI
:Lazy update        " Update all plugins
:Lazy install       " Install missing plugins
:Lazy sync          " Install missing plugins and update existing ones
```

### LSP Commands
```vim
:Mason              " Open Mason UI to manage LSP servers
:LspInfo            " Show LSP status for current buffer
:LspRestart         " Restart LSP servers
```

### Health Check
```vim
:checkhealth        " Run Neovim health checks
```

### Code Formatting
```vim
:ConformInfo        " Show conform.nvim status
<leader>f           " Format current buffer
```

### Lua Code Formatting
The configuration includes Stylua for Lua formatting with these settings:
- Column width: 160
- Indent: 2 spaces
- Quote style: Auto prefer single quotes
- No call parentheses

To format Lua files:
```bash
stylua .
```

## Key Mappings

### Leader Key
- `<space>` is the leader key
- `\\` is the local leader key

### Essential Mappings
- `<leader>sh` - Search help tags
- `<leader>sf` - Search files
- `<leader>sg` - Live grep
- `<leader><leader>` - Search buffers
- `<leader>f` - Format buffer
- `<leader>q` - Open diagnostic quickfix list

### LSP Mappings (when LSP is active)
- `grn` - Rename symbol
- `gra` - Code action
- `grd` - Go to definition
- `grr` - Find references
- `gri` - Go to implementation
- `gO` - Document symbols
- `<leader>th` - Toggle inlay hints

### Claude Code Integration
- `<leader>ac` - Toggle Claude Terminal
- `<leader>ak` - Send selection to Claude Code
- `<leader>ao` - Open/Focus Claude Terminal
- `<leader>ax` - Close Claude Terminal

## Development Workflow

1. **Adding New Plugins**: Create a new file in `lua/xavier/plugins/` returning a plugin spec table
2. **Modifying Core Config**: Edit `init.lua` directly
3. **Installing LSP Servers**: Use `:Mason` to interactively install servers
4. **Checking Plugin Status**: Use `:Lazy` to see plugin load status and profiling

## Plugin Development Tips

When creating new plugin configurations in `lua/xavier/plugins/`:
- Each file should return a table (single plugin) or array of tables (multiple plugins)
- Use lazy loading where appropriate (`event`, `cmd`, `ft` keys)
- Follow the existing patterns for consistency