# Which-Key Helix Preset Configuration

This configuration sets up which-key with the Helix editor preset for a more modern, editor-agnostic keybinding experience.

## 🎯 **Helix Preset Features**

### **Visual Style**
- **Rounded borders** for better aesthetics
- **Transparency** (10% window blend)
- **Helix-style icons** and separators
- **Organized layout** with proper spacing
- **Breadcrumb navigation** with visual indicators

### **Enhanced UX**
- **Dynamic delay** - Instant for plugins, 200ms for user mappings
- **Smart sorting** - Keys sorted by relevance and groups
- **Auto-expand** groups with few mappings
- **Scroll support** with `<C-d>`/`<C-u>`

## 🔑 **Key Group Organization**

### **Leader Key Groups**
| Prefix | Group | Purpose |
|--------|-------|---------|
| `<leader>b` | Buffer | Buffer operations |
| `<leader>c` | Code | Code actions and LSP |
| `<leader>f` | File/Find | File operations and fuzzy finding |
| `<leader>g` | Git | Git operations |
| `<leader>h` | Help | Help and documentation |
| `<leader>l` | LSP | Language server features |
| `<leader>m` | Mark | Bookmarks and marks |
| `<leader>s` | Search | Search and replace |
| `<leader>t` | Terminal | Terminal and toggles |
| `<leader>u` | UI/Toggle | UI toggles and settings |
| `<leader>w` | Window | Window management |
| `<leader>x` | Diagnostics | Error and quickfix |

### **Helix-Style Movement Groups**
| Prefix | Group | Purpose |
|--------|-------|---------|
| `g` | Goto | Navigation commands |
| `z` | Fold/View | Folding and view commands |
| `]` | Next | Forward navigation |
| `[` | Previous | Backward navigation |

## 🚀 **Helix-Inspired Keybindings**

### **File Operations**
```vim
<leader>ff  " Find files
<leader>fr  " Recent files  
<leader>fg  " Grep in files
<leader>fb  " Open buffers
```

### **Buffer Management**
```vim
<leader>bd  " Delete buffer
<leader>bn  " Next buffer
<leader>bp  " Previous buffer
```

### **Window Operations**
```vim
<leader>wh  " Go to left window
<leader>wj  " Go to lower window  
<leader>wk  " Go to upper window
<leader>wl  " Go to right window
<leader>ws  " Split horizontally
<leader>wv  " Split vertically
<leader>wq  " Close window
```

### **Search and Replace**
```vim
<leader>ss  " Search in current buffer
<leader>sp  " Search in project
<leader>sr  " Search and replace (grug-far)
```

### **UI Toggles**
```vim
<leader>un  " Toggle line numbers
<leader>ur  " Toggle relative numbers
<leader>uw  " Toggle word wrap
```

### **Helix-Style Movement**
```vim
gh  " Go to line start (same as ^)
gl  " Go to line end (same as $)
ge  " Go to file end (same as G)
gg  " Go to file start
```

## 🎨 **Visual Customization**

### **Icons and Separators**
- **Breadcrumb**: `»` - Shows active key combo
- **Separator**: `➜` - Between key and label
- **Group**: `+` - Group indicator
- **Ellipsis**: `…` - Truncation indicator

### **Layout Options**
- **Minimum width**: 20 characters
- **Spacing**: 3 characters between columns
- **Alignment**: Left-aligned for readability
- **Border**: Rounded for modern look

## ⚙️ **Configuration Options**

### **Performance**
```lua
delay = function(ctx)
  return ctx.plugin and 0 or 200  -- Instant for plugins
end
```

### **Disabled Contexts**
- **Terminal buffers** - Avoid conflicts
- **Telescope prompts** - Keep clean interface

### **Scroll Bindings**
- `<C-d>` - Scroll down in which-key popup
- `<C-u>` - Scroll up in which-key popup

## 🔧 **Integration**

### **AstroNvim Compatibility**
- Works seamlessly with existing AstroCore mappings
- Automatically registers mappings with `desc` keys
- Preserves all existing AstroNvim functionality

### **Plugin Integration**
- **Telescope** - File finding and searching
- **Grug-far** - Advanced search and replace
- **LSP** - Language server features
- **Git** - Version control operations

## 📋 **Usage Tips**

1. **Press any leader key** and wait 200ms to see available options
2. **Use partial keys** - Type part of a sequence to filter
3. **Scroll through options** with `<C-d>`/`<C-u>` in long lists
4. **Visual mode** - Some bindings work differently in visual mode
5. **Plugin keys** - Show instantly for faster workflow

## 🚨 **Troubleshooting**

### **Keys Not Showing**
- Ensure mappings have `desc` keys
- Check if mapping is in a disabled filetype
- Verify which-key is loaded: `:WhichKey`

### **Conflicts**
- Some keys may be overridden by other plugins
- Check for duplicate mappings: `:map <key>`
- Review AstroNvim's default bindings

### **Performance**
- Adjust delay function if popup is too fast/slow
- Disable in problematic filetypes via `disable.ft`

This Helix preset configuration provides a modern, organized, and efficient keybinding experience that feels familiar to users of modern editors while maintaining Neovim's power and flexibility.