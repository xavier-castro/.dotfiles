-- Enhanced AstroLSP configuration for Next.js and Rust development
-- Optimized for conform.nvim integration

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Enhanced features for modern development
    features = {
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = true, -- enable inlay hints for better code understanding
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },

    -- Comprehensive formatting configuration
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable format on save globally
        allow_filetypes = {
          -- Explicitly enable for supported languages
          "lua",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "rust",
          "python",
          "json",
          "yaml",
          "toml",
          "markdown",
          "html",
          "css",
          "scss",
        },
        ignore_filetypes = {
          -- Disable for problematic file types
          "oil", -- Oil file explorer
        },
      },


      timeout_ms = 10000, -- 10 second timeout for formatting

    },

    -- Additional servers for enhanced functionality
    servers = {
      -- Add any manually installed servers here
      "gopls",
      "pyright",
    },

    -- Enhanced LSP server configurations
    ---@diagnostic disable: missing-fields
    config = {
      -- TypeScript/JavaScript optimizations
      tsserver = {
        settings = {
          typescript = {
            preferences = {
              includePackageJsonAutoImports = "auto",
              importModuleSpecifier = "relative",
            },
          },
          javascript = {
            preferences = {
              includePackageJsonAutoImports = "auto",
              importModuleSpecifier = "relative",
            },
          },
        },
      },

      -- Rust analyzer optimizations
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
              extraArgs = { "--", "-W", "clippy::pedantic" },
            },
            cargo = {
              features = "all",
            },
            procMacro = {
              enable = true,
            },
          },
        },
      },

      -- Lua LSP optimizations
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            hint = {
              enable = true,
            },
          },
        },
      },
    },

    -- Enhanced LSP server handlers
    handlers = {
      -- Default handler with enhanced capabilities
      function(server, opts)
        -- Add common capabilities enhancement
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        -- Enhanced completion capabilities
        capabilities.textDocument.completion.completionItem = {
          documentationFormat = { "markdown", "plaintext" },
          snippetSupport = true,
          preselectSupport = true,
          insertReplaceSupport = true,
          labelDetailsSupport = true,
          deprecatedSupport = true,
          commitCharactersSupport = true,
          tagSupport = { valueSet = { 1 } },
          resolveSupport = {
            properties = { "documentation", "detail", "additionalTextEdits" },
          },
        }

        opts.capabilities = capabilities
        require("lspconfig")[server].setup(opts)
      end,
    },

    -- Enhanced auto commands for better LSP integration
    autocmds = {
      lsp_codelens_refresh = {
        cond = "textDocument/codeLens",
        {
          event = { "InsertLeave", "BufEnter" },
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },

      -- Auto-highlight symbol under cursor
      lsp_highlight_symbol = {
        cond = "textDocument/documentHighlight",
        {
          event = { "CursorHold", "CursorHoldI" },
          desc = "Highlight symbol under cursor",
          callback = function() vim.lsp.buf.document_highlight() end,
        },
        {
          event = { "CursorMoved", "CursorMovedI" },
          desc = "Clear highlight symbol",
          callback = function() vim.lsp.buf.clear_references() end,
        },
      },
    },

    -- Comprehensive keybinding configuration
    mappings = {
      n = {
        -- Navigation mappings
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        gd = {
          function() vim.lsp.buf.definition() end,
          desc = "Show the definition of current symbol",
          cond = "textDocument/definition",
        },
        gi = {
          function() vim.lsp.buf.implementation() end,
          desc = "Implementation of current symbol",
          cond = "textDocument/implementation",
        },
        gr = {
          function() vim.lsp.buf.references() end,
          desc = "References of current symbol",
          cond = "textDocument/references",
        },

        -- Enhanced formatting mappings with fallback support
        ["<Leader>lf"] = {
          function()
             -- Try conform.nvim first, then LSP            local conform_ok, conform = pcall(require, "conform")
            if conform_ok and conform.format then
              conform.format {
                async = true,
                timeout_ms = 1000,
                lsp_fallback = true,
              }
            else
              vim.lsp.buf.format {
                async = false,
                timeout_ms = 10000,
              }
            end
          end,
          desc = "Format buffer",
        },

        ["<Leader>lF"] = {
          function()
            -- Async version
            local conform_ok, conform = pcall(require, "conform")
            if conform_ok and conform.format then
              conform.format {
                async = true,
                timeout_ms = 10000,
                lsp_fallback = true,
              }
            else
              vim.lsp.buf.format {
                async = true,
                timeout_ms = 10000,
              }
            end
          end,
          desc = "Format buffer (async)",
        },

        -- Code action mappings
        ["<Leader>la"] = {
          function() vim.lsp.buf.code_action() end,
          desc = "LSP code action",
          cond = "textDocument/codeAction",
        },

        -- Symbol and workspace mappings
        ["<Leader>ls"] = {
          function() vim.lsp.buf.document_symbol() end,
          desc = "Search document symbols",
          cond = "textDocument/documentSymbol",
        },

        ["<Leader>lS"] = {
          function() vim.lsp.buf.workspace_symbol() end,
          desc = "Search workspace symbols",
          cond = "workspace/symbol",
        },

        -- Rename mapping
        ["<Leader>lr"] = {
          function() vim.lsp.buf.rename() end,
          desc = "Rename current symbol",
          cond = "textDocument/rename",
        },

        -- Diagnostics mappings
        ["<Leader>ld"] = {
          function() vim.diagnostic.open_float() end,
          desc = "Hover diagnostics",
        },

        ["[d"] = {
          function() vim.diagnostic.goto_prev() end,
          desc = "Previous diagnostic",
        },

        ["]d"] = {
          function() vim.diagnostic.goto_next() end,
          desc = "Next diagnostic",
        },

        -- Hover documentation
        K = {
          function() vim.lsp.buf.hover() end,
          desc = "Hover symbol details",
          cond = "textDocument/hover",
        },

        -- Signature help
        ["<Leader>lh"] = {
          function() vim.lsp.buf.signature_help() end,
          desc = "Signature help",
          cond = "textDocument/signatureHelp",
        },

        -- Toggle features
        ["<Leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client)
            return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
          end,
        },

        ["<Leader>uH"] = {
          function() require("astrolsp.toggles").buffer_inlay_hints() end,
          desc = "Toggle LSP inlay hints (buffer)",
          cond = function(client) return client.supports_method "textDocument/inlayHint" end,
        },
      },

      -- Insert mode mappings
      i = {
        ["<C-s>"] = {
          function() vim.lsp.buf.signature_help() end,
          desc = "Signature help",
          cond = "textDocument/signatureHelp",
        },
      },
    },

    -- Enhanced on_attach function for additional setup
    on_attach = function(client, bufnr)
      -- Optimize LSP clients for better performance
      if client.name == "tsserver" or client.name == "typescript-language-server" then
         -- Disable formatting for TypeScript LSP (use prettier via conform)
         client.server_capabilities.documentFormattingProvider = false
         client.server_capabilities.documentRangeFormattingProvider = false      end

      if client.name == "lua_ls" then
         -- Disable formatting for Lua LSP (use stylua via conform)
         client.server_capabilities.documentFormattingProvider = false
         client.server_capabilities.documentRangeFormattingProvider = false      end


      end, 1000)
    end,
  },
}
