# Zsh Configuration

## Overview
This directory contains zsh configuration files that are symlinked to your home directory using GNU Stow.

## Files
- `.zshenv` - Environment variables and paths, loaded for all zsh sessions
- `.zshrc` - Interactive shell configuration, aliases, and Oh-My-Zsh setup
- `.zshenv_private_example` - Template for creating your private environment variables

## Private Environment Variables
Your private keys and secrets should be stored in `~/.zshenv_private` (not tracked by git).
This file is sourced in `.zshenv` to ensure variables are available to all zsh sessions.

## Installation

```bash
# From the dotfiles root directory
stow zsh

# Create your private environment file
cp ~/.dotfiles/zsh/.zshenv_private_example ~/.zshenv_private
# Edit the file with your secrets
```

## Security Notes
- Never commit `.zshenv_private` to git
- Consider using a password manager or macOS Keychain for highly sensitive credentials
