-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local copilot_on = true
vim.api.nvim_create_user_command("CopilotToggle", function()
  if copilot_on then
    vim.cmd("Copilot disable")
    print("Copilot OFF")
  else
    vim.cmd("Copilot enable")
    print("Copilot ON")
  end
  copilot_on = not copilot_on
end, { nargs = 0 })
vim.keymap.set("", "<M-\\>", ":CopilotToggle<CR>", { noremap = true, silent = true })

-- vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
--   group = vim.api.nvim_create_augroup("SnacksHighlight", { clear = true }),
--   callback = function()
--     vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#212121" })
--   end,
-- })
