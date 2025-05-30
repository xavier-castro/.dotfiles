# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository that manages macOS configuration files using GNU Stow. Each top-level directory represents a "package" that can be symlinked to the home directory.

## Prerequisites

- GNU Stow (`brew install stow`)
- pnpm (for TypeScript-based configurations)

## Architecture

The repository follows a stow-compatible structure where each package directory contains files organized to mirror their target locations:

- `aerospace/` - Window manager for macOS providing tiling window management with keyboard shortcuts
- `asdf/` - Tool version manager for runtime management (.tool-versions includes nodejs, python, golang, rust, deno)
- `karabiner/` - Advanced keyboard customization tool for macOS with TypeScript-based config
- `lazygit/` - Terminal-based Git UI for simplified Git operations
- `local/` - Local binaries and custom scripts accessible system-wide
- `nvim/` - Neovim configuration based on Kickstart.nvim with LSP support and extensive plugins
- `tmux/` - Terminal multiplexer for managing multiple terminal sessions
- `zellij/` - Modern terminal workspace with built-in multiplexing
- `zsh/` - Optimized Z shell configuration using zi plugin manager with fast startup

# Common Commands

### Installing Dotfiles

```bash
# Install a specific package (creates symlinks)
stow <package-name>  # e.g., stow nvim

# Install all packages
stow */

# Remove/uninstall a package
stow -D <package-name>

# Reinstall a package (useful after making changes)
stow -R <package-name>
```

### Karabiner Configuration

The Karabiner configuration uses TypeScript to generate the config:

```bash
cd karabiner/.config/karabiner
pnpm install        # Install dependencies
pnpm run build      # Build the configuration
pnpm run watch      # Watch for changes and rebuild
```

### asdf Configuration

After installing asdf package with stow:

```bash
# Install plugins for all tools defined in .tool-versions
asdf plugin install
```

### Package Management

This repository uses pnpm as the package manager (per user preferences in ~/.claude/CLAUDE.md).

## Key Configuration Details

### Neovim

- Has its own comprehensive CLAUDE.md at `nvim/.config/nvim/CLAUDE.md`
- Based on Kickstart.nvim with extensive customizations
- Uses lazy.nvim for plugin management
- Includes LSP setup for multiple languages

### Tmux

- Configuration split across multiple files in `tmux/.config/tmux/`:
  - `tmux.conf` - Main configuration
  - `statusline.conf` - Status bar customization
  - `theme.conf` - Visual theming
  - `macos.conf` - macOS-specific settings

### Tmux-sessionizer

- Custom tmux session management tool for quick project switching
- Streamlines creating and switching between project-specific tmux sessions
- Maintains separate working environments for different projects

### Zellij

- Modern terminal workspace and multiplexer
- Alternative to tmux with built-in features
- Configuration includes custom layouts and harpoon plugin

### Zsh

- Uses zi (formerly zinit) as the plugin manager with optimized turbo loading
- Configuration in `.config/zsh/` with modular setup:
  - `.zshrc` - Main configuration with optimized plugin loading
  - `config/aliases.zsh` - Shell aliases and functions
  - `config/options.zsh` - Shell options for better UX and performance
  - `config/performance.zsh` - Performance measurement utilities
- Features:
  - Robbyrussell theme (lightweight alternative to Powerlevel10k)
  - Syntax highlighting and autosuggestions loaded immediately
  - Completions and other plugins loaded with turbo mode
  - Optimized completion compilation (once per day)

## Development Workflow

1. Make changes to configuration files in the appropriate package directory
2. For packages with build steps (like karabiner), run the build command
3. Use `stow -R <package>` to update symlinks if file structure changed
4. Test the configuration in the target application
5. Commit changes with git

## Important Notes

- All stow packages follow the pattern of having `.config/` or `.local/` subdirectories
- The `.gitignore` is configured to exclude common development artifacts and OS files
- Each package is self-contained and can be installed/removed independently
- Documentation lives in `docs/` directory:
  - `claude_code_best_practices.md` - Best practices for using Claude Code
  - `python_env_guide.md` - Python environment management guide





