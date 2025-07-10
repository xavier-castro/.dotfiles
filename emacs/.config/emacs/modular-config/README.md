# Modular Emacs Configuration

A clean, modular Emacs configuration using the built-in `package.el` system with `use-package` for easy package management.

## Structure

```
emacs/modular-config/
├── init.el              # Main configuration file
├── early-init.el        # Early initialization settings
├── modules/             # Modular configuration files
│   ├── init-ui.el       # UI and appearance settings
│   ├── init-fonts.el    # Font configuration
│   ├── init-evil.el     # Evil mode (Vim keybindings)
│   ├── init-keybindings.el # Custom keybindings
│   ├── init-org.el      # Org mode configuration
│   └── init-utils.el    # Utility packages
└── README.md           # This file
```

## Features

### Core Features
- **Modular Design**: Each aspect of configuration is separated into its own module
- **Built-in Package Management**: Uses Emacs' built-in `package.el` with `use-package`
- **Evil Mode**: Vim-like keybindings with extensive customization
- **Modern UI**: Clean, modern interface with doom-themes and doom-modeline
- **Comprehensive Keybindings**: Spacemacs-inspired leader key system

### Modules Overview

#### `init-ui.el` - User Interface
- Modern themes (doom-themes)
- Enhanced modeline (doom-modeline)
- Beautiful icons (all-the-icons)
- Dashboard with quick access
- Rainbow delimiters
- Highlight TODO keywords
- Whitespace visualization
- Beacon cursor highlighting

#### `init-fonts.el` - Font Configuration
- Automatic font detection with fallbacks
- Platform-specific optimizations
- Unicode and emoji support
- Org mode heading fonts
- Font scaling functions
- Mixed pitch mode for better reading

#### `init-evil.el` - Vim Emulation
- Evil mode with comprehensive configuration
- Evil Collection for mode-specific bindings
- Evil Commentary for easy commenting
- Evil Surround for text manipulation
- Evil Numbers for increment/decrement
- Evil Escape with `jk` sequence
- Many additional Evil extensions

#### `init-keybindings.el` - Custom Keybindings
- Spacemacs-inspired leader key system (`SPC`)
- Comprehensive key mappings for all common operations
- Hydra for transient keymaps
- Which-key for keybinding discovery
- Mode-specific keybindings

#### `init-org.el` - Org Mode
- Comprehensive Org mode setup
- Org Roam for note-taking
- Org Journal for daily notes
- Custom capture templates
- Agenda configuration
- Export settings
- Babel configuration for code blocks
- Modern org bullets and styling

#### `init-utils.el` - Utility Packages
- Ivy/Counsel/Swiper for completion
- Avy for jumping
- Multiple cursors
- Smartparens for parentheses
- Projectile for project management
- Magit for Git integration
- Company for auto-completion
- Yasnippet for snippets
- Helpful for better help

## Installation

1. **Backup your current configuration**:
   ```bash
   mv ~/.emacs.d ~/.emacs.d.backup
   ```

2. **Copy the modular configuration**:
   ```bash
   cp -r modular-config ~/.emacs.d
   ```

3. **Start Emacs**:
   ```bash
   emacs
   ```

   The first startup will take a few minutes as packages are downloaded and installed.

## Key Bindings

### Leader Key (`SPC`)
The configuration uses a Spacemacs-inspired leader key system with `SPC` as the main leader key.

#### Buffer Management (`SPC b`)
- `SPC b b` - Switch buffer
- `SPC b k` - Kill buffer
- `SPC b n` - Next buffer
- `SPC b p` - Previous buffer
- `SPC b r` - Reload buffer

#### File Management (`SPC f`)
- `SPC f f` - Find file
- `SPC f r` - Recent files
- `SPC f s` - Save file
- `SPC f d` - Open dired

#### Window Management (`SPC w`)
- `SPC w w` - Other window
- `SPC w d` - Delete window
- `SPC w s` - Split horizontally
- `SPC w v` - Split vertically

#### Search (`SPC s`)
- `SPC s s` - Swiper search
- `SPC s p` - Ripgrep search
- `SPC s r` - Query replace

#### Git (`SPC g`)
- `SPC g s` - Magit status
- `SPC g c` - Commit
- `SPC g p` - Push
- `SPC g f` - Fetch

#### Org Mode (`SPC n`)
- `SPC n n` - New note
- `SPC n f` - Find note
- `SPC n c` - Org capture
- `SPC n a` - Org agenda

#### Applications (`SPC a`)
- `SPC a t` - Terminal
- `SPC a d` - Dired
- `SPC a c` - Calculator

### Evil Mode Bindings
Standard Vim keybindings are available throughout Emacs:
- `h/j/k/l` - Navigation
- `i/a/o` - Insert modes
- `v/V` - Visual selection
- `y/d/c` - Yank/delete/change
- `u/C-r` - Undo/redo
- `:` - Command mode

### Additional Bindings
- `C-;` - Avy jump to character
- `C-'` - Avy jump to line
- `C-=` - Expand region
- `C-+/-` - Zoom in/out
- `M-x` - Execute command (counsel-M-x)

## Customization

### Adding New Modules
1. Create a new file in `modules/` directory (e.g., `init-programming.el`)
2. Add `(require 'init-programming)` to `init.el`
3. Follow the existing module structure

### Modifying Existing Modules
Each module is self-contained and can be modified independently:
- `init-ui.el` - Change themes, colors, UI elements
- `init-fonts.el` - Adjust font settings
- `init-evil.el` - Customize Vim bindings
- `init-keybindings.el` - Add/modify keybindings
- `init-org.el` - Customize Org mode
- `init-utils.el` - Add/remove utility packages

### Package Management
To add a new package:
```elisp
(use-package package-name
  :config
  ;; Configuration here
  )
```

### Disabling Modules
Comment out the `(require 'module-name)` line in `init.el` to disable a module.

## Troubleshooting

### Slow Startup
- Check `*Messages*` buffer for errors
- Run `M-x use-package-report` to see package load times
- Disable modules one by one to identify the issue

### Package Installation Issues
- Run `M-x package-refresh-contents`
- Check your internet connection
- Try `M-x package-install` manually

### Keybinding Conflicts
- Use `C-h k` to see what a key is bound to
- Use `SPC h b` to see all bindings
- Check for conflicts in `*Messages*` buffer

## Resources

- [Emacs Manual](https://www.gnu.org/software/emacs/manual/html_node/emacs/)
- [use-package Documentation](https://github.com/jwiegley/use-package)
- [Evil Mode Documentation](https://github.com/emacs-evil/evil)
- [Org Mode Manual](https://orgmode.org/manual/)

## Contributing

This configuration is designed to be:
- **Modular**: Easy to add/remove components
- **Documented**: Clear comments and documentation
- **Beginner-friendly**: Good defaults with room for customization
- **Stable**: Uses well-tested packages and configurations

Feel free to fork and customize according to your needs!