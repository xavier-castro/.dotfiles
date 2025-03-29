# Fish Shell Configuration

This is a high-performance Fish shell configuration that mimics the functionality of the zsh configuration.

## Prerequisites

This configuration requires the following tools to be installed:

1. [Fish shell](https://fishshell.com/) - The shell itself
2. [Bass](https://github.com/edc/bass) - Required for Bash compatibility in NVM and Bun functions
3. [Zoxide](https://github.com/ajeetdsouza/zoxide) - Smart directory navigation
4. [Tmux](https://github.com/tmux/tmux) - Terminal multiplexer (for `tmux-sessionizer`)

## Installation

1. Install Fish shell:

   ```
   brew install fish
   ```

2. Install Bass plugin:

   ```
   fisher install edc/bass
   ```

3. Install Zoxide:

   ```
   brew install zoxide
   ```

4. Copy these configuration files to your Fish config directory:

   ```
   mkdir -p ~/.config/fish/conf.d
   cp config.fish ~/.config/fish/
   cp conf.d/env.fish ~/.config/fish/conf.d/
   ```

5. Create a private.fish file for your private environment variables (optional):
   ```
   touch ~/.config/fish/private.fish
   ```

## Features

- Ultra-fast loading with lazy loading for:
  - NVM (Node Version Manager)
  - PNPM
  - Bun
- Minimal but useful shell configuration
- Fast prompt with Git status
- Useful aliases and key bindings
- Built-in syntax highlighting and autosuggestions (Fish defaults)

## Note

Fish is not POSIX-compliant. Some scripts designed for Bash/Zsh might not work directly in Fish. Use Bass for compatibility with Bash scripts when needed.
