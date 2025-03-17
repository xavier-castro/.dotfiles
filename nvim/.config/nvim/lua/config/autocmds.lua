-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc", "markdown" },
  callback = function()
    vim.opt.conceallevel = 0
  end,
})

vim.api.nvim_create_autocmd("BufDelete", {
  group = vim.api.nvim_create_augroup("DashboardOnEmpty", { clear = true }),
  callback = function()
    vim.schedule(function()
      -- Filter for valid and listed buffers with names
      local bufs = vim.tbl_filter(function(buf)
        return vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and vim.api.nvim_buf_get_name(buf) ~= ""
      end, vim.api.nvim_list_bufs())

      -- Open the snacks.dashboard if no buffers remain
      if #bufs == 0 then
        ---@diagnostic disable-next-line: missing-fields
        require("snacks.dashboard").open({
          win = vim.api.nvim_get_current_win(),
        })
      end
    end)
  end,
})

-- Navigate terminal with C-hjkl
local term_augroup = vim.api.nvim_create_augroup("TerminalMappings", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  group = term_augroup,
  callback = function()
    local opts = { buffer = 0, noremap = true, silent = true }
    vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
    vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
    vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
    vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
  end,
})

-- Save and restore folds for specific file types
local fold_persistence = vim.api.nvim_create_augroup("FoldPersistence", { clear = true })

-- Save folds when leaving the buffer
vim.api.nvim_create_autocmd("BufWinLeave", {
  group = fold_persistence,
  pattern = { "*.py", "*.ts", "*.js", "*.tsx", "*.jsx" },
  command = "mkview",
})

-- Load folds when entering the buffer
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = fold_persistence,
  pattern = { "*.py", "*.ts", "*.js" },
  command = "silent! loadview",
})
