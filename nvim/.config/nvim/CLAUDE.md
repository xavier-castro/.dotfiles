# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Neovim Configuration Overview

This is a Neovim configuration based on Kickstart.nvim with numerous custom enhancements. It uses the lazy.nvim plugin manager and includes configurations for LSP (Language Server Protocol), telescopic fuzzy finding, UI elements, and various coding tools.

## Directory Structure

- `init.lua`: Main configuration file that loads all modules
- `lua/kickstart/`: Core kickstart modules 
- `lua/custom/`: Custom configuration modules:
  - `plugins/`: Plugin-specific configurations
  - `ui/`: UI elements (statusline, winbar, tabline)
  - `extras/`: Additional utility modules
  - `keymaps.lua`: Key mappings

## Language Server Protocol (LSP)

The configuration uses Neovim's native LSP support (for Neovim 0.11+). Language servers are configured in:

- `lua/lsp/init.lua`: Core LSP setup
- Various files in `/lsp/` for language-specific configurations

### Key commands for LSP:

```
:LspInfo      - Show LSP status
:LspRestart   - Restart all language servers
:LspStart     - Start LSP for current buffer
:LspStop      - Stop LSP services
:LspLog       - View LSP logs
```

## Ruby Development

For Ruby/Rails development, the configuration includes:

- Ruby LSP integration
- Vim-rails plugin for Rails navigation
- Vim-test for test running

To set up Ruby LSP for a project:
1. Copy the example configuration: `cp ~/.config/nvim/example.neoconf.ruby.json /path/to/project/.neoconf.ruby.json`
2. Either install Ruby LSP globally: `gem install ruby-lsp standardrb`, or add it to your project's Gemfile

Ruby/Rails specific commands:
- `<leader>rt`: Run test file
- `<leader>rs`: Run single test
- `<leader>rl`: Run last test
- `<leader>ra`: Run all tests
- `:Emodel`, `:Econtroller`, `:Eview`, etc.: Navigate Rails project

## Common Keymaps

The configuration uses Space as the leader key and follows a structured keymap organization:

- `<leader>f`: File operations
- `<leader>b`: Buffer operations
- `<leader>w`: Window operations
- `<leader>s`: Search operations (Telescope)
- `<leader>g`: Git operations
- `<leader>T`: Toggle options
- `<leader>c`: Code actions
- `<leader>e`: Error/diagnostic navigation
- `<leader>r`: Rename/Ruby operations
- `<leader>x`: Trouble/Diagnostics

Some useful key mappings:
- `<leader>/`: Fuzzy search in current buffer ("Swiper")
- `<leader>ff` or `<leader>sf`: Find files
- `<leader>sg`: Search with live grep
- `<leader>sc`: Clear search highlighting
- `jk`: Escape from insert mode

## Plugins

The configuration uses lazy.nvim to manage plugins. Key plugins include:

- telescope.nvim: Fuzzy finder
- gitsigns.nvim: Git integration
- which-key.nvim: Keybinding help
- nvim-treesitter: Syntax highlighting and code navigation
- mini.nvim: Collection of small utilities
- conform.nvim: Code formatting

## Formatter

For code formatting, the configuration uses conform.nvim. To format a buffer:

```
<leader>F    - Format current buffer
```

The formatter supports various languages including: Lua, Python, JavaScript/TypeScript, Ruby, HTML, CSS, and more.

## Terminal Integration

The configuration provides multiple ways to open terminal windows:

- `<leader>tt`: Toggle floating terminal
- `<leader>tb`: Open terminal at the bottom
- `<leader>tr`: Open terminal to the right
- `<Esc><Esc>`: Exit terminal mode

## Window Navigation

For window navigation and management:

- `<C-h/j/k/l>`: Navigate between windows (or create new splits)
- `<leader>w-`: Horizontal split
- `<leader>w/`: Vertical split
- `<leader>wd`: Close window
- `<leader>wm`: Maximize window