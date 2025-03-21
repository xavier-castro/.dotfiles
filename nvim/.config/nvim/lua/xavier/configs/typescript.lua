local api = require("typescript-tools.api")
local which_key_on_attach

-- Load the on_attach function when which-key is loaded
vim.api.nvim_create_autocmd("User", {
  pattern = "WhichKeyLoaded",
  callback = function()
    which_key_on_attach = require("xavier.configs.which-key").on_attach
  end
})

require("typescript-tools").setup {
  -- Typescript tools configuration options
  on_attach = function(client, bufnr)
    -- Disable tsserver formatter as we'll use a dedicated formatter
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    -- Register which-key bindings if loaded
    if which_key_on_attach then
      which_key_on_attach(client, bufnr)
    end

    -- Enable inlay hints for TypeScript
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    -- Add additional TypeScript specific keymaps
    vim.keymap.set("n", "<leader>to", function() 
      api.organize_imports() 
    end, { buffer = bufnr, desc = "Organize Imports" })
    
    vim.keymap.set("n", "<leader>tR", function() 
      api.rename_file() 
    end, { buffer = bufnr, desc = "Rename File" })

    vim.keymap.set("n", "<leader>ti", function()
      api.add_missing_imports()
    end, { buffer = bufnr, desc = "Add Missing Imports" })

    vim.keymap.set("n", "<leader>tu", function() 
      api.remove_unused_imports() 
    end, { buffer = bufnr, desc = "Remove Unused Imports" })

    vim.keymap.set("n", "<leader>tI", function() 
      api.fix_all() 
    end, { buffer = bufnr, desc = "Fix All Fixable" })

    vim.keymap.set("n", "<leader>ts", function() 
      api.document_symbols() 
    end, { buffer = bufnr, desc = "Document Symbols" })

    -- Update diagnostics in real time
    vim.api.nvim_create_autocmd("TextChanged", {
      buffer = bufnr,
      callback = function()
        vim.diagnostic.enable(bufnr)
      end
    })

    -- Register TypeScript specific keymaps with which-key if available
    if package.loaded["which-key"] then
      local wk = require("which-key")
      wk.register({
        t = {
          name = "TypeScript",
          o = { api.organize_imports, "Organize Imports" },
          R = { api.rename_file, "Rename File" },
          i = { api.add_missing_imports, "Add Missing Imports" },
          u = { api.remove_unused_imports, "Remove Unused Imports" },
          I = { api.fix_all, "Fix All Fixable" },
          s = { api.document_symbols, "Document Symbols" }
        }
      }, { prefix = "<leader>", buffer = bufnr })
    end
  end,

  settings = {
    -- Enable completion of code snippet parameters
    complete_function_calls = true,
    -- Show diagnostics for all open files in the project
    expose_as_code_action = "all",
    -- Include JSDoc @param tags in completion documentation
    include_completions_with_insert_text = true,
    -- Enable inlay hints
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    },
    tsserver_format_options = {
      allowIncompleteCompletions = false,
      allowRenameOfImportPath = false,
    },
  },
  handlers = {
    -- Enhanced location handling for better navigation
    ["textDocument/definition"] = api.enhanced_definition_handler,
  },
}

-- Let the LSP configuration know we're handling TypeScript
vim.api.nvim_create_autocmd("User", {
  pattern = "TSToolsSetup",
  callback = function()
    vim.g.typescript_tools_loaded = true
  end
})

-- Emit setup completion event
vim.api.nvim_exec_autocmds("User", { pattern = "TSToolsSetup" }) 