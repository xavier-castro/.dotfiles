#!/usr/bin/env fish

# Test script for floating terminal functionality
echo "Testing floating terminal configuration..."

# Check if nvim config directory exists
if test -d ~/.dotfiles/nvim/.config/nvim
    echo "✓ Neovim config directory found"
else
    echo "✗ Neovim config directory not found"
    exit 1
end

# Check if xavier mini plugin exists
if test -f ~/.dotfiles/nvim/.config/nvim/lua/xavier/plugins/mini.lua
    echo "✓ Xavier mini plugin found"
else
    echo "✗ Xavier mini plugin not found"
    exit 1
end

# Test syntax of the plugin
cd ~/.dotfiles/nvim/.config/nvim
if nvim --headless -c "lua vim.cmd('luafile lua/xavier/plugins/mini.lua')" -c "qa" 2>/dev/null
    echo "✓ Plugin syntax is valid"
else
    echo "✗ Plugin has syntax errors"
    exit 1
end

echo ""
echo "Configuration test completed successfully!"
echo ""
echo "To use the floating terminal:"
echo "1. Open Neovim"
echo "2. Press <Space>ft to toggle the floating terminal"
echo "3. Use Ctrl+X from terminal mode to close it"
echo "4. Use Esc+Esc to switch to normal mode in terminal"
echo ""
echo "The terminal will:"
echo "- Use 80% of screen width and height"
echo "- Have rounded borders"
echo "- Auto-resize when Neovim window is resized"
echo "- Persist across toggles (same session)"
echo "- Handle cleanup properly when exiting"
