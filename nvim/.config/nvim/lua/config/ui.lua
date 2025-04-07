vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd [[highlight CursorLine guibg=#383a4a ctermbg=290]]
  end
})

local save_fold = vim.api.nvim_create_augroup('save_fold', {})

vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = "*.*",
  callback = function()
    vim.cmd.mkview()
  end,
  group = save_fold,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*.*",
  callback = function()
    vim.cmd.loadview({ mods = { emsg_silent = true } })
  end,
  group = save_fold,
})
