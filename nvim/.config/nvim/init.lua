vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.have_transparent_bg = true

-- PLUGIN MANAGER

require("config.lazy")

-- LANGUAGE SERVER PROTOCOL

-- LSP-based completion support
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end
})

require("config.options")
require("config.remaps")
require("config.autocommands")

-- Control LSP support by filetype
vim.lsp.enable({
  -- 'javascript',
  'tsgo',
  'cds',
  'lua',
  'pyright',
})


-- FILETYPES

vim.filetype.add({ extension = { cds = 'cds' } })
vim.filetype.add({ extension = { mdx = 'mdx' } })
