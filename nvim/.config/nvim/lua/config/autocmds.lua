-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Define Copilot highlights
local copilot_highlights = vim.api.nvim_create_augroup("CopilotHighlights", { clear = true })
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  group = copilot_highlights,
  callback = function()
    vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#585858" })
    vim.api.nvim_set_hl(0, "CopilotAnnotation", { fg = "#585858" })
  end,
})

-- Run ColorMyPencils on startup
local color_setup = vim.api.nvim_create_augroup("ColorSetup", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  group = color_setup,
  callback = function()
    -- Call the ColorMyPencils function which is globally defined in colors.lua
    -- This will be available after colors.lua is loaded by lazy.nvim
    if ColorMyPencils then
      ColorMyPencils()
    end
  end,
})
