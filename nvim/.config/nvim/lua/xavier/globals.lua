function ColorMyPencils(color)
  color = color or "plain"
  vim.cmd("colorscheme " .. color)
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- Define a command to call the ColorMyPencils function
vim.api.nvim_command('command! ColorMyPencils lua ColorMyPencils()')

