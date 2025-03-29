local M = {}

-- LSP on_attach function
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Define key mappings specific to LSP
  local map = function(mode, key, cmd, desc)
    vim.keymap.set(mode, key, cmd, { noremap = true, silent = true, buffer = bufnr, desc = "LSP: " .. desc })
  end

  -- LSP navigation and information
  map('n', 'gD', vim.lsp.buf.declaration, "Go to declaration")
  map('n', 'gi', vim.lsp.buf.implementation, "Go to implementation")
  map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, "Add workspace folder")
  map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
  map('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "List workspace folders")
  map('n', '<space>D', vim.lsp.buf.type_definition, "Type definition")
  map('n', '<space>rn', vim.lsp.buf.rename, "Rename")
  map('n', '<space>f', function() vim.lsp.buf.format { async = true } end, "Format")

  -- Use Lspsaga for enhanced UI
  map('n', 'gh', '<cmd>Lspsaga finder<CR>', "Symbol finder")
  map('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', "Go to definition")
  map('n', 'gp', '<cmd>Lspsaga peek_definition<CR>', "Peek definition")
  map('n', 'gr', '<cmd>Lspsaga rename<CR>', "Rename")
  map('n', 'ga', '<cmd>Lspsaga code_action<CR>', "Code action")
  map('n', 'gl', '<cmd>Lspsaga show_line_diagnostics<CR>', "Line diagnostics")
  map('n', 'K', '<cmd>Lspsaga hover_doc<CR>', "Hover documentation")
  map('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', "Previous diagnostic")
  map('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', "Next diagnostic")
  map('n', '<F12>', '<cmd>Lspsaga outline<CR>', "Toggle outline")
end

-- Initialize LSP config
function M.setup()
  -- Configure diagnostics display
  vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })

  -- Set up lspconfig
  local lspconfig = require('lspconfig')
  
  -- Set up capabilities (use nvim-cmp capabilities if available)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  if has_cmp then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  end

  -- Set up Mason integration if available
  local has_mason, mason_lspconfig = pcall(require, 'mason-lspconfig')
  if has_mason then
    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
    })
  else
    -- If mason isn't available, configure some common LSPs directly
    local servers = { 'pyright', 'tsserver', 'rust_analyzer', 'lua_ls' }
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end
  end
end

M.setup()

return M