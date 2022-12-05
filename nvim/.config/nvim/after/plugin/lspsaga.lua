local saga = require 'lspsaga'
local Remap = require 'xavier.keymap'

saga.init_lsp_saga()

-- Normal
Remap.nnoremap("<leader>ca", "<cmd>Lspsaga code_action<cr>") -- Code Action
Remap.nnoremap("gr", "<cmd>Lspsaga rename<cr>") -- Rename
Remap.nnoremap("gd", "<cmd>Lspsaga peek_definitions<CR>") -- Supports C-t jump back
Remap.nnoremap("K", "<cmd>Lspsaga hover_doc<cr>")
Remap.nnoremap("<leader>o", "<cmd>LSoutlineToggle<CR>") -- Outline

-- Only navigate through errors
Remap.nnoremap("]E", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end)
Remap.nnoremap("[E", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)

-- Insert
Remap.inoremap("<C-k>", "<Cmd>Lspsaga signature_help<cr>")
