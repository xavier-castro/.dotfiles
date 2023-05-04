local keymap = vim.api.nvim_set_keymap
local opts = {
	noremap = true,
	silent = true,
}
require("hop").setup()

-- key-mappings
keymap("", "s", "<cmd>HopChar1<CR>", opts)
keymap("", "<leader>j", "<cmd>HopWordBC<CR>", opts)
keymap("", "<leader>k", "<cmd>HopWordAC<CR>", opts)

-- highlights
vim.cmd([[
  highlight HopNextKey gui=bold guifg=#ff007c guibg=None
  highlight HopNextKey1 gui=bold guifg=#00dfff guibg=None
  highlight HopNextKey2 guifg=#2b8db3 guibg=None
]])
