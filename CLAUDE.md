# Xavier's Dotfiles Guide

## Repository Structure
- Organized using GNU Stow for symlink management
- Each tool has its own directory with proper relative path structure

## Build/Lint/Test Commands
- Install: `stow <directory>` (e.g., `stow tmux` to install tmux config)
- Uninstall: `stow -D <directory>` to remove configs
- Update: `git pull && stow <directory>` to update configs
- For Karabiner: `cd karabiner && yarn build` to compile TypeScript
- Reload Fish: `source ~/.config/fish/config.fish`

## Code Style Guidelines
- **Indentation**: 2 spaces for all config files
- **Naming**: snake_case for scripts, camelCase for TypeScript
- **Comments**: Include concise explanations for complex configurations
- **Imports**: Group by purpose, leave line break between groups
- **Organization**: Keep related functions/settings together
- **Error Handling**: For scripts, use proper exit codes and stderr
- **Line Length**: Keep under 80 chars when possible
- **Fish Functions**: Store in functions/ directory, use autoload pattern

## Folder Structure
- bin/.local/scripts/ - Utility scripts
- nvim/.config/nvim/ - Neovim configuration
- tmux/ - Tmux configuration
- fish/.config/fish/ - Fish shell configuration
- zsh/ - Zsh configuration