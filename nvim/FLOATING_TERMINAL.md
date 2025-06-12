# Floating Terminal - Quick Reference

## What's been improved:

✅ **Robust error handling** - Won't crash if terminal fails to start
✅ **Proper buffer management** - Reuses terminal sessions across toggles  
✅ **Auto-resize support** - Adapts to window size changes
✅ **Minimum size constraints** - Ensures terminal is always usable
✅ **Better cleanup** - Proper cleanup when terminal exits
✅ **Enhanced UI** - Rounded borders with title bar

## Key bindings:

- **`<Space>ft`** - Toggle floating terminal (normal mode)
- **`Ctrl+X`** - Close terminal (from terminal mode)  
- **`Esc Esc`** - Switch to normal mode (from terminal mode)

## Features:

- **Persistent sessions** - Terminal state persists when toggling
- **Auto-insert mode** - Automatically enters insert mode when opened
- **Responsive design** - Uses 80% of screen width/height
- **Smart cleanup** - Handles terminal exit gracefully
- **Error notifications** - Shows helpful messages if something goes wrong

## Configuration location:
`~/.dotfiles/nvim/.config/nvim/lua/xavier/plugins/mini.lua`

## Troubleshooting:

If the terminal doesn't work:
1. Check that your `$SHELL` environment variable is set
2. Try restarting Neovim 
3. Check for error messages with `:messages`
4. Make sure the mini.nvim plugin is properly loaded

## Technical details:

- Uses `vim.fn.termopen()` for terminal creation
- Implements proper buffer lifecycle management
- Handles window resize events automatically
- Uses floating window API with minimal style
- Integrates with mini.clue for keybinding hints
