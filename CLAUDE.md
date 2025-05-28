# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository that manages macOS configuration files using GNU Stow. Each top-level directory represents a "package" that can be symlinked to the home directory.

## Architecture

The repository follows a stow-compatible structure where each package directory contains files organized to mirror their target locations:

- `aerospace/` - Window manager configuration
- `karabiner/` - Keyboard customization (TypeScript-based config)
- `lazygit/` - Git UI configuration
- `local/` - Local binaries and scripts
- `nvim/` - Neovim configuration (extensive setup with LSP, plugins)
- `tmux/` - Terminal multiplexer configuration
- `tmux-sessionizer/` - Tmux session management
- `zsh/` - Shell configuration with zi plugin manager

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

### Zsh

- Uses zi (formerly zinit) as the plugin manager
- Configuration in `.config/zsh/` with modular setup:
  - `config/aliases.zsh` - Shell aliases
  - `config/options.zsh` - Shell options
  - `.p10k.zsh` - Powerlevel10k theme configuration

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

