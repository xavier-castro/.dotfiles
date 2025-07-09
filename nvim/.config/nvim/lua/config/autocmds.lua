-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local augroup = vim.api.nvim_create_augroup
local XavierGroup = augroup("Xavier", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
  require("plenary.reload").reload_module(name)
end

vim.filetype.add({
  extension = {
    templ = "templ",
  },
})

autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

autocmd({ "BufWritePre" }, {
  group = XavierGroup,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Go to the last cursor position when reopening buffer
autocmd("BufReadPost", {
  group = xavierGroup,
  desc = "Restore last cursor position",
  callback = function()
    vim.defer_fn(function()
      if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
        vim.cmd('normal! g`"')
      end
    end, 0)
  end,
})

-- Enable fenced code highlighting for markdown
vim.g.markdown_fenced_languages = { "html", "javascript", "typescript", "vim", "lua", "css" }

-- Clear NeoCodeium suggestions when CMP menu opens
autocmd("User", {
  group = XavierGroup,
  pattern = "BlinkCmpMenuOpen",
  desc = "Clear NeoCodeium when CMP menu opens",
  callback = function()
    local ok, neocodeium = pcall(require, "neocodeium")
    if ok then
      neocodeium.clear()
    end
  end,
})

-- Disable auto-commenting on newline
autocmd("FileType", {
  pattern = "*",
  group = XavierGroup,
  desc = "Disable auto comment on new lines",
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})
