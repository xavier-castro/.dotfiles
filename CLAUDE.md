# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository using a **modular, application-specific structure**. Each application's configuration is stored in its own directory that mirrors the typical `~/.config/` structure.

## Key Architecture

### Zsh Configuration (`/zsh/`)
- **Framework**: Zsh 4 Humans (z4h) - batteries-included zsh setup
- **Auto-starts tmux**: Configured to start tmux sessions automatically
- **Features**: fzf integration, direnv support, Powerlevel10k theme
- **PATH**: Includes `~/.dotfiles/bin/.local/scripts` for custom utilities

### Tmux Configuration (`/tmux/`)
- **Prefix**: `Ctrl+a` (not default Ctrl+b)
- **Plugin Manager**: TPM (Tmux Plugin Manager)
- **Key Plugins**: tmux-pain-control, tmux-tpad, tmux-floax
- **Custom Floating Windows**:
  - `Ctrl+a` + `Ctrl+g` - lazygit
  - `Ctrl+a` + `Ctrl+c` - Claude Code
  - `Ctrl+a` + `Ctrl+p` - scratchpad
- **Session Management**: `Ctrl+a` + `f` - tmux-sessionizer with fzf

### Neovim Configuration (`/nvim/`)
- **Base**: TheXavier's init.lua configuration
- **Package Manager**: Lazy.nvim
- **Requirement**: Ripgrep must be installed

## Essential Scripts

### tmux-sessionizer
- **Location**: `bin/.local/scripts/tmux-sessionizer`
- **Purpose**: Intelligent tmux session management with fzf
- **Default search paths**: `~/`, `~/Developer`, `~/Dropbox/nb`
- **Config**: `~/.config/tmux-sessionizer/tmux-sessionizer.conf`

### tmux-cht.sh
- **Location**: `bin/.local/scripts/tmux-cht.sh`
- **Purpose**: Quick access to cheat.sh from tmux
- **Requires**: Language and command files in `~/.config/tmux/`

## Common Development Commands

### Setup Requirements
```bash
# Install Zsh 4 Humans
sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"

# Install dependencies
brew install ripgrep fzf tmux
```

### Key Tmux Bindings
- `Ctrl+a` + `r` - Reload tmux config
- `Ctrl+a` + `f` - Open tmux-sessionizer (project switcher)
- `Ctrl+a` + `i` - Open cheat.sh interface
- `Ctrl+a` + `D` - Open TODO.md or personal todo
- `Ctrl+a` + `o` - Open current directory in Finder
- `Ctrl+a` + `Ctrl+g` - Open lazygit in floating window
- `Ctrl+a` + `Ctrl+c` - Open Claude Code in floating window

### Vim-like Navigation
- `Ctrl+a` + `h/j/k/l` - Navigate panes (vim-style)
- `Ctrl+a` + `^` - Switch to last window

## Important Notes

- **Claude Code Integration**: Claude alias configured with `--dangerously-skip-permissions` flag
- **Terminal**: Configured for xterm-256color with true color support
- **Copy Mode**: Vi-mode enabled with clipboard integration (xclip)
- **Auto-session**: tmux starts automatically via zsh configuration
- **Directory Structure**: Each app config mirrors standard `~/.config/` layout

## File Structure
```
~/.dotfiles/
├── zsh/           # Zsh 4 Humans configuration
├── tmux/          # Tmux + plugins configuration  
├── nvim/          # Neovim (TheXavier's config)
└── bin/           # Custom scripts and utilities
```
