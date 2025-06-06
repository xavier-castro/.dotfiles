-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- XC
vim.keymap.set("i", "jk", "<C-c>")

vim.keymap.set("n", "<leader>lf", function()
  require("conform").format({ async = false, lsp_format = "fallback", timeout_ms = 5000 })
end)
vim.keymap.set("v", "<leader>lf", function()
  require("conform").format({ async = false, lsp_format = "fallback", timeout_ms = 5000 })
end)
