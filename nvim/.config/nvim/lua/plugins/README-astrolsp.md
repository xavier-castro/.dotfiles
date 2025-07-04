# Enhanced AstroLSP Configuration

This configuration resolves formatting conflicts between none-ls, conform.nvim, and native LSP formatters while providing comprehensive Next.js and Rust development support.

## 🎯 **Key Problem Solved**

The `<leader>lf` formatting wasn't working due to conflicts between:
- **conform.nvim** (from astrocommunity)
- **none-ls** (custom configuration)
- **Native LSP formatters** (built-in)

## ✅ **Solution Implemented**

### **Smart Formatter Fallback**
```lua
["<Leader>lf"] = {
  function() 
    -- Try conform.nvim first, then none-ls, then LSP
    local conform_ok, conform = pcall(require, "conform")
    if conform_ok and conform.format then
      conform.format({ 
        async = false,
        timeout_ms = 10000,
        lsp_fallback = true,
      })
    else
      vim.lsp.buf.format({ 
        async = false,
        timeout_ms = 10000,
      })
    end
  end,
  desc = "Format buffer",
},
```

### **LSP Formatter Conflicts Resolved**
```lua
-- Disable LSP formatting for languages handled by none-ls/conform
disabled = { 
  "lua_ls", -- Use stylua via none-ls
  "tsserver", -- Use prettier via none-ls
  "typescript-language-server", -- Use prettier via none-ls
  "jsonls", -- Use prettier via none-ls
  "yamlls", -- Use prettier via none-ls
},
```

### **Runtime Capability Disabling**
```lua
on_attach = function(client, bufnr)
  if client.name == "tsserver" or client.name == "typescript-language-server" then
    client.server_capabilities.documentFormattingProvider = false
  end
  -- ... similar for other LSPs
end
```

## 🚀 **Enhanced Features**

### **Next.js Development**
- **TypeScript/JavaScript**: Enhanced auto-imports, relative imports
- **ESLint Integration**: Code actions and diagnostics
- **Prettier Formatting**: Project-aware configuration
- **Inlay Hints**: Type information display

### **Rust Development**
- **rust-analyzer**: Clippy on save, macro support
- **Enhanced Diagnostics**: Pedantic lint warnings
- **Cargo Integration**: All features enabled
- **Format Preservation**: rustfmt via none-ls

### **Universal Enhancements**
- **Smart Highlighting**: Symbol highlighting under cursor
- **Enhanced Completion**: Rich completion item support
- **Diagnostic Navigation**: `[d`/`]d` for quick navigation
- **Code Actions**: `<leader>la` for available actions

## 🔧 **Available Keybindings**

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>lf` | Format buffer | Smart formatter with fallback |
| `<leader>lF` | Format buffer (async) | Non-blocking formatting |
| `<leader>la` | Code actions | Available code fixes/refactors |
| `<leader>lr` | Rename symbol | Intelligent symbol renaming |
| `<leader>ls` | Document symbols | Search current file symbols |
| `<leader>lS` | Workspace symbols | Search project-wide symbols |
| `<leader>ld` | Show diagnostics | Hover diagnostic details |
| `<leader>lh` | Signature help | Function signature information |
| `gd` | Go to definition | Jump to symbol definition |
| `gi` | Go to implementation | Jump to symbol implementation |
| `gr` | Go to references | Find all symbol references |
| `K` | Hover documentation | Show symbol documentation |
| `[d` / `]d` | Navigate diagnostics | Previous/next diagnostic |
| `<leader>uH` | Toggle inlay hints | Show/hide type hints |
| `<leader>uY` | Toggle semantic tokens | Enhanced syntax highlighting |

## 🛠️ **Debugging Commands**

### **Check Formatter Status**
```vim
:LspInfo                    " Show active LSP clients
:ConformInfo               " Show conform.nvim status (if available)
:checkhealth null-ls       " Check none-ls health
```

### **Manual Formatting**
```vim
:lua vim.lsp.buf.format()                    " Force LSP formatting
:lua require('conform').format()             " Force conform formatting (if available)
```

### **Check Keybindings**
```vim
:nmap <leader>lf           " Verify keybinding is set
:WhichKey <leader>l        " Show all LSP keybindings
```

## 🔄 **Formatter Priority Order**

1. **conform.nvim** - If available and configured
2. **none-ls** - Custom formatters with project detection
3. **LSP Native** - Built-in language server formatting

This ensures maximum compatibility while preferring external formatters for consistency.

## 📋 **File Type Support**

| Language | Formatter | Source | Notes |
|----------|-----------|--------|-------|
| **Lua** | stylua | none-ls | LSP disabled |
| **TypeScript/JavaScript** | prettier | none-ls | Project-aware |
| **Rust** | rustfmt | none-ls/LSP | Dual support |
| **JSON/YAML** | prettier | none-ls | LSP disabled |
| **Python** | black + isort | none-ls | Conditional |
| **Go** | gofmt + goimports | none-ls | Conditional |
| **HTML/CSS** | prettier | none-ls | Universal |
| **Markdown** | prettier | none-ls | With spell check |

## 🚨 **Troubleshooting**

### **Formatting Not Working**
1. Check file type is supported: `:set ft?`
2. Verify tools are installed: `:Mason`
3. Check project files exist (package.json, Cargo.toml, etc.)
4. Test manual formatting: `:lua vim.lsp.buf.format()`

### **Conflicting Formatters**
- The configuration automatically disables LSP formatting for handled languages
- Runtime debugging shows which formatters are active
- Prefer external formatters over LSP for consistency

### **Performance Issues**
- 10-second timeout prevents hanging
- Async formatting available with `<leader>lF`
- Inlay hints can be toggled if causing lag

This enhanced configuration provides a robust, conflict-free formatting experience optimized for modern development workflows.