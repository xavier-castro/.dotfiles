# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a **hybrid Neovim configuration** that combines the best of both NvChad and kickstart.nvim:
- **NvChad's** beautiful UI, 56+ themes, performance optimizations, and comprehensive plugin ecosystem
- **Kickstart.nvim's** educational structure, transparency, and modular approach
- **Full customizability** while maintaining easy updates from both upstream sources

The configuration uses lazy.nvim for plugin management and imports NvChad components as plugins rather than as a complete framework, giving you full control over every aspect.

## Architecture

### Hybrid Structure
- **Core Configuration**: Modular kickstart.nvim-style structure in `lua/config/`
  - `config/options.lua` - All Neovim options and settings
  - `config/keymaps.lua` - Comprehensive keybinding configuration
  - `config/autocmds.lua` - Autocommands and event handling
- **Plugin Configuration**: Modular approach in `lua/plugins/`
  - `plugins/nvchad.lua` - NvChad core components import
  - `plugins/lsp.lua` - LSP configuration with Mason integration
  - `plugins/telescope.lua` - Fuzzy finder and search configuration
  - `plugins/treesitter.lua` - Syntax highlighting and code parsing
  - `plugins/completion.lua` - Autocompletion with nvim-cmp
  - `plugins/editor.lua` - Editor enhancement plugins
- **Legacy NvChad**: Original `lua/nvchad/` directory preserved for reference

### Key Components
- **Theme System**: NvChad's base46 provides 56+ themes with `<leader>th` picker
- **UI Framework**: NvChad UI components (statusline, tabufline, cheatsheets)
- **LSP Integration**: Full featured with Mason, lspconfig, and formatting
- **Performance**: 95% lazy-loading, optimized startup (~0.02-0.07s)
- **Educational**: Extensive documentation and comments throughout

## Common Development Commands

### Plugin Management
```bash
# Update all plugins
:Lazy update

# Check plugin status and profile
:Lazy

# Install/manage language servers
:Mason

# Check LSP server status
:LspInfo

# Format current buffer
:ConformInfo
```

### Essential Key Mappings

#### File Navigation
- `<leader>sf` / `<leader>ff` - Find files
- `<leader>sg` / `<leader>fw` - Live grep search
- `<leader>sb` / `<leader>fb` - Find buffers
- `<leader>sh` / `<leader>fh` - Help tags
- `<leader>sn` - Search Neovim config files
- `<C-n>` - Toggle file explorer
- `<leader>e` - Focus file explorer

#### LSP & Code
- `gd` - Go to definition
- `gr` - Find references
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `<leader>f` - Format buffer
- `<leader>ds` - Document symbols
- `<leader>ws` - Workspace symbols

#### Themes & UI
- `<leader>th` - NvChad theme picker
- `<leader>ch` - Toggle cheatsheet
- `<leader>n` - Toggle line numbers
- `<leader>rn` - Toggle relative numbers

#### Terminal
- `<leader>h` - New horizontal terminal
- `<leader>v` - New vertical terminal
- `<A-i>` - Toggle floating terminal
- `<A-h>` - Toggle horizontal terminal
- `<A-v>` - Toggle vertical terminal

## Development Workflow

### Adding New Plugins
1. Create new file in `lua/plugins/` (e.g., `lua/plugins/my-plugin.lua`)
2. Use lazy.nvim specification format:
   ```lua
   return {
     "author/plugin-name",
     event = "VeryLazy", -- or appropriate trigger
     opts = {},
     config = function(_, opts)
       require("plugin-name").setup(opts)
     end,
   }
   ```
3. Restart Neovim or `:Lazy reload` to load new plugins

### Customizing Configuration
- **Options**: Modify `lua/config/options.lua`
- **Keymaps**: Add to `lua/config/keymaps.lua` 
- **Autocommands**: Add to `lua/config/autocmds.lua`
- **Plugin configs**: Create separate files in `lua/plugins/`

### Extending LSP Support
1. Add language servers to the `servers` table in `lua/plugins/lsp.lua`
2. Configure formatters in `lua/plugins/lsp.lua` under `formatters_by_ft`
3. Restart and run `:Mason` to install servers

### Theme Customization
- Access NvChad's 56+ themes via `<leader>th`
- Themes persist across sessions
- Custom themes can be added via base46 system

## Hybrid Benefits

### From NvChad
- ✅ Beautiful, performant UI components
- ✅ Comprehensive theme system with 56+ themes
- ✅ Optimized plugin configurations
- ✅ Professional statusline and buffer management
- ✅ Extensive lazy-loading for fast startup

### From Kickstart.nvim
- ✅ Educational comments and documentation
- ✅ Transparent, modular configuration structure
- ✅ Easy to understand and modify
- ✅ No hidden abstractions or magic
- ✅ Standard Neovim configuration patterns

### Additional Features
- ✅ Backup system preserves original configs
- ✅ Git-trackable configuration
- ✅ Easy updates from both upstream sources
- ✅ Full control over every component
- ✅ Best practices from both communities

## Maintenance

### Updating Components
```bash
# Update all plugins (includes NvChad components)
:Lazy update

# Update language servers
:Mason update

# Check health
:checkhealth
```

### Backup & Recovery
- Original NvChad config backed up to `nvim-backup-YYYYMMDD-HHMMSS`
- Configuration is fully contained in git-trackable files
- No external dependencies beyond standard lazy.nvim plugin management

## Troubleshooting

### Common Issues

#### Base46 Build Failures
If you see `base46` build errors:
1. The configuration includes automatic cache directory setup
2. Fallback mechanisms are built-in for missing NvChad modules
3. Run `:Lazy clear base46` then `:Lazy install base46` to rebuild

#### Missing NvChad Configurations
The hybrid setup includes fallback configurations for:
- nvim-tree (file explorer)
- gitsigns (git integration) 
- devicons (file type icons)
- indent-blankline (indent guides)

#### Theme Issues
- Themes are managed by base46 plugin
- If theme picker (`<leader>th`) doesn't work, ensure base46 loaded properly
- Default theme will be used if NvChad themes unavailable

#### Plugin Conflicts
- All NvChad components are imported as individual plugins
- Conflicts with existing plugins should be minimal
- Check `:Lazy` for plugin status and potential issues

#### Which-Key Warnings
- Configuration uses latest which-key v3 API specification
- Old `register()` method replaced with new `add()` method
- Groupings are properly defined with modern syntax

#### ChadRC Missing Module
- Created `lua/chadrc.lua` file with NvChad configuration
- Contains theme settings, UI configuration, and terminal settings
- Required by NvChad's theme system and UI components
- Allows customization of themes, statusline, and other UI elements

### Debug Commands
```bash
# Check plugin status
:Lazy

# Check LSP status
:LspInfo

# Check health
:checkhealth

# Check base46 cache
:lua print(vim.g.base46_cache)

# Reload configuration
:source $MYVIMRC
```