# Enhanced Treesitter Configuration

This configuration provides comprehensive syntax highlighting, code parsing, and intelligent text manipulation for **Next.js** and **Rust** development, with extensive support for modern development workflows.

## 🌟 Key Features

### Comprehensive Language Support
- **40+ parsers** automatically installed for web, systems, and mobile development
- **Next.js ecosystem**: JavaScript, TypeScript, JSX, TSX, Vue, Svelte, Astro
- **Rust ecosystem**: Rust, RON (Rusty Object Notation), TOML
- **Universal tools**: Markdown, YAML, JSON, SQL, Docker, Git
- **Documentation**: LaTeX, Bibtex for academic writing

### Intelligent Text Objects
- **Function navigation**: `af`/`if` for outer/inner functions
- **Class manipulation**: `ac`/`ic` for outer/inner classes  
- **Parameter editing**: `aa`/`ia` for function parameters
- **Block selection**: `ab`/`ib` for code blocks
- **Rust-specific**: `ar`/`al` for assignment right/left-hand side

### Performance Optimized
- **Smart loading**: Auto-install parsers when entering buffers
- **Large file handling**: Automatic disabling for files >100KB or >10K lines
- **Selective highlighting**: Enhanced for JSX/TSX, conservative for others

## 🎯 Next.js Specific Features

### JSX/TSX Enhancement
- **Context-aware commenting**: Different comment styles for JSX elements vs JavaScript
- **Auto-tag closing**: Intelligent HTML/JSX tag completion and renaming
- **Rainbow brackets**: Disabled for JSX to prevent interference
- **Enhanced highlighting**: Additional regex highlighting for better syntax

### Modern Framework Support
```lua
-- Supported frameworks with auto-tag completion
jsx, tsx, vue, svelte, astro
```

### Smart Comment Strings
```javascript
// JavaScript: // comment
<div>{/* JSX element comment */}</div>
```

## ⚙️ Rust Specific Features

### Advanced Parsing
- **Rust syntax**: Full rust-analyzer integration
- **TOML support**: Cargo.toml and config file parsing
- **RON support**: Rusty Object Notation parsing

### Rust Text Objects
```rust
// Select assignment parts
let x = |y| y + 1;  // ar: |y| y + 1, al: x
```

## 🚀 Enhanced Functionality

### Incremental Selection
- `<C-space>`: Expand selection intelligently
- `<C-s>`: Expand to scope
- `<C-backspace>`: Shrink selection

### Function Navigation
- `]f`/`[f`: Next/previous function start
- `]F`/`[F`: Next/previous function end
- `]c`/`[c`: Next/previous class

### Code Manipulation
- `<leader>sp`/`<leader>sP`: Swap parameters
- `<leader>sf`/`<leader>sF`: Swap functions

### Context Features
- **Treesitter context**: Shows current function/class in statusline
- **Playground**: Debug treesitter parsing with `:TSPlayground`
- **Smart folding**: Treesitter-based code folding

## 📦 Installed Extensions

### Core Plugins
- `nvim-treesitter-textobjects` - Intelligent text manipulation
- `nvim-treesitter-context` - Context breadcrumbs
- `playground` - Treesitter debugging
- `nvim-ts-context-commentstring` - Context-aware commenting
- `nvim-ts-autotag` - Auto HTML/JSX tag management

### Language Matrix

| Language | Parser | Highlighting | Text Objects | Auto-tags | Comments |
|----------|--------|-------------|-------------|-----------|----------|
| TypeScript | ✅ | ✅ | ✅ | ❌ | ✅ |
| TSX | ✅ | ✅ | ✅ | ✅ | ✅ |
| JavaScript | ✅ | ✅ | ✅ | ❌ | ✅ |
| JSX | ✅ | ✅ | ✅ | ✅ | ✅ |
| Rust | ✅ | ✅ | ✅ | ❌ | ✅ |
| Vue | ✅ | ✅ | ✅ | ✅ | ✅ |
| Svelte | ✅ | ✅ | ✅ | ✅ | ✅ |
| Astro | ✅ | ✅ | ✅ | ✅ | ✅ |
| HTML | ✅ | ✅ | ✅ | ❌ | ✅ |
| CSS/SCSS | ✅ | ✅ | ✅ | ❌ | ✅ |
| JSON | ✅ | ✅ | ❌ | ❌ | ❌ |
| YAML | ✅ | ✅ | ✅ | ❌ | ✅ |
| TOML | ✅ | ✅ | ✅ | ❌ | ✅ |
| Markdown | ✅ | ✅ | ✅ | ❌ | ✅ |
| Lua | ✅ | ✅ | ✅ | ❌ | ✅ |
| Python | ✅ | ✅ | ✅ | ❌ | ✅ |
| Go | ✅ | ✅ | ✅ | ❌ | ✅ |
| SQL | ✅ | ✅ | ✅ | ❌ | ✅ |

## 🔧 Configuration Details

### Performance Settings
```lua
-- Large file detection
max_filesize = 100 * 1024  -- 100KB
max_lines = 10000          -- 10K lines

-- Smart highlighting
additional_vim_regex_highlighting = {
  "markdown", "tsx", "jsx"
}
```

### Comment String Configuration
```lua
-- Language-specific comment patterns
tsx = {
  __default = "// %s",           -- TypeScript comments
  jsx_element = "{/* %s */}",    -- JSX element comments
  jsx_fragment = "{/* %s */}",   -- JSX fragment comments
}
```

### Auto-tag Settings
```lua
-- Framework-specific auto-tag behavior
per_filetype = {
  ["jsx"] = { enable_close = true, enable_rename = true },
  ["tsx"] = { enable_close = true, enable_rename = true },
  ["vue"] = { enable_close = true, enable_rename = true },
}
```

## 🎨 Rainbow Brackets
Colorized matching brackets/parentheses (disabled for JSX to prevent conflicts):
- **Red**: `#cc241d`
- **Orange**: `#d65d0e` 
- **Yellow**: `#d79921`
- **Green**: `#689d6a`
- **Blue**: `#458588`
- **Purple**: `#b16286`
- **Gray**: `#a89984`

## 🛠️ Usage Examples

### Next.js Development
```typescript
// Auto-completion and text objects work seamlessly
const Component = ({ props }: Props) => {
  return (
    <div className="container">
      {/* Context-aware comments */}
      <span>Hello World</span>
    </div>
  );
};

// Text object examples:
// 'af' selects entire Component function
// 'if' selects function body only
// 'aa' selects 'props }: Props' parameter
```

### Rust Development
```rust
fn process_data(input: &str) -> Result<String, Error> {
    let result = input
        .lines()
        .map(|line| line.trim())
        .collect::<Vec<_>>();
    
    Ok(result.join("\n"))
}

// Text object examples:
// 'af' selects entire process_data function
// 'ar' selects the entire chain after '='
// 'al' selects 'result' variable
```

## 🔍 Debugging

### Treesitter Playground
Use `:TSPlayground` to debug parser issues:
- View syntax tree structure
- Identify highlighting problems
- Test custom queries

### Common Commands
- `:TSInstall <parser>` - Install specific parser
- `:TSUpdate` - Update all parsers  
- `:TSInstallInfo` - Show installation status
- `:TSConfigInfo` - Show current configuration

## 🚨 Troubleshooting

### Parser Installation Issues
1. Check internet connection for parser downloads
2. Verify compiler availability (gcc/clang)
3. Clear parser cache: `:TSUninstall <parser>` then `:TSInstall <parser>`

### Performance Issues
- Large files automatically disable treesitter
- Reduce `max_file_lines` for rainbow brackets
- Disable specific features for problematic languages

### Highlighting Problems
- Check if additional regex highlighting interferes
- Verify parser is correctly installed
- Use `:TSHighlightCapturesUnderCursor` for debugging

This enhanced treesitter configuration provides professional-grade syntax highlighting and code manipulation for modern development workflows.