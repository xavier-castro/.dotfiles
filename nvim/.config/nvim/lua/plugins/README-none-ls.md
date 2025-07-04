# Enhanced none-ls Configuration

This configuration provides comprehensive formatting, linting, and code action support for **Next.js** and **Rust** development, with additional support for other common languages.

## 🚀 Features

### Smart Project Detection
- **Automatic tool activation** based on project files (`package.json`, `Cargo.toml`, etc.)
- **Performance optimized** - only loads tools relevant to your current project
- **Conditional formatting** - tools only run when project configuration files are present

### Next.js & TypeScript Support
- **ESLint** integration with code actions and diagnostics
- **Prettier** formatting with project-specific configurations
- **TypeScript diagnostics** via `tsc`
- **Tailwind CSS** class sorting with `rustywind`
- **Vue/Svelte/Astro** support

### Rust Development
- **rustfmt** formatting with Rust 2021 edition
- **Clippy** linting with pedantic and nursery checks
- **TOML** formatting for `Cargo.toml` files

### Universal Tools
- **Spell checking** for markdown and documentation
- **YAML** linting and formatting
- **Shell script** formatting with `shfmt`
- **SQL** formatting with `sqlfluff`
- **Python**, **Go** support

## 📦 Installed Tools

### Language Servers
- `typescript-language-server` - TypeScript/JavaScript
- `rust-analyzer` - Rust
- `eslint-lsp` - ESLint integration
- `tailwindcss-language-server` - Tailwind CSS
- `json-lsp`, `yaml-language-server` - Config files
- `taplo` - TOML (Cargo.toml)

### Formatters
- `prettier` - JS/TS/JSON/YAML/Markdown
- `rustfmt` - Rust (via rust-analyzer)
- `stylua` - Lua
- `shfmt` - Shell scripts
- `black`, `isort` - Python
- `rustywind` - Tailwind classes

### Linters
- `eslint_d` - Fast ESLint daemon
- `yamllint` - YAML validation
- `codespell` - Spell checking
- `ruff` - Python linting

### Debuggers
- `js-debug-adapter` - JavaScript/TypeScript
- `codelldb` - Rust/C++
- `debugpy` - Python

## 🔧 Configuration Details

### Conditional Loading
Tools are only activated when relevant project files are detected:

```lua
-- Next.js tools activate when package.json exists
-- Rust tools activate when Cargo.toml exists
-- Python tools activate when pyproject.toml/setup.py exists
```

### Performance Optimizations
- `update_in_insert = false` - No diagnostics while typing
- `debounce = 200` - Reduced update frequency
- Project-specific tool loading
- Cached temporary directory

### Custom Configurations
- **ESLint**: Uses local `node_modules/.bin` when available
- **Prettier**: Respects project `.prettierrc` files
- **Clippy**: Includes pedantic and nursery lints
- **Black**: 88 character line length
- **Tailwind**: Sorts classes in JS/TS/HTML files

## 🎯 Usage Examples

### Next.js Project
When you open a project with `package.json`:
- ESLint diagnostics and code actions
- Prettier formatting for JS/TS/JSON
- TypeScript diagnostics if `tsconfig.json` exists
- Tailwind class sorting if config detected

### Rust Project
When you open a project with `Cargo.toml`:
- rustfmt formatting on save
- Clippy linting with advanced checks
- TOML formatting for config files

### Universal
Available in all projects:
- Markdown spell checking
- YAML validation
- Shell script formatting
- Lua formatting (for nvim config)

## 📁 Project Structure Detection

| Files Detected | Tools Activated |
|----------------|-----------------|
| `package.json` | ESLint, Prettier, TypeScript |
| `Cargo.toml` | rustfmt, Clippy |
| `pyproject.toml` | Black, isort, ruff |
| `go.mod` | gofmt, goimports |
| `.prettierrc*` | Project-specific Prettier |
| `tailwind.config.*` | rustywind |

## 🛠️ Customization

### Adding New Tools
Add to both `mason.lua` and `none-ls.lua`:

```lua
-- In mason.lua
"new-tool",

-- In none-ls.lua
conditional_source(
  null_ls.builtins.formatting.new_tool,
  { "project-file.json" }
),
```

### Disabling Tools
Comment out or remove from the respective source arrays in `none-ls.lua`.

### Project-Specific Overrides
Use `.nvim.lua` or `exrc` files in project root for project-specific configurations.

## 🚨 Troubleshooting

### Tool Not Working
1. Check if tool is installed: `:Mason`
2. Verify project detection: `:NullLsInfo`
3. Check for configuration files in project root

### Performance Issues
- Disable `auto_update` in mason.lua
- Reduce `debounce` value in none-ls.lua
- Use project-specific exclusions

### ESLint Issues
- Ensure `.eslintrc` or `eslint.config.js` exists
- Check `node_modules/.bin/eslint` is present
- Verify ESLint config is valid

## 📊 Tool Matrix

| Language | LSP | Formatter | Linter | Debugger |
|----------|-----|-----------|--------|----------|
| TypeScript | ✅ | ✅ | ✅ | ✅ |
| JavaScript | ✅ | ✅ | ✅ | ✅ |
| Rust | ✅ | ✅ | ✅ | ✅ |
| Python | ❌ | ✅ | ✅ | ✅ |
| Go | ❌ | ✅ | ❌ | ❌ |
| Lua | ✅ | ✅ | ❌ | ❌ |
| YAML | ✅ | ✅ | ✅ | ❌ |
| JSON | ✅ | ✅ | ❌ | ❌ |
| Markdown | ❌ | ✅ | ✅ | ❌ |
| TOML | ✅ | ✅ | ❌ | ❌ |

This configuration provides a robust, performance-optimized development environment for modern web and systems programming.
