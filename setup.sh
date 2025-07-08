#!/bin/bash

# Setup script for installing CLI/TUI tools via Homebrew
# This script installs all dependencies listed in the Brewfile

set -e

echo "🍺 Setting up CLI/TUI tools via Homebrew..."
echo "============================================"

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew is not installed. Please install Homebrew first:"
    echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE_PATH="$SCRIPT_DIR/Brewfile"

# Check if Brewfile exists
if [[ ! -f "$BREWFILE_PATH" ]]; then
    echo "❌ Brewfile not found at $BREWFILE_PATH"
    exit 1
fi

echo "📦 Installing dependencies from Brewfile..."
brew bundle --file "$BREWFILE_PATH"

# Check for Node.js and npm
if ! command -v node &> /dev/null || ! command -v npm &> /dev/null; then
    echo "🟡 Node.js or npm not found. Installing Node.js via Homebrew..."
    brew install node
fi

# Install gemini-cli if not already installed
if ! command -v gemini &> /dev/null; then
    echo "🚀 Installing gemini-cli..."
    npm install -g @google/gemini-cli
else
    echo "✅ gemini-cli is already installed."
fi

echo "✅ Setup complete! All CLI/TUI tools have been installed."
echo ""
echo "Installed tools include:"
echo "  • neovim (nvim) - Modern Vim-based editor"
echo "  • tmux - Terminal multiplexer"
echo "  • fzf - Command-line fuzzy finder"
echo "  • ripgrep (rg) - Fast text search tool"
echo "  • fd - Fast find alternative"
echo "  • bat - Cat alternative with syntax highlighting"
echo "  • jq - JSON processor"
echo "  • lazygit - Git TUI"
echo "  • navi - Interactive cheatsheet tool"
echo "  • buku - Bookmark manager"
echo "  • jrnl - Journal tool"
echo "  • todoist-cli (todoist) - Todoist CLI"
echo "  • gh - GitHub CLI"
echo "  • glow - Markdown viewer"
echo "  • taskwarrior-tui - Task management TUI"
echo "  • ical-buddy (icalBuddy) - Calendar tool"
echo "  • yq - YAML processor"
echo "  • entr - File watcher"
echo "  • gum - Shell script styling"
echo ""
echo "🎉 You're all set!"
