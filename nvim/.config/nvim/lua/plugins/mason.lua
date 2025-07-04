-- Enhanced Mason configuration for Next.js and Rust development

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- Language Servers
        "lua-language-server", -- Lua LSP
        "typescript-language-server", -- TypeScript/JavaScript LSP
        "rust-analyzer", -- Rust LSP
        "eslint-lsp", -- ESLint LSP
        "tailwindcss-language-server", -- Tailwind CSS LSP
        "json-lsp", -- JSON LSP
        "yaml-language-server", -- YAML LSP
        "taplo", -- TOML LSP (for Cargo.toml)

        -- Formatters
        "stylua", -- Lua formatter
        "prettier", -- JS/TS/JSON/YAML/Markdown formatter
        "rustfmt", -- Rust formatter (built into rust-analyzer)
        "shfmt", -- Shell script formatter
        "black", -- Python formatter
        "isort", -- Python import sorter
        -- Go tools commented out - install manually if needed
        -- "gofmt", -- Go formatter  
        -- "goimports", -- Go import formatter
        "rustywind", -- Tailwind CSS class sorter
        "sqlfluff", -- SQL formatter

        -- Linters & Diagnostics
        "eslint_d", -- Fast ESLint daemon
        "yamllint", -- YAML linter
        "codespell", -- Spell checker
        "ruff", -- Fast Python linter/formatter

        -- Debuggers
        "debugpy", -- Python debugger
        "js-debug-adapter", -- JavaScript/TypeScript debugger
        "codelldb", -- Rust/C++ debugger

        -- Additional Tools
        "tree-sitter-cli", -- Tree-sitter CLI
        "vtsls", -- Vue TypeScript language service
        "emmet-ls", -- Emmet language server for HTML/CSS
      },

      -- Auto-update packages
      auto_update = true,

      -- Run on start (can be disabled for faster startup)
      run_on_start = true,

      -- Install missing tools automatically
      ensure_installed_update = false,
    },
  },
}
