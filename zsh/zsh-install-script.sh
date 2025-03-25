#!/bin/bash
# Run this script to set up the optimized zsh environment

# Backup current configuration
mkdir -p ~/.zsh_backup
cp ~/.zshrc ~/.zsh_backup/zshrc.bak 2>/dev/null
cp ~/.zshenv ~/.zsh_backup/zshenv.bak 2>/dev/null

# Install fast-syntax-highlighting (much faster than zsh-syntax-highlighting)
mkdir -p ~/.zsh
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ~/.zsh/fast-syntax-highlighting

# Install new configuration files
cp .zshrc ~/.zshrc
cp .zshenv ~/.zshenv

# Recommended: Install starship for an even nicer prompt (optional)
curl -sS https://starship.rs/install.sh | sh

echo "Installation complete! Start a new terminal to experience the speed."
echo "Your original configuration has been backed up to ~/.zsh_backup/"
