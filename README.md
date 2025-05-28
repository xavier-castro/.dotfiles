# Dotfiles

This repository contains my personal configuration files for macOS, managed using GNU Stow for easy installation and maintenance.

## Overview

Each directory in this repository represents a "package" that can be symlinked to your home directory using GNU Stow. This approach keeps configurations organized and makes it easy to manage dotfiles across different machines.

## Tools and Configurations

### aerospace
Window manager for macOS that provides tiling window management capabilities. Allows you to organize windows into workspaces and manage them with keyboard shortcuts.

### karabiner
Advanced keyboard customization tool for macOS. The configuration is written in TypeScript and compiled to JSON. It enables complex key remappings, shortcuts, and keyboard behavior modifications.

### lazygit
Terminal-based Git UI that simplifies common Git operations. Provides an interactive interface for staging, committing, branching, and other Git workflows without leaving the terminal.

### local
Contains local binaries and custom scripts. This is where personal shell scripts and executable files are stored for system-wide access.

### nvim
Neovim configuration with extensive customizations including LSP support, plugin management via lazy.nvim, and language-specific setups. Based on Kickstart.nvim with additional enhancements for development workflows.

### tmux
Terminal multiplexer configuration that enables multiple terminal sessions in a single window. Includes custom key bindings, status bar configuration, theming, and macOS-specific optimizations.

### tmux-sessionizer
Custom tmux session management tool that streamlines creating and switching between project-specific tmux sessions. Makes it easy to jump between different projects and maintain separate working environments.

### zsh
Z shell configuration using zi (formerly zinit) as the plugin manager. Includes custom aliases, shell options, and Powerlevel10k theme for an enhanced command-line experience.

## Installation

### Prerequisites
- GNU Stow
- pnpm (for TypeScript-based configurations)

### Installing a specific configuration
```bash
stow <package-name>
```

### Installing all configurations
```bash
stow */
```

### Removing a configuration
```bash
stow -D <package-name>
```

### Reinstalling a configuration (useful after updates)
```bash
stow -R <package-name>
```

## Special Instructions

### Karabiner
The Karabiner configuration requires building:
```bash
cd karabiner/.config/karabiner
pnpm install
pnpm run build
```

### Development Workflow
1. Make changes to configuration files in the appropriate package directory
2. For packages with build steps, run the build command
3. Use `stow -R <package>` to update symlinks if needed
4. Test the configuration
5. Commit changes

## Structure

Each package follows a structure that mirrors the target location in your home directory. Most configurations live in `.config/` or `.local/` subdirectories within each package.