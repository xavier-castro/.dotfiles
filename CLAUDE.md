# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository that manages configuration files for a modern terminal-based development environment. The setup is optimized for keyboard-driven workflows, project session management, and Neovim-centric editing.

## Key Architecture Patterns

### XDG Configuration Structure
- All configurations follow the `~/.config/` standard layout
- Each tool has its own isolated directory under the tool name
- Configurations are organized by tool rather than by file type

### Session-Based Workflow
The entire setup revolves around project-based session management:
- **Tmux Sessionizer**: `bin/.local/scripts/tmux-sessionizer` - FZF-based project navigation
- **Zellij Sessionizer**: `bin/.local/scripts/zellij-sessionizer` - Similar workflow for Zellij
- **IDE Script**: `bin/.local/scripts/ide` - Quick tmux development layout setup

### Shell Configuration (Fish)
Primary config at `fish/.config/fish/config.fish` includes:
- Custom aliases: `npm` → `pnpm`, `vim` → `nvim`, `g` → `git`
- PATH management for Node.js, Go, pnpm, mise
- FZF integration with `Ctrl+F` tmux sessionizer keybinding
- Fisher plugin manager with hydro theme

### Terminal Multiplexer Dual Setup
- **Tmux**: `tmux/.config/tmux/tmux.conf` - Uses custom "vague" theme, vim-like bindings
- **Zellij**: `zellij/.config/zellij/config.kdl` - Rose Pine Moon theme, tmux compatibility mode

### Editor Configuration
- **Neovim**: Based on LazyVim distribution in `nvim/.config/nvim/`
- Custom plugins include Claude Code integration
- Standard LazyVim structure with `lua/config/` and `lua/plugins/`

## Common Development Commands

### Session Management
```bash
# Start tmux session for project (via FZF)
Ctrl+F  # (from within fish shell)

# Manual tmux sessionizer
~/bin/.local/scripts/tmux-sessionizer

# Quick IDE layout in tmux
~/bin/.local/scripts/ide

# Zellij session management
~/bin/.local/scripts/zellij-sessionizer
```

### Development Tools
```bash
# Tool management (using mise)
mise install    # Install tools from mise.toml
mise list      # List installed tools

# Package management (aliased to pnpm)
npm install    # Actually runs pnpm install
npm run dev    # Actually runs pnpm run dev
```

### Git Workflow
```bash
g status       # Aliased git status
g add          # Aliased git add
# Lazygit available via tmux prefix+g
```

## Installation Notes

This repository does not include automated installation scripts. Manual setup requires:
1. Cloning to `~/.dotfiles/`
2. Creating symlinks from configuration directories to `~/.config/`
3. Installing required tools (fish, tmux/zellij, nvim, fzf, fd, mise)
4. Setting up Fisher plugin manager for fish

## Theme Consistency

The setup uses a cohesive "vague" theme across:
- Tmux configuration
- Custom color schemes in `assets/`
- Terminal configurations (Ghostty colors)

## Search Paths for Sessionizers

Both tmux and zellij sessionizers search these directories:
- `~/Developer/` - Primary development projects
- `~/` - Home directory projects  
- `~/Dropbox/nb` - Notes/notebook directory
- `~/Dropbox` - Dropbox projects