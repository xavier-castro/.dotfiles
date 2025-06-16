# Fish Shell Configuration

## Commands
- **Test syntax**: `fish -n config.fish` or `fish -n functions/*.fish`
- **Reload config**: `source ~/.config/fish/config.fish`
- **Test function**: `fish -c "function_name"`

## Code Style Guidelines
- **File structure**: Main config in `config.fish`, functions in `functions/`, completions in `completions/`, auto-load configs in `conf.d/`
- **Variables**: Use `set -g` for global, `set -l` for local, `set -gx` for exported environment variables
- **Naming**: Snake_case for variables, lowercase for functions
- **Comments**: Use `#` for comments, document complex logic
- **Conditionals**: Use `if`/`end` blocks, prefer `status is-interactive` for interactive-only code
- **Commands**: Use `command -v` or `type -q` to check if commands exist before using
- **Strings**: Use double quotes for variable expansion, single quotes for literals
- **Functions**: Place in separate files in `functions/` directory, use descriptive names
- **Aliases**: Define in main config, use full command paths when possible
- **Error handling**: Check command existence with `command -v`, use conditional execution
- **Path management**: Use `set -gx PATH` for path modifications, avoid duplicates
- **Bindings**: Use `bind` for key bindings, specify mode with `-M`
- **Theme/prompt**: Configure theme variables with `set -g theme_*` pattern