---@diagnostic disable: undefined-global
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
         lazypath})
end
vim.opt.rtp:prepend(lazypath)

if vim.g.vscode then
    require("vscode.vscode-options")
    require("vscode.vscode-maps")
    -- require("lazy").setup({{"tpope/vim-surround"}, {"tpope/vim-repeat"}, {"tpope/vim-commentary"}, {
    --     "phaazon/hop.nvim",
    --     branch = "v2",
    --     config = function()
    --         local keymap = vim.api.nvim_set_keymap
    --         local opts = {
    --             noremap = true,
    --             silent = true
    --         }
    --         require("hop").setup()

    --         -- key-mappings
    --         keymap("", "s", "<cmd>HopChar1<CR>", opts)
    --         keymap("", "<leader>j", "<cmd>HopLineBC<CR>", opts)
    --         keymap("", "<leader>k", "<cmd>HopLineAC<CR>", opts)
    --         keymap("", "<leader><leader>j", "<cmd>HopWordBC<CR>", opts)
    --         keymap("", "<leader><leader>k", "<cmd>HopWordAC<CR>", opts)

    --         -- highlights
    --         vim.api.nvim_exec([[
    --  highlight HopNextKey gui=bold guifg=#ff007c guibg=None
    --  highlight HopNextKey1 gui=bold guifg=#00dfff guibg=None
    --  highlight HopNextKey2 guifg=#2b8db3 guibg=None
    --  ]], false)
    --     end
    -- }})
else
    require("lazy").setup("xavier.plugins", opts)
end
